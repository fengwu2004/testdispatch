//
//  NSMutableDictionary+ThreadSafe.m
//  testdispatch
//
//  Created by ky on 2018/8/6.
//  Copyright © 2018 yellfun. All rights reserved.
//

#import "NSMutableDictionary+ThreadSafe.h"

@implementation NSMutableDictionary (ThreadSafe)

static dispatch_queue_t queue;

- (dispatch_queue_t)queue {
  
  static dispatch_once_t onceToken;
  
  dispatch_queue_attr_t attr = DISPATCH_QUEUE_CONCURRENT;
  
  dispatch_once(&onceToken, ^{
    
    queue = dispatch_queue_create("thread-safe-nsmutabledictionary", dispatch_queue_attr_make_with_qos_class(attr, QOS_CLASS_DEFAULT, 0));
  });
  
  return queue;
}

- (void)write:(id<NSCopying>)key value:(id)value {
  
  if (!key) {
    
    return;
  }
  
  dispatch_barrier_sync(self.queue, ^{
    
    [self setObject:value forKey:key];
  });
}

- (void)read:(id<NSCopying>)key block:(void(^)(id))successBlock {
  
  dispatch_sync(self.queue, ^{
    
    id value = [self objectForKey:key];
    
    successBlock(value);
  });
}


@end
