//
//  RrunLoopSource.m
//  testdispatch
//
//  Created by ky on 2018/7/16.
//  Copyright © 2018 yellfun. All rights reserved.
//

#import "RunLoopSource.h"
#import "AppDelegate.h"
#import "RunLoopContext.h"

@implementation RunLoopSource

- (id)init {
  
  self = [super init];
  
  CFRunLoopSourceContext context = {0, (__bridge void *)(self), NULL, NULL, NULL, NULL, NULL,
    RunLoopSourceScheduleRoutine,
    RunLoopSourceCancelRoutine,
    RunLoopSourcePerformRoutine
  };
  
  self.runloopSource = CFRunLoopSourceCreate(NULL, 0, &context);
  
  _commands = [[NSMutableArray alloc] init];
  
  return self;
}

- (void)addToCurrentRunLoop {
  
  CFRunLoopRef runloop = CFRunLoopGetCurrent();
  
  NSString *runloopmode = @"my_run_loop";
  
  CFRunLoopAddSource(runloop, _runloopSource, (__bridge CFStringRef)runloopmode);
}

- (void)fireCommandsOnRunLoop:(CFRunLoopRef)runloop {
  
  CFRunLoopSourceSignal(_runloopSource);
  
  CFRunLoopWakeUp(runloop);
}

- (void)sourceFired {
  
  NSLog(@"sourceFired");
}

@end

void RunLoopSourceScheduleRoutine(void *info, CFRunLoopRef rl, CFStringRef mode) {
  
  RunLoopSource *obj = (__bridge RunLoopSource*)info;
  
  UIApplication *app = [UIApplication sharedApplication];
  
  RunLoopContext *theContext = [[RunLoopContext alloc] initWithSource:obj addLoop:rl];
  
  [app performSelectorOnMainThread:@selector(registerSource:) withObject:theContext waitUntilDone:NO];
}

void RunLoopSourcePerformRoutine(void *info) {
  
  RunLoopSource* obj = (__bridge RunLoopSource*)info;
  
  [obj sourceFired];
}

void RunLoopSourceCancelRoutine(void *info, CFRunLoopRef rl, CFStringRef mode) {
  
  RunLoopSource* obj = (__bridge RunLoopSource*)info;
  
  UIApplication* app = [UIApplication sharedApplication];
  
  RunLoopContext* theContext = [[RunLoopContext alloc] initWithSource:obj addLoop:rl];
  
  [app performSelectorOnMainThread:@selector(removeSource:) withObject:theContext waitUntilDone:YES];
}

