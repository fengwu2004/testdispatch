//
//  TestArcViewController.h
//  testdispatch
//
//  Created by ky on 2018/7/21.
//  Copyright © 2018 yellfun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Worker.h"

NS_ASSUME_NONNULL_BEGIN

@interface TestArcViewController : UIViewController

@property (nonatomic, strong) Worker *myWorker;

@property (nonatomic, weak) id obj;

//@property (nonatomic) Worker ** pWorker;

@end

NS_ASSUME_NONNULL_END
