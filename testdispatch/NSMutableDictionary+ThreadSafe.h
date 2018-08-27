//
//  NSMutableDictionary+ThreadSafe.h
//  testdispatch
//
//  Created by ky on 2018/8/6.
//  Copyright © 2018 yellfun. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSMutableDictionary (ThreadSafe)

- (void)read:(id<NSCopying>)key block:(void(^)(id))success;

- (void)write:(id<NSCopying>)key value:(id)value;

@end

