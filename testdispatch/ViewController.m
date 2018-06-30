//
//  ViewController.m
//  testdispatch
//
//  Created by ky on 2018/6/30.
//  Copyright © 2018 yellfun. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
  
  [super viewDidLoad];
}

- (void)viewDidAppear:(BOOL)animated {
  
  [super viewDidAppear:animated];
  
  [self testSerialQueue];
}

- (void)testSerialQueue {
  
  dispatch_queue_attr_t attr = dispatch_queue_attr_make_with_qos_class(DISPATCH_QUEUE_SERIAL, QOS_CLASS_USER_INITIATED, 0);
  
  dispatch_queue_t mainQueue = dispatch_get_main_queue();
  
  dispatch_queue_t concurrentQueue = dispatch_queue_create("concurrent_queue", DISPATCH_QUEUE_CONCURRENT);
  
  dispatch_queue_t serialQueue = dispatch_queue_create("serial_queue", attr);
  
  dispatch_async(mainQueue, ^{

    NSLog(@"1");
  });

//  dispatch_async(serialQueue, ^{
//
//    NSLog(@"2");
//  });
//
//  dispatch_async(serialQueue, ^{
//
//    NSLog(@"3");
//  });
//
//  dispatch_async(serialQueue, ^{
//
//    NSLog(@"4");
//  });
//
//  dispatch_async(serialQueue, ^{
//
//    NSLog(@"5");
//  });
//
//  dispatch_async(serialQueue, ^{
//
//    NSLog(@"6");
//  });
  
  NSLog(@"finish");
}

- (void)didReceiveMemoryWarning {
  
  [super didReceiveMemoryWarning];
}


@end
