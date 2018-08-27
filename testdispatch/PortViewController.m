//
//  PortViewController.m
//  testdispatch
//
//  Created by ky on 2018/7/14.
//  Copyright © 2018 yellfun. All rights reserved.
//

#import "PortViewController.h"
#import "Worker.h"
#import "TestMetaClass.h"
#import <objc/runtime.h>

@interface PortViewController ()<NSPortDelegate>

@property (nonatomic, strong) Worker *worker;
@property (nonatomic) NSPort* removePort;
@property (nonatomic, assign) NSInteger value;

@end

@implementation PortViewController

- (void)viewDidLoad {
  
  [super viewDidLoad];
  
  [self setup];
  
  [self setupRunloopObserver];
  
  id t = [T3 new];
  
  Class a = object_getClass(t);
  
  NSLog(@"%@", a);
  
  Class b = objc_getMetaClass(object_getClassName(a));
  
  NSLog(@"%@", b);
  
  Class c = objc_getMetaClass(object_getClassName(b));
  
  NSLog(@"%@", c);
  
  [T3 do2];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(nullable UIEvent *)event {
  
  NSLog(@"touchesBegan");
}

- (void)setup {
  
  _value = 100;
  
  _worker = [[Worker alloc] init];
  
  NSPort *port = [NSMachPort port];
  
  [port setDelegate:self];
  
  [[NSRunLoop currentRunLoop] addPort:port forMode:NSDefaultRunLoopMode];
  
//  NSThread *thread = [[NSThread alloc] initWithTarget:_worker selector:@selector(start:) object:port];
  
//  thread.name = @"worker_thread";
  
//  [thread start];
  
  NSLog(@"%@", [[NSRunLoop currentRunLoop] currentMode]);
}

- (void)setupRunloopObserver {
  
  Worker *worker = [[Worker alloc] init];
  
  dispatch_async(dispatch_get_main_queue(), ^{
    
    NSLog(@"OKD");
  });
  
  NSLog(@"zz");
  
  dispatch_async(dispatch_get_global_queue(QOS_CLASS_DEFAULT, 0), ^{
    
    [self doCallPerform];
  });
  
//  CFRunLoopObserverRef observer = CFRunLoopObserverCreateWithHandler(NULL, kCFRunLoopAllActivities, YES, 0, ^(CFRunLoopObserverRef observer, CFRunLoopActivity activity) {
//
//    NSLog(@"当前的activity = %d", (int)activity);
//  });
//
//  CFRunLoopAddObserver([NSRunLoop currentRunLoop].getCFRunLoop, observer, kCFRunLoopDefaultMode);
}

- (void)doCallPerform {
  
  [self performSelector:@selector(doShow) withObject:nil afterDelay:1];
}

- (void)doShow {
  
  NSLog(@"doShow----------");
}

- (void)handlePortMessage:(NSObject *)message {
  
  NSLog(@"receive message");
  
  _removePort = [message valueForKey:@"remotePort"];

  NSInteger msgid = [[message valueForKey:@"msgid"] integerValue];
  
  if (msgid == 100) {
    
    [_removePort sendBeforeDate:[NSDate dateWithTimeIntervalSinceNow:1] msgid:9999 components:nil from:nil reserved:0];
  }
  else {
    
    [_removePort sendBeforeDate:[NSDate dateWithTimeIntervalSinceNow:1] msgid:888 components:nil from:nil reserved:0];
  }
}

- (IBAction)doButtonClick:(id)sender {
  
  
}

@end
