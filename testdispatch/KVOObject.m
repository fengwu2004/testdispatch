//
//  KVOObject.m
//  testdispatch
//
//  Created by ky on 2018/8/21.
//  Copyright © 2018 yellfun. All rights reserved.
//

#import "KVOObject.h"
#import "TestObjBase.h"

@interface KVOObject()

@property (nonatomic) TestObjBase *obj;

@end

@implementation KVOObject

- (id)init {
  
  self = [super init];
  
  return self;
}


@end
