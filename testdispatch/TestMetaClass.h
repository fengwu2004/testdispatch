//
//  TestMetaClass.h
//  testdispatch
//
//  Created by ky on 2018/7/20.
//  Copyright © 2018 yellfun. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface T : NSObject

+(void)do;

-(void)undo;

@end

@interface T1 : T

+(void)do1;

-(void)undo1;

@end

@interface T2 : T1

+(void)do2;

-(void)undo2;

@end

@interface T3 : T2

+(void)do3;

-(void)undo3;

@end

NS_ASSUME_NONNULL_END
