
//
//  RunLoopViewController.m
//  testdispatch
//
//  Created by ky on 2018/7/13.
//  Copyright © 2018 yellfun. All rights reserved.
//

#import "RunLoopViewController.h"

@interface RunLoopViewController () <NSPortDelegate>

@property(nonatomic) NSThread *thread;
@property(nonatomic) NSPort *threadport;

@end

@implementation RunLoopViewController

- (void)viewDidLoad {

  [super viewDidLoad];
  
  [self setup];
}

- (void)setup {
  
  NSLog(@"%@", [NSRunLoop currentRunLoop].currentMode);
  
  NSString *modeName = @"My_Run_Loop_Mode";
  
  CFRunLoopAddCommonMode(NSRunLoop.currentRunLoop.getCFRunLoop, (__bridge CFStringRef)modeName);
  
  _threadport = [NSMachPort port];
  
  [_threadport setDelegate:self];
  
  [[NSRunLoop currentRunLoop] addPort:_threadport forMode:NSRunLoopCommonModes];
  
  NSData *data = [[NSString stringWithFormat:@"abcd"] dataUsingEncoding:NSUTF8StringEncoding];
  
  [_threadport sendBeforeDate:[NSDate dateWithTimeIntervalSinceNow:1] msgid:102 components:[NSMutableArray arrayWithObjects:data, nil] from:_threadport reserved:0];
  
  _thread = [[NSThread alloc] initWithTarget:self selector:@selector(threadTest:) object:_threadport];
  
  [_thread setName:@"test_thread"];
  
  [_thread start];
}

- (void)handlePortMessage:(NSObject *)message {
  
  NSInteger msgid = [[message valueForKeyPath:@"msgid"] integerValue];
  
  NSLog(@"receive message %d %@", (int)msgid, [NSThread currentThread].name);
}

- (void)threadTest:(NSMachPort*)port {
  
  NSLog(@"%@",@"child thread start");
  
  NSLog(@"%@", [NSThread currentThread]);
  
  [[NSRunLoop currentRunLoop] addPort:port forMode:NSDefaultRunLoopMode];

  [[NSRunLoop currentRunLoop] runUntilDate:[NSDate dateWithTimeIntervalSinceNow:10]];
  
  NSData *data = [[NSString stringWithFormat:@"abcd"] dataUsingEncoding:NSUTF8StringEncoding];
  
  [port sendBeforeDate:[NSDate dateWithTimeIntervalSinceNow:1] msgid:101 components:[NSMutableArray arrayWithObjects:data, nil] from:_threadport reserved:0];
}

- (void)receiveMsg:(NSString*)str {
  
  NSLog(@"receive msg %@", str);
}

- (void)receiveMsgAgain:(NSString*)str {
  
  NSLog(@"receive msg again %@", str);
}

@end
