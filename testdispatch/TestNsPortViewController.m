//
//  TestNsPortViewController.m
//  testdispatch
//
//  Created by ky on 2018/7/12.
//  Copyright © 2018 yellfun. All rights reserved.
//

#import "TestNsPortViewController.h"

@interface TestNsPortViewController ()<NSPortDelegate>

@property(nonatomic) NSString* sharestate;

@end

@implementation TestNsPortViewController

- (void)viewDidLoad {
  
  [super viewDidLoad];
  
  _sharestate =@"ASBCDKD";
  
  [self setupPort];
}

- (void)handlePortMessage:(NSPortMessage *)message {
  
  NSLog(@"Hello world %@", _sharestate);
}

- (void)setupPort {
  
  NSPort *port = [NSMachPort port];
  
  [port setDelegate:self];
  
  [[NSRunLoop currentRunLoop] addPort:port forMode:NSRunLoopCommonModes];
  
  [NSThread detachNewThreadSelector:@selector(newThread:) toTarget:self withObject:port];
}

- (void)setupTimer {
  
  NSTimer *timer = [[NSTimer alloc] initWithFireDate:[NSDate dateWithTimeIntervalSinceNow:10] interval:1 repeats:YES block:^(NSTimer * _Nonnull timer) {
    
    NSLog(@"这是timer");
  }];
}

- (void)newThread:(NSMachPort*)port {
  
  if (!port) {
    
    return;
  }
  
  _sharestate = @"sdfsd";
  
  NSPort *selfport = [NSMachPort port];
  
  NSMutableArray *array = [NSMutableArray arrayWithArray:@[selfport]];
  
  [port sendBeforeDate:[NSDate distantFuture] components:array from:nil reserved:0];
  
  NSTimer *timer = [[NSTimer alloc] initWithFireDate:[NSDate dateWithTimeIntervalSinceNow:10] interval:1 repeats:NO block:^(NSTimer * _Nonnull timer) {
  
    NSLog(@"这是timer");
  }];
  
  [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
  
  [[NSRunLoop currentRunLoop] run];
}

- (void)didReceiveMemoryWarning {
  
  [super didReceiveMemoryWarning];
}

@end
