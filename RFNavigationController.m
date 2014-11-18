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
    NSLog(@"Top View Controller %@", self.topViewController);
    self.delegate = self;
}

-(void)viewWillAppear:(BOOL)animated{
    if ([self.topViewController isKindOfClass:[HeightFinderViewController class]]) {
        [UIView beginAnimations:@"Force Landscape Right" context:nil];
        [UIView setAnimationDuration:0.2f];
        [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
        
        self.view.transform = CGAffineTransformIdentity;
        self.view.transform = CGAffineTransformMakeRotation(90.0*0.0174532925);
        self.view.bounds = CGRectMake(0.0f, 0.0f, [UIScreen mainScreen].bounds.size.height, [UIScreen mainScreen].bounds.size.width);
        self.view.center = CGPointMake([UIScreen mainScreen].bounds.size.width/2, [UIScreen mainScreen].bounds.size.height/2);
        [UIView commitAnimations];
    }
    
    self.navigationBar.hidden = YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(BOOL)shouldAutorotate{
    return NO;
}

-(NSUInteger)supportedInterfaceOrientations{
    NSLog(@"Top controller is %@", self.topViewController);
    NSLog(@"Interface Orientations %lu", (unsigned long)self.topViewController.supportedInterfaceOrientations);
    return self.topViewController.supportedInterfaceOrientations;
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
