//
//  DispatchSemaphoreViewController.m
//  testdispatch
//
//  Created by ky on 2018/7/15.
//  Copyright © 2018 yellfun. All rights reserved.
//

#import "DispatchSemaphoreViewController.h"

@interface DispatchSemaphoreViewController ()

@property(nonatomic) dispatch_semaphore_t semaphore;

@end

@implementation DispatchSemaphoreViewController

- (void)viewDidLoad {
  
  [super viewDidLoad];
  
  [self setupSemaphore];
}

- (void)didReceiveMemoryWarning {
  
  [super didReceiveMemoryWarning];
}

- (void)setupSemaphore {
  
  _semaphore = dispatch_semaphore_create(0);
  
  NSLog(@"a");
  
  dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 1 * NSEC_PER_SEC), dispatch_get_global_queue(QOS_CLASS_DEFAULT, 0), ^{
    
    dispatch_semaphore_signal(self.semaphore);
    
    NSLog(@"zz");
  });
  
  long value = dispatch_semaphore_wait(_semaphore, DISPATCH_TIME_FOREVER);
  
  if (value == 0) {
    
    NSLog(@"wait return");
  }
  else {
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 1 * NSEC_PER_SEC), dispatch_get_global_queue(QOS_CLASS_DEFAULT, 0), ^{
      
      dispatch_semaphore_signal(self.semaphore);
    });
  }
}

@end
