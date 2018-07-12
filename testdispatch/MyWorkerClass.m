//
//  MyWorkerClass.m
//  testdispatch
//
//  Created by ky on 2018/7/12.
//  Copyright © 2018 yellfun. All rights reserved.
//

#import "MyWorkerClass.h"

@interface MyWorkerClass()<NSMachPortDelegate>

@property(nonatomic) NSPort *remotePort;
@property(nonatomic) NSPort *localPort;

@end

@implementation MyWorkerClass

- (void)handleMachMessage:(void *)msg {
  
  
}

- (void)start:(id)object {
  
  _remotePort = object;
  
  _localPort = [NSMachPort port];
  
  [_remotePort sendBeforeDate:[NSDate date] components:nil from:_localPort reserved:0];
  
  [[NSRunLoop currentRunLoop] addPort:_localPort forMode:NSDefaultRunLoopMode];
}

@end
