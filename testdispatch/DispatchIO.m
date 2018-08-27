//
//  DispatchIO.m
//  testdispatch
//
//  Created by ky on 2018/8/7.
//  Copyright © 2018 yellfun. All rights reserved.
//

#import "DispatchIO.h"

@implementation DispatchIO

static void test_async_read(char *path, size_t size, int option, dispatch_queue_t queue, void (^process_data)(size_t)){
  
  int fd = open(path, O_RDONLY);
  if (fd == -1) {
    
    test_errno("Failed to open file", errno, 0);
    test_stop();
  }
  // disable caching also for extra fd opened by dispatch_io_create_with_path
  if (fcntl(fd, F_GLOBAL_NOCACHE, 1) == -1) {
    test_errno("fcntl F_GLOBAL_NOCACHE", errno, 0);
    test_stop();
  }
  switch (option) {
    case DISPATCH_ASYNC_READ_ON_CONCURRENT_QUEUE:
    case DISPATCH_ASYNC_READ_ON_SERIAL_QUEUE:
      dispatch_async(queue, ^{
        char* buffer = valloc(size);
        ssize_t r = read(fd, buffer, size);
        if (r == -1) {
          test_errno("async read error", errno, 0);
          test_stop();
        }
        free(buffer);
        close(fd);
        process_data(r);
      });
      break;
    case DISPATCH_READ_ON_CONCURRENT_QUEUE:
      dispatch_read(fd, size, queue, ^(dispatch_data_t d, int error) {
        if (error) {
          test_errno("dispatch_read error", error, 0);
          test_stop();
        }
        close(fd);
        process_data(dispatch_data_get_size(d));
      });
      break;
    case DISPATCH_IO_READ_ON_CONCURRENT_QUEUE:
    case DISPATCH_IO_READ_FROM_PATH_ON_CONCURRENT_QUEUE: {
      __block bool is_done = false;
      __block dispatch_data_t d = dispatch_data_empty;
      
      dispatch_io_t io = dispatch_io_create_with_path(DISPATCH_IO_RANDOM, path,
                                                      O_RDONLY, 0, queue, cleanup_handler);
      // Timeout after 20 secs
      dispatch_io_set_interval(io, 20 * NSEC_PER_SEC, DISPATCH_IO_STRICT_INTERVAL);
      
      dispatch_io_read(io, 0, size, queue, ^(bool done, dispatch_data_t data, int error) {
        if (!done && !error && !dispatch_data_get_size(data)) {
          // Timer fired, and no progress from last delivery
          dispatch_io_close(io, DISPATCH_IO_STOP);
        }
        
        if (data) {
          
          dispatch_data_t c = dispatch_data_create_concat(d, data);
          
          dispatch_release(d);
          
          d = c;
        }
        
        if (error) {
          
          test_errno("dispatch_io_read error", error, 0);
          
          if (error != ECANCELED) {
            
            test_stop();
          }
        }
        
        is_done = done;
      });
      dispatch_release(io);
      break;
    }
  }
}


@end
