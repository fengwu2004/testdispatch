//
//  TestDispatchIntrospectionViewController.m
//  testdispatch
//
//  Created by ky on 2018/8/7.
//  Copyright © 2018 yellfun. All rights reserved.
//

#import "TestDispatchIntrospectionViewController.h"
#import <dispatch/introspection.h>

@interface TestDispatchIntrospectionViewController ()

@end

@implementation TestDispatchIntrospectionViewController

- (void)viewDidLoad {
  
  [super viewDidLoad];
  
  dispatch_queue_t queue = dispatch_queue_create("my_queue", DISPATCH_QUEUE_CONCURRENT);
  
  dispatch_after(dispatch_time(DISPATCH_TIME_NOW, NSEC_PER_SEC), queue, ^{
    
    NSLog(@"这是dispatch");
  });
  
  dispatch_introspection_hook_queue_create(queue);
}

- (void)didReceiveMemoryWarning {
  
  [super didReceiveMemoryWarning];
}

@end
