//
//  RFNavigationController.m
//  RangeFinder
//
//  Created by Bart Shaughnessy on 11/15/14.
//  Copyright (c) 2014 CPL Consulting. All rights reserved.
//

#import "RFNavigationController.h"
#import "HeightFinderViewController.h"

@implementation RFNavigationController{
    UIViewController *lastVC;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.delegate = self;
}

-(void)viewWillAppear:(BOOL)animated{
    if ([self.topViewController isKindOfClass:[HeightFinderViewController class]]) {
        [UIView beginAnimations:@"Force Landscape Right" context:nil];
        [UIView setAnimationDuration:0.2f];
        [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
        
        self.parentViewController.view.transform = CGAffineTransformIdentity;
        self.parentViewController.view.transform = CGAffineTransformMakeRotation(90.0*0.0174532925);
        self.parentViewController.view.bounds = CGRectMake(0.0f, 0.0f, [UIScreen mainScreen].bounds.size.height, [UIScreen mainScreen].bounds.size.width);
        self.parentViewController.view.center = CGPointMake([UIScreen mainScreen].bounds.size.width/2, [UIScreen mainScreen].bounds.size.height/2);
        [[UIApplication sharedApplication] setStatusBarOrientation:UIInterfaceOrientationLandscapeRight animated:YES];
        
        [UIView commitAnimations];
    }
    else{
       if ([((RFTabBarController*)self.parentViewController).lastVC isKindOfClass:[HeightFinderViewController class]]) {
            self.parentViewController.view.transform = CGAffineTransformIdentity;
            self.parentViewController.view.bounds = CGRectMake(0.0f, 0.0f, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
           self.parentViewController.view.center = CGPointMake([UIScreen mainScreen].bounds.size.width/2, [UIScreen mainScreen].bounds.size.height/2);
            [[UIApplication sharedApplication] setStatusBarOrientation:UIInterfaceOrientationPortrait animated:YES];
            
            [UIView commitAnimations];
        }
        
    }
    self.navigationBar.hidden = YES;
}

-(void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated{
    //
}

-(void)navigationController:(UINavigationController *)navigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animated{
    //lastVC = self.topViewController;
    //lastVC = self.visibleViewController;
    ((RFTabBarController*)self.parentViewController).lastVC = self.visibleViewController;
}

//interesting. Implementing this method on the Nav controller overrides viewDidAppear on the self.topViewController
//In other words, the animations won't work in the HeightViewController!
//-(void)viewDidAppear:(BOOL)animated{
//    NSLog(@"Making sure the Nav Controller self is getting set");
//}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
-(BOOL)shouldAutorotate{
    return YES;
}

-(NSUInteger)supportedInterfaceOrientations{
   // NSLog(@"Top controller is %@", self.topViewController);
   // NSLog(@"Interface Orientations %lu", (unsigned long)self.topViewController.supportedInterfaceOrientations);
    return self.topViewController.supportedInterfaceOrientations;
}
*/
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
