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

@property (strong, nonatomic) RFNavigationController *myNavController;

@property (nonatomic, assign) UIInterfaceOrientation orientation;
@property (nonatomic, assign) NSUInteger supportedInterfaceOrientation;

@end
