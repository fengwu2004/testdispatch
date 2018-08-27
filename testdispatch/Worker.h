//
//  WorkingThread.h
//  testdispatch
//
//  Created by ky on 2018/7/14.
//  Copyright © 2018 yellfun. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Worker : NSObject

- (void)start:(NSPort*)remotePort;

- (void)display:(Worker __weak *)value;

- (void)do;

- (void)doSomeThingSpecial:(Worker**)worker;

+ (id)worker;

+ (void)display;

@end

@interface Coder: Worker

- (void)testsomething;

@property(nonatomic) NSString *type;

@end

@interface JavaCoder: Coder

@property(nonatomic, copy) NSString * javaVersion;

+ (void)whatisSelf;

@end
