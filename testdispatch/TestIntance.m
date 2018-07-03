//
//  TestIntance.m
//  testdispatch
//
//  Created by ky on 2018/7/3.
//  Copyright © 2018 yellfun. All rights reserved.
//

#import "TestIntance.h"

@implementation TestIntance

+ (id)sharedInstance {
  
  static dispatch_once_t onceToken;
  
  static TestIntance *_intance;
  
  dispatch_once(&onceToken, ^{
    
    _intance = [TestIntance new];
  });
  
  return _intance;
}

@end
