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
    
    if ([self.topViewController isKindOfClass:[HeightFinderViewController class]]){
        NSLog(@"I see a Height View Controller!");
        [super willRotateToInterfaceOrientation:UIInterfaceOrientationLandscapeRight duration:0.3];
    }
    else
        NSLog(@"I see a %@", self.topViewController);
}

-(void)viewWillAppear:(BOOL)animated{
   // CGRect excitingRect = CGRectMake(150, 150, 100, 300);
   // UIView *excitingView = [[UIView alloc] initWithFrame:excitingRect];
   // excitingView.backgroundColor = [UIColor greenColor];
   // excitingView.opaque = YES;
   // [self.view addSubview:excitingView];
    
    if ([self.topViewController isKindOfClass:[HeightFinderViewController class]]) {
        NSLog(@"We've got a Height Finder!");
        [UIView beginAnimations:@"View Flip" context:nil];
        [UIView setAnimationDuration:0.5f];
        [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
        
        self.view.transform = CGAffineTransformIdentity;
        self.view.transform = CGAffineTransformMakeRotation(90.0*0.0174532925);
        self.view.bounds = CGRectMake(0.0f, 0.0f, 480.0f, 320.0f);
        self.view.center = CGPointMake(160.0f, 240.0f);
        //excitingView.transform = CGAffineTransformIdentity;
        //excitingView.transform = CGAffineTransformMakeRotation(90.0*0.0174532925);
        //excitingView.bounds = CGRectMake(0.0f, 0.0f, 480.0f, 320.0f);
        //excitingView.center = CGPointMake(160.0f, 240.0f);
        
        
        //  [UIApplication sharedApplication].statusBarOrientation = UIInterfaceOrientationLandscapeRight;
        
        [UIView commitAnimations];
    }
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(UIInterfaceOrientation)navigationControllerPreferredInterfaceOrientationForPresentation:(UINavigationController *)navigationController{
    return navigationController.topViewController.preferredInterfaceOrientationForPresentation;
}
/*
-(NSUInteger)navigationControllerSupportedInterfaceOrientations:(UINavigationController *)navigationController{

    // if ([navigationController.topViewController isKindOfClass:[HeightFinderViewController class]])
         return UIInterfaceOrientationLandscapeRight;
    //return UIInterfaceOrientationPortrait;
}
*/


-(BOOL)shouldAutorotate{
    //return NO;
    //return self.interfaceOrientation == UIInterfaceOrientationLandscapeRight;
    //return [[UIDevice currentDevice] orientation] == (UIDeviceOrientation)self.topViewController.preferredInterfaceOrientationForPresentation;
    //return YES;
   // return self.interfaceOrientation == (UIInterfaceOrientationLandscapeRight | UIInterfaceOrientationPortrait);
    
    //return self.topViewController.shouldAutorotate;
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
