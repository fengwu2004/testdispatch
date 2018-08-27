//
//  TestArcViewController.m
//  testdispatch
//
//  Created by ky on 2018/7/21.
//  Copyright © 2018 yellfun. All rights reserved.
//

#import "TestArcViewController.h"
#import "Worker.h"
#import <objc/runtime.h>

@interface TestArcViewController ()

@end

@implementation TestArcViewController

//@synthesize myWorker = myWorker;

- (void)viewDidLoad {
  
  [super viewDidLoad];
  
  id obj = [Worker worker];
  
  __weak id weakobj = obj;
  
  NSLog(@"%p", weakobj);

  [weakobj do];
  
  NSLog(@"asdcds");
}

- (void)test {
  
  _myWorker = [Worker new];
  
  NSLog(@"%p", _myWorker);
  
  id __weak obj = _myWorker;
  
  NSLog(@"%p", obj);
  
  Worker * __weak * pWorker = &obj;
  
  NSLog(@"%p", *pWorker);
  
  obj = nil;
  
  NSLog(@"%p", pWorker);
  
  dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
    
    NSLog(@"%p", pWorker);
    
    printf("%p", *pWorker);
    
    NSLog(@"%p", *pWorker);
    
    Worker *wk = *pWorker;
    
    [wk do];
  });
  
  NSString *str = [NSString stringWithFormat:@"sdfs"];
  
  NSError * error = nil;
  
  [str writeToURL:[NSURL URLWithString:@"sdfsd"] atomically:YES encoding:NSUTF8StringEncoding error:&error];
}

- (void)viewDidAppear:(BOOL)animated {
  
  [super viewDidAppear:animated];

  id worker = [Worker new];
  
  NSInteger size = sizeof(worker);
  
  NSLog(@"%ld", size);
  
  const char* name = object_getClassName(objc_getMetaClass("JavaCoder"));
  
  const char* name1 = object_getClassName(objc_getClass("JavaCoder"));
  
  printf("%s, %s \n", name, name1);
  
  [self testclasName];
  
  [self testAddVarAndAddProperty];
}

void myMethodIMP(id self, SEL _cmd, int value1, int value2, int value3) {
  
  [self performSelector:@selector(description) withObject:nil];
  NSLog(@"------------ %d, %d %d", value1, value2, value3);
}

- (void)testAddVarAndAddProperty {
  
  if (class_addMethod(JavaCoder.class, @selector(displaySomething), (IMP)myMethodIMP, "v@:iii")) {
    
    NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:[NSMethodSignature signatureWithObjCTypes:"v@:iii"]];
    
    class_getInstanceMethod(JavaCoder.class, @selector(displaySomething));
    
    [invocation setSelector:@selector(displaySomething)];
    
    id javaCoder = [JavaCoder new];
    
    [invocation setTarget:javaCoder];
    
    int value1 = 1;
    
    int value2 = 101;
    
    int value3 = 1;
    
    [invocation setArgument:&value1 atIndex:2];
    
    [invocation setArgument:&value2 atIndex:3];
    
    [invocation setArgument:&value3 atIndex:4];
    
    [invocation invoke];
  }
  else {
    
    NSLog(@"添加不成功");
  }
  
  NSLog(@"ok");
  
  NSLog(@"ok", sizeof(int));
}

- (void)testclasName {
  
  Class cls = objc_getClass("JavaCoder");
  
  Class a = class_getSuperclass(cls);
  
  Class b = objc_getClass("Coder");
  
  if (a == b) {
    
    NSLog(@"sdfsdf");
  }
  
  Class mcls = objc_getMetaClass("JavaCoder");
  
  Class mmcls = objc_getMetaClass(object_getClassName(mcls));
  
  unsigned int count = 0;
  
  NSLog(@"------------------");
  
  Method *list = class_copyMethodList(mmcls, &count);
  
  printf("%d \n", count);
}

- (void)test:(id*)pWorker {
  
  if (*pWorker != *pWorker) {
    
    NSLog(@"不相等");
  }
  else {
    
    NSLog(@"相等");
  }
}

@end
