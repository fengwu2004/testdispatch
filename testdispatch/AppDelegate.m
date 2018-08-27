//
//  AppDelegate.m
//  testdispatch
//
//  Created by ky on 2018/6/30.
//  Copyright © 2018 yellfun. All rights reserved.
//

#import "AppDelegate.h"
#import "RunLoopContext.h"
#import "RunLoopSource.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

- (void)registerSource:(RunLoopContext *)context {
  
  if (!_sourcesToPing) {
    
    _sourcesToPing = [[NSMutableArray alloc] init];
  }
  
  [_sourcesToPing addObject:context];
}

- (void)removeSource:(RunLoopContext *)sourcecontext {
  
  id objToRemove = nil;
  
  for (RunLoopContext *context in _sourcesToPing) {
    
    if ([context isEqual:sourcecontext]) {
      
      objToRemove = context;
      
      break;
    }
  }
  
  if (objToRemove) {
    
    [_sourcesToPing removeObject:objToRemove];
  }
}

- (BOOL)application:(UIApplication *)application willFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
  
  NSLog(@"%s", __func__);
  
  return YES;
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
  
  NSLog(@"%s", __func__);
  
  return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
  
    NSLog(@"%s", __func__);
}


- (void)applicationDidEnterBackground:(UIApplication *)application {

    NSLog(@"%s", __func__);
}


- (void)applicationWillEnterForeground:(UIApplication *)application {

    NSLog(@"%s", __func__);
}


- (void)applicationDidBecomeActive:(UIApplication *)application {

    NSLog(@"%s", __func__);
}


- (void)applicationWillTerminate:(UIApplication *)application {

    NSLog(@"%s", __func__);
}


@end
