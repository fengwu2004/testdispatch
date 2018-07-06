//
//  dispatchSourceViewController.m
//  testdispatch
//
//  Created by ky on 2018/7/6.
//  Copyright © 2018 yellfun. All rights reserved.
//

#import "dispatchSourceViewController.h"

@interface dispatchSourceViewController ()

@property(nonatomic) dispatch_source_t sourcetimer;

@end

@implementation dispatchSourceViewController

- (void)viewDidLoad {

  [super viewDidLoad];
  
  [self timerDispatchSource];
}

- (void)timerDispatchSource {
  
  _sourcetimer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, dispatch_get_global_queue(QOS_CLASS_DEFAULT, 0));
  
  __block int i = 0;
  
  if (_sourcetimer) {
    
    dispatch_time_t time = dispatch_time(DISPATCH_TIME_NOW, 0 * NSEC_PER_SEC);
    
    dispatch_source_set_timer(_sourcetimer, time, 1 * NSEC_PER_MSEC, 1);
    
    dispatch_source_set_event_handler(_sourcetimer, ^{
      
      NSLog(@"%d", i);
      
      ++i;
    });
    
    dispatch_activate(_sourcetimer);
  }
  
  dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1000 * NSEC_PER_MSEC)), dispatch_get_global_queue(QOS_CLASS_DEFAULT, 0), ^{
    
    dispatch_suspend(_sourcetimer);
  });
}

- (void)didReceiveMemoryWarning {

  [super didReceiveMemoryWarning];
}

@end
