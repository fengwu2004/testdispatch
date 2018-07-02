//
//  ViewController.m
//  testdispatch
//
//  Created by ky on 2018/6/30.
//  Copyright © 2018 yellfun. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property(weak) IBOutlet UILabel *myLable;

@end

@implementation ViewController

- (void)viewDidLoad {
  
  [super viewDidLoad];
}

- (void)viewDidAppear:(BOOL)animated {
  
  [super viewDidAppear:animated];
  
  [self testDispatchBarrier];
}

- (void)testMainThreadAndMainQueue {
  
  dispatch_queue_t lowQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_LOW, 0);
  
  NSLog(@"start");
  
  dispatch_sync(lowQueue, ^{
    
    NSLog(@"主线程 %d", [NSThread isMainThread]);
    
    NSLog(@"process");
  });
  
  NSLog(@"finish");
}

- (void)testNotUpdateUiInMainQueue {
  
  dispatch_queue_attr_t attr = dispatch_queue_attr_make_with_qos_class(DISPATCH_QUEUE_CONCURRENT, QOS_CLASS_USER_INTERACTIVE, 0);
  
  dispatch_queue_t queue = dispatch_queue_create("interactive_concurrent_queue", attr);
  
  dispatch_sync(queue, ^{
    
    [self.myLable setText:@"ABC"];
  });
}

- (void)testDispatchGroup {
  
  dispatch_group_t group = dispatch_group_create();
  
  dispatch_group_enter(group);
  
  dispatch_group_notify(group, dispatch_get_global_queue(QOS_CLASS_DEFAULT, 0), ^{
    
    NSLog(@"finish");
  });
  
  NSLog(@"zz");
  
  dispatch_group_leave(group);
}

- (void)testDispatchBarrier {
  
  dispatch_queue_t queue = dispatch_queue_create("my_queue", DISPATCH_QUEUE_CONCURRENT);
  
  dispatch_group_t group = dispatch_group_create();
  
  dispatch_group_async(group, queue, ^{
    
    dispatch_apply(1, queue, ^(size_t index) {
      
      dispatch_async(queue, ^{
        
        NSLog(@"test");
      });
      
      NSLog(@"%d", (int)index);
    });
  });
  
  dispatch_barrier_async(queue, ^{
    
    NSLog(@"all finish");
  });
  
  dispatch_group_notify(group, queue, ^{
    
    NSLog(@"group finish");
  });
  
  NSLog(@"zz");
}

- (void)testTargetQueue {
  
  dispatch_queue_t serialQueue = dispatch_queue_create("serialQueue", 0);
  
  dispatch_queue_t concurrentTargetQueue = dispatch_queue_create("concurrentTargetQueue", DISPATCH_QUEUE_CONCURRENT);

  dispatch_queue_t concurrentQueue0 = dispatch_queue_create("concurrentQueue0", DISPATCH_QUEUE_CONCURRENT);
  
  dispatch_queue_t concurrentQueue = dispatch_queue_create("concurrentQueue1", DISPATCH_QUEUE_CONCURRENT);
  
  dispatch_set_target_queue(concurrentQueue, concurrentTargetQueue);
  
  dispatch_async(concurrentQueue, ^{
    
    NSLog(@"0");
  });
  
  dispatch_async(concurrentQueue, ^{
    
    NSLog(@"1");
  });
  
  dispatch_async(concurrentQueue, ^{
    
    NSLog(@"2");
  });
  
  dispatch_async(concurrentQueue, ^{
    
    NSLog(@"3");
  });
  
  dispatch_async(concurrentQueue, ^{
    
    NSLog(@"4");
  });
  
  dispatch_async(concurrentQueue, ^{
    
    NSLog(@"5");
  });
  
  dispatch_async(concurrentQueue, ^{
    
    NSLog(@"6");
  });
  
  dispatch_set_target_queue(concurrentQueue0, concurrentTargetQueue);
  
  dispatch_async(concurrentQueue0, ^{
    
    NSLog(@"ok");
  });
}

- (void)doSomeTest {
  
  dispatch_queue_t mainQueue = dispatch_get_main_queue();
  
  dispatch_block_t block = ^{
    
    NSLog(@"main thread %d", [NSThread isMainThread]);
  };
           
  dispatch_queue_t globalQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
  
  dispatch_async(globalQueue, ^{
    
    dispatch_async(mainQueue, block);
  });
  
  dispatch_main();
  
  NSLog(@"do something");
}

- (void)testSpecific {
  
  dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
  
  const char *key = "my_queue_key";
  
  dispatch_queue_set_specific(queue, key, "my_queue_context", NULL);
  
  dispatch_async(queue, ^{
    
    const char *context = dispatch_get_specific(key);
    
    if (context) {
      
      printf("%s", context);
    }

    NSLog(@"ok");
  });
}

- (void)testSerialQueue {
  
  dispatch_queue_attr_t attr = dispatch_queue_attr_make_with_qos_class(DISPATCH_QUEUE_SERIAL, QOS_CLASS_USER_INITIATED, 0);
  
  dispatch_queue_t mainQueue = dispatch_get_main_queue();
  
  dispatch_queue_t concurrentQueue = dispatch_queue_create("concurrent_queue", DISPATCH_QUEUE_CONCURRENT);
  
  dispatch_queue_t serialQueue = dispatch_queue_create("serial_queue", attr);
  
  dispatch_async(serialQueue, ^{

    NSLog(@"1");
  });
  
  dispatch_main();

  NSLog(@"finish");
}

- (void)didReceiveMemoryWarning {
  
  [super didReceiveMemoryWarning];
}


@end
