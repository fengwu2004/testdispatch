//
//  dispatchSourceViewController.m
//  testdispatch
//
//  Created by ky on 2018/7/6.
//  Copyright © 2018 yellfun. All rights reserved.
//

#import "dispatchSourceViewController.h"

@interface dispatchSourceViewController ()

@property(nonatomic) dispatch_source_t source;

@end

@implementation dispatchSourceViewController

- (void)viewDidLoad {
  
  [super viewDidLoad];
  
  [self testFileWrite];
}

- (void)timerDispatchSource {
  
  _source = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, dispatch_get_global_queue(QOS_CLASS_DEFAULT, 0));
  
  if (_source) {
    
    dispatch_time_t time = dispatch_time(DISPATCH_TIME_NOW, 0 * NSEC_PER_SEC);
    
    dispatch_source_set_timer(_source, time, 1000 * NSEC_PER_MSEC, 1);
    
    dispatch_source_set_event_handler(_source, ^{
      
      NSLog(@"acb");
    });
    
    dispatch_activate(_source);
  }
  
  dispatch_source_set_cancel_handler(_source, ^{
    
    NSLog(@"cancel");
  });
  
  uintptr_t handle = dispatch_source_get_handle(_source);
  
  NSLog(@"%ld", handle);
  
  dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1000 * NSEC_PER_MSEC)), dispatch_get_global_queue(QOS_CLASS_DEFAULT, 0), ^{
    
    dispatch_source_cancel(_source);
  });
}

- (void)signalDispatchSource {
  
  signal(SIGCHLD, SIG_IGN);
  
  dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
  
  _source = dispatch_source_create(DISPATCH_SOURCE_TYPE_SIGNAL, SIGCHLD, 0, queue);
  
  if (_source){
    
    dispatch_source_set_event_handler(_source, ^{
      
      static NSInteger i = 0;
      
      ++i;
      
      NSLog(@"Signal Detected: %ld",i);
    });
    
    dispatch_source_set_cancel_handler(_source, ^{
      
      NSLog(@"Signal canceled");
    });
    
    dispatch_activate(_source);
  }
}

int n = 0;

size_t MyGetData(void* buffer, size_t size) {
  
  memcpy(buffer, "abcdefghijklmnopqrstuvwxyz", 26 * 1000);
  
  return 26;
}

size_t MyGetDataSize() {
  
  n++;
  
  return 100;
}

- (void)testFileWrite {
  
  NSString *filePath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
  
  NSString *fileName = [filePath stringByAppendingString:@"/test.txt"];
  
  int fd = open([fileName UTF8String], O_WRONLY | O_CREAT | O_TRUNC, S_IRUSR | S_IWUSR | S_ISUID | S_ISGID);
  
  fcntl(fd, F_SETFL);
  
  _source = dispatch_source_create(DISPATCH_SOURCE_TYPE_WRITE, fd, 0, dispatch_get_global_queue(QOS_CLASS_DEFAULT, 0));
  
  dispatch_source_set_event_handler(_source, ^{
    
    size_t bufferSize = MyGetDataSize();
    
    void* buffer = malloc(bufferSize);
    
    size_t actual = MyGetData(buffer, bufferSize);
    
    write(fd, buffer, actual);
    
    free(buffer);
    
    if (n >= 1000000)
    {
      dispatch_source_cancel(self.source);
    }
  });
  
  dispatch_source_set_cancel_handler(_source, ^{
    
    NSLog(@"Write to file Canceled");
    
    close(fd);
  });
  
  dispatch_activate(_source);
}

- (void)testDipatchSourceMemory {
  
  _source = dispatch_source_create(DISPATCH_SOURCE_TYPE_MEMORYPRESSURE, 0, DISPATCH_MEMORYPRESSURE_CRITICAL, dispatch_get_global_queue(QOS_CLASS_DEFAULT, 0));
  
  dispatch_source_set_event_handler(_source, ^{
    
    unsigned long value = dispatch_source_get_data(self.source);
    
    NSLog(@"内存紧张 %ld", value);
  });
  
  dispatch_activate(_source);
}

- (void)testDispatchSourceAdd {
  
  dispatch_queue_t queue = dispatch_get_global_queue(QOS_CLASS_DEFAULT, 0);
  
  _source = dispatch_source_create(DISPATCH_SOURCE_TYPE_DATA_REPLACE, 0, 0, queue);
  
  dispatch_source_set_event_handler(_source, ^{
    
    unsigned long data = dispatch_source_get_data(self.source);
    
    NSLog(@"source %ld", data);
  });
  
//  dispatch_source_merge_data(self.source, 1);
  
  dispatch_activate(_source);
  
  dispatch_source_set_registration_handler(self.source, ^{
    
    NSLog(@"启动");
  });
  
  NSLog(@"启动111");
  
//  dispatch_apply(100, queue, ^(size_t index) {
//
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 1 * index * NSEC_PER_MSEC), queue, ^{
//
//      dispatch_source_merge_data(self.source, 1 * index);
//    });
//  });
}

- (void)didReceiveMemoryWarning {
  
  NSLog(@"didReceiveMemoryWarning");
  
  [super didReceiveMemoryWarning];
}

@end
