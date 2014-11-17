//
//  RFTabBarController.m
//  RangeFinder
//
//  Created by Bart Shaughnessy on 11/14/14.
//  Copyright (c) 2014 CPL Consulting. All rights reserved.
//

#import "RFTabBarController.h"
#import "HeightFinderViewController.h"
#import "AppDelegate.h"


@implementation RFTabBarController{
    AppDelegate *appDelegate;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.delegate = self;
    NSArray *myVC = self.viewControllers;
    NSLog(@"selected view controller %@", self.selectedViewController);
    appDelegate = [[UIApplication sharedApplication] delegate];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(BOOL)shouldAutorotate{
    return NO;
}

/*
-(NSUInteger)tabBarControllerSupportedInterfaceOrientations:(UITabBarController *)tabBarController{
    return UIInterfaceOrientationMaskPortrait;
}
*/

//-(UIInterfaceOrientation)tabBarControllerPreferredInterfaceOrientationForPresentation:(UITabBarController *)tabBarController{
//    return UIInterfaceOrientationPortrait;
//}


-(void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item{
    NSLog(@"Item number is %lu", (unsigned long)self.selectedIndex);
      //  [[[UIApplication sharedApplication] delegate] reloadNavBarController];
    if (item == self.viewControllers[1]) {
        [self willRotateToInterfaceOrientation:UIInterfaceOrientationLandscapeRight duration:0.3];
    }
}



-(void)setViewControllers:(NSArray *)viewControllers animated:(BOOL)animated{
    NSLog(@"Called setViewControllers");
}

-(void)loadView{
    [super loadView];
    NSLog(@"Called Loadview");
}

@end
