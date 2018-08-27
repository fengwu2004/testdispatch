//
//  TestMessageForwardingViewController.m
//  testdispatch
//
//  Created by ky on 2018/8/21.
//  Copyright © 2018 yellfun. All rights reserved.
//

#import "TestMessageForwardingViewController.h"
#import "TestObj.h"
#import "KVOObject.h"
#import "KVOObject+Array.h"

typedef void(^success)(NSString* msg);

@interface TestMessageForwardingViewController ()

@property(nonatomic) KVOObject *kvoObject;

@end

@implementation TestMessageForwardingViewController

- (void)viewDidLoad {
  
  [super viewDidLoad];
  
  self.kvoObject = [KVOObject new];
  
  _kvoObject.obj = [TestObj new];
  
  NSLog(@"%@", _kvoObject.obj);
}

- (void)viewWillAppear:(BOOL)animated {
  
  [super viewWillAppear:animated];
  
  [self.kvoObject addObserver:self forKeyPath:@"str" options:NSKeyValueObservingOptionNew context:nil];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
  
  
}

- (void)viewDidAppear:(BOOL)animated {
  
  [super viewDidAppear:animated];
  
  self.kvoObject = nil;
}

- (void)didReceiveMemoryWarning {
  
  [super didReceiveMemoryWarning];
}

@end
