//
//  RunLoopContext.h
//  testdispatch
//
//  Created by ky on 2018/7/16.
//  Copyright © 2018 yellfun. All rights reserved.
//

#import <Foundation/Foundation.h>

@class RunLoopSource;

@interface RunLoopContext : NSObject

@property(nonatomic) CFRunLoopRef runloop;

@property(nonatomic) RunLoopSource *source;

- (id)initWithSource:(RunLoopSource*)source addLoop:(CFRunLoopRef)loop;

@end
