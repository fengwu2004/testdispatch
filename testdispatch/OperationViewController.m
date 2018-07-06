//
//  OperationViewController.m
//  testdispatch
//
//  Created by ky on 2018/7/4.
//  Copyright © 2018 yellfun. All rights reserved.
//

#import "OperationViewController.h"

@interface OperationViewController ()

@property(nonatomic) NSOperationQueue *operationQueue;

@end

@implementation OperationViewController

- (void)viewDidLoad {
  
  [super viewDidLoad];
  
  [self testOperationQueue];
}

- (void)testOperationQueue {
  
  _operationQueue = [[NSOperationQueue alloc] init];
  
  NSBlockOperation *bop = [NSBlockOperation blockOperationWithBlock:^{
    
    NSLog(@"a");
  }];
  
  NSLog(@"%@", bop);
  
  [bop addObserver:self forKeyPath:@"isExecuting" options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld | NSKeyValueObservingOptionInitial context:nil];
  
  [_operationQueue addOperation:bop];
  
  NSLog(@"zsdsd");
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
  
  NSLog(@"%@", object);
  
  NSLog(@"%@ %@", keyPath, change);
}

- (void)didReceiveMemoryWarning {

  [super didReceiveMemoryWarning];
}

@end
