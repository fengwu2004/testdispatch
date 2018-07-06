//
//  KVCViewController.m
//  testdispatch
//
//  Created by ky on 2018/7/6.
//  Copyright © 2018 yellfun. All rights reserved.
//

#import "KVCViewController.h"
#import "kvcObject.h"

@interface KVCViewController ()

@property(nonatomic) kvcObject *testobj;

@end

@implementation KVCViewController

- (void)viewDidLoad {
  
  [super viewDidLoad];
  
  [self setup];
}

- (void)setup {
  
  _testobj = [kvcObject new];
  
  [_testobj addObserver:self forKeyPath:@"name" options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld|NSKeyValueObservingOptionInitial context:nil];
  
  _testobj.name = @"zf";
  
  NSLog(@"abcd");
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
  
  if ([keyPath isEqualToString:@"name"] && object == _testobj) {
    
    NSLog(@"%@", change);
  }
  else {
    
    [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
  }
}

- (void)didReceiveMemoryWarning {
  
  [super didReceiveMemoryWarning];
}

@end
