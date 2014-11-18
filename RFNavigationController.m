//
//  RFNavigationController.m
//  RangeFinder
//
//  Created by Bart Shaughnessy on 11/15/14.
//  Copyright (c) 2014 CPL Consulting. All rights reserved.
//

#import "RFNavigationController.h"
#import "HeightFinderViewController.h"

@implementation RFNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(UIInterfaceOrientation)interfaceOrientation{
    if ([self.topViewController isKindOfClass:[HeightFinderViewController class]])
        return UIInterfaceOrientationLandscapeRight;
    
    return UIInterfaceOrientationPortrait;
}

-(BOOL)shouldAutorotate{
    return YES;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
