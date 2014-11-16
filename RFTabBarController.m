//
//  RFTabBarController.m
//  RangeFinder
//
//  Created by Bart Shaughnessy on 11/14/14.
//  Copyright (c) 2014 CPL Consulting. All rights reserved.
//

#import "RFTabBarController.h"
#import "HeightFinderViewController.h"

@interface RFTabBarController ()

@end

@implementation RFTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    NSArray *myVC = self.viewControllers;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
-(UIInterfaceOrientation)interfaceOrientation{
    if (self.selectedIndex == 1)
        return UIInterfaceOrientationLandscapeRight;
    
    return UIInterfaceOrientationPortrait;
}
*/

-(BOOL)shouldAutorotate{
    return NO;
}


@end
