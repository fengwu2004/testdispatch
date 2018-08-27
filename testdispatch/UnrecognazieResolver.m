//
//  UnrecognazieResolver.m
//  testdispatch
//
//  Created by ky on 2018/8/21.
//  Copyright © 2018 yellfun. All rights reserved.
//

#import "UnrecognazieResolver.h"
#import <objc/runtime.h>

@implementation UnrecognazieResolver

void unRecognaizeMethod(id _self, SEL cmd) {
  
  NSLog(@"未知消息我处理");
}

+ (BOOL)resolveInstanceMethod:(SEL)sel {
  
  NSLog(@"%@", NSStringFromSelector(sel));
  
  class_addMethod(self.class, sel, (IMP)unRecognaizeMethod, "V@:");
  
  return YES;
}

@end
