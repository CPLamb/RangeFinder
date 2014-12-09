//
//  RFTabBarController.m
//  RangeFinder
//
//  Created by Bart Shaughnessy on 11/14/14.
//  Copyright (c) 2014 CPL Consulting. All rights reserved.
//

#import "RFTabBarController.h"
#import "HeightFinderViewController.h"
#import "MainViewController.h"
#import "FlipsideViewController.h"

@implementation RFTabBarController {

    MainViewController *rangeFinderVC;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.delegate = self;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(BOOL)shouldAutorotate{
    return NO;
}

#pragma mark - Custom Methods

//returns the controller title of the tab selected
- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController
{
    NSLog(@"Triggers on selecting a tab/view? %@", [viewController title]);
    if ([[viewController title] isEqualToString:@"RangeFinder"]) {
        NSLog(@"Going to RANGEFINDER");
    }
}

-(void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item{
    //stubbed in case we need this. Use item and test against self.viewControllers array index
}


-(void)loadView{
    [super loadView];
    //this method seems to only get called once. Super Loadview is what loads the childview into the Tab bar controller.
}


@end
