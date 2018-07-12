//
//  MachPortViewController.m
//  testdispatch
//
//  Created by ky on 2018/7/12.
//  Copyright © 2018 yellfun. All rights reserved.
//

#import "MachPortViewController.h"
#import "MyWorkerClass.h"

@interface MachPortViewController ()<NSMachPortDelegate>

@end

@implementation MachPortViewController

- (void)viewDidLoad {
  
  [super viewDidLoad];
  
  NSPort *machPort = [NSMachPort port];
  
  [machPort setDelegate:self];
  
  MyWorkerClass *work = [[MyWorkerClass alloc] init];
  
  [[NSRunLoop currentRunLoop] addPort:machPort forMode:NSDefaultRunLoopMode];
  
  [NSThread detachNewThreadSelector:@selector(start:) toTarget:work withObject:machPort];
}

- (void)handleMachMessage:(void *)msg {
  
  NSLog(@"view controller receive msg");
}

@end
