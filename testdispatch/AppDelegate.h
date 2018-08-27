//
//  AppDelegate.h
//  testdispatch
//
//  Created by ky on 2018/6/30.
//  Copyright © 2018 yellfun. All rights reserved.
//

#import <UIKit/UIKit.h>

@class RunLoopContext;
@class RunLoopSource;

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (nonatomic) NSMutableArray *sourcesToPing;

- (void)registerSource:(RunLoopContext*)context;

- (void)removeSource:(RunLoopContext*)context;

@end

