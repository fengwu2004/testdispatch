//
//  TestObj.m
//  testdispatch
//
//  Created by ky on 2018/8/21.
//  Copyright © 2018 yellfun. All rights reserved.
//

#import "TestObj.h"
#import "UnrecognazieResolver.h"
#import <objc/runtime.h>
#import "TestObjBase.h"

@interface TestObj()

@property(nonatomic) TestObjBase *base;

@end

@implementation TestObj

- (id)init {
  
  self = [super init];
  
  _base = [TestObjBase new];
  
  return self;
}

- (void)doSomeThing {
  
  NSLog(@"ok");
}

- (NSMethodSignature *)methodSignatureForSelector:(SEL)aSelector {
  
  return [self.base methodSignatureForSelector:aSelector];
}

- (void)forwardInvocation:(NSInvocation *)anInvocation {
  
  [anInvocation invokeWithTarget:self.base];
}

@end
