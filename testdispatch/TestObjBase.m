//
//  TestObjBase.m
//  testdispatch
//
//  Created by ky on 2018/8/21.
//  Copyright © 2018 yellfun. All rights reserved.
//

#import "TestObjBase.h"
#import "UnrecognazieResolver.h"

@implementation TestObjBase

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
  
  
}

- (void)doSomeThing {
  
  NSLog(@"do do do");
}

@end
