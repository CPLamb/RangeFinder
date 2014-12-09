//
//  RFTabBarController.h
//  RangeFinder
//
//  Created by Bart Shaughnessy on 11/14/14.
//  Copyright (c) 2014 CPL Consulting. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RFNavigationController.h"

@interface RFTabBarController : UITabBarController<UITabBarControllerDelegate>

@property (nonatomic, strong) UIViewController *lastVC;

@property (nonatomic, assign) id<UITabBarControllerDelegate> delegate;  // to sense selected tab

@end
