//
//  WorkingThread.m
//  testdispatch
//
//  Created by ky on 2018/7/14.
//  Copyright © 2018 yellfun. All rights reserved.
//

#import "Worker.h"
#import <objc/objc.h>

typedef void (^success)(NSInteger value);

@interface Worker()<NSPortDelegate>

@property(nonatomic) NSPort *remotePort;
@property(nonatomic) NSThread *thread;
@property(nonatomic) NSPort *myPort;
@property(nonatomic) CFRunLoopObserverRef runloopobserver;
@end

@implementation Worker

- (void)start:(NSPort*)remotePort {
  
  NSLog(@"worker start");
  
  [self setupRunloopObserver];
  
  _remotePort = remotePort;
  
  _myPort = [NSMachPort port];
  
  [_myPort setDelegate:self];
  
  [_remotePort sendBeforeDate:[NSDate dateWithTimeIntervalSinceNow:0] msgid:100 components:nil from:_myPort reserved:0];
  
  [[NSRunLoop currentRunLoop] addPort:_myPort forMode:NSDefaultRunLoopMode];
  
  [[NSRunLoop currentRunLoop] run];
  
  NSLog(@"exit");
}

void myRunLoopObserverFunc(CFRunLoopObserverRef observer, CFRunLoopActivity activity, void *info) {
  
  NSLog(@"myRunLoopObserverFunc %d", (int)activity);
}

- (void)setupRunloopObserver {
  
  NSRunLoop *runloop = [NSRunLoop currentRunLoop];
  
  _runloopobserver = CFRunLoopObserverCreate(NULL, kCFRunLoopAllActivities, YES, 0, myRunLoopObserverFunc, NULL);
  
  CFRunLoopAddObserver([runloop getCFRunLoop], _runloopobserver, kCFRunLoopDefaultMode);
}

- (void)handlePortMessage:(NSObject *)message {
  
  NSLog(@"当前的mode=%@", [NSRunLoop currentRunLoop].currentMode);
  
  NSLog(@"worker receive message");
}

- (void)display:(Worker __weak *)value {
  
  [value do];
}

- (void)do {
  
  NSLog(@"abcd");
}

- (void)dealloc {
  
  NSLog(@"dealloc abc");
}

- (void)doSomeThingSpecial:(Worker**)worker {
  
  [self do];
  
  *worker = [[Worker alloc] init];
  
  NSLog(@"finish");
}

+ (id)worker {
  
  id obj = [[Worker alloc] init];

  return obj;
}

+ (void)display {
  
  NSLog(@"调用静态函数");
}

@end

@implementation Coder

- (void)testsomething {
  
}

@end

@implementation JavaCoder

static int svalue = 100;

+ (void)whatisSelf {
  
  NSLog(@"%d", sizeof(self));
}

@end
