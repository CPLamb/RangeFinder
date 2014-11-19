//
//  HeightFinderViewController.m
//  RangeFinder
//
//  Created by Chris Lamb on 11/7/14.
//  Copyright (c) 2014 CPL Consulting. All rights reserved.
//

#import "HeightFinderViewController.h"

@implementation HeightFinderViewController{
    float degreesTilt;
    CMMotionManager *motionManager;
    RFTabBarController *tabVC;
}

#define DEGREE_2_RADIAN 57.3
#define YOUR_HEIGHT 6.0

#pragma mark - Lifecycle Methods

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.helpView.hidden = YES;

// CoreMotion setup for acceleration values
    motionManager = [[CMMotionManager alloc] init];
    motionManager.accelerometerUpdateInterval = .2;
    motionManager.gyroUpdateInterval = .2;

    [motionManager startDeviceMotionUpdatesUsingReferenceFrame:CMAttitudeReferenceFrameXArbitraryCorrectedZVertical toQueue:[NSOperationQueue currentQueue] withHandler:^(CMDeviceMotion *motion, NSError *error) {
        [self outputAttitudeData:motion];
        if (error){
            NSLog(@"Error! %@", [error description]);
        }
    }];
    
    self.helpView.hidden = YES;
    self.helpView.alpha = 0;
    CGRect landScapeRight = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.height, [UIScreen mainScreen].bounds.size.width);
    self.helpView.frame = landScapeRight;
    self.helpView.bounds = landScapeRight;
    
    tabVC = (RFTabBarController*)self.parentViewController.parentViewController;
    
}

-(void)viewDidAppear:(BOOL)animated{

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(BOOL)shouldAutorotate{
    return NO;
}

#pragma mark - Custom methods

- (IBAction)showHelpButton:(id)sender
{
    NSLog(@"slides up a transparency that describes the buttons below");
   // [self.parentViewController.parentViewController.view addSubview:self.helpView];
    self.helpView.hidden = NO;
        [UIView transitionWithView:self.helpView duration:0.5 options:UIViewAnimationOptionCurveEaseInOut animations:^{
            self.helpView.alpha = 0.75;
            tabVC.tabBar.alpha = 0;
            //self.helpView.hidden = NO;
        } completion:^(BOOL finished) {
        }];
}

- (IBAction)hideHelpButton:(id)sender
{
    [UIView transitionWithView:self.helpView duration:0.5 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        self.helpView.alpha = 0;
        tabVC.tabBar.alpha = 1;
    } completion:^(BOOL finished) {
        self.helpView.hidden = YES;
        NSLog(@"Finished fading Help screen");
    }];
   // [self.helpView removeFromSuperview];
}

#pragma mark - Core Motion Activity Update Handler Methods

-(void)outputAttitudeData:(CMDeviceMotion*)motion{
    //self.accelerationsLabel.text = [NSString stringWithFormat:@"X: %1.3f  Y: %1.3f  Z: %1.3f", motion.gravity.x, motion.gravity.y, motion.gravity.z*90];
    degreesTilt = -motion.gravity.y*90;
    if (degreesTilt >= 0)
        self.degreeLabel.text = [NSString stringWithFormat:@"%1.0f°", degreesTilt];
    else
        self.degreeLabel.text = @"0°";
}

#pragma mark - Custom Methods

- (IBAction)setAngleOneButton:(UIButton *)sender
{
    self.angleOne.text = [NSString stringWithFormat:@"%2.2f", degreesTilt];
}

- (IBAction)setAngleTwoButton:(UIButton *)sender
{
    self.angleTwo.text = [NSString stringWithFormat:@"%2.2f", degreesTilt];
}

- (IBAction)calculateButton:(UIButton *)sender
{
// converts textfields to floats in radians to calculate the height
    double bStep = [self.baseLength.text doubleValue];
    double aOne = [self.angleOne.text doubleValue]/DEGREE_2_RADIAN;
    double aTwo = [self.angleTwo.text doubleValue]/DEGREE_2_RADIAN;
    
    if (aTwo > aOne) {
        double temp = aTwo;
        aTwo = aOne;
        aOne = temp;
    }
    
// calculates the height based on 2 angles and a base length
    double h = YOUR_HEIGHT + (bStep * tan(aTwo) / (1-(tan(aTwo)/tan(aOne))));
    
// prints value
   // self.height.text = [NSString stringWithFormat:@"%3.3f",h];
   // NSLog(@"The height is %@", self.height.text);
}

- (IBAction)doneButton:(UIButton *)sender
{
    NSLog(@"Hides the keyboard");
    [self.angleOne resignFirstResponder];
    [self.angleTwo resignFirstResponder];
    [self.baseLength resignFirstResponder];
}

@end
