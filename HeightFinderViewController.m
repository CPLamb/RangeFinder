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
}

#define DEGREE_2_RADIAN 57.3
#define YOUR_HEIGHT 6.0

#pragma mark - Lifecycle Methods

- (void)viewDidLoad {
    [super viewDidLoad];
    
// Additional setup stuff
    self.helpView.hidden = YES;
// Tap to hide keyboard
    UITapGestureRecognizer *hideKeyboardTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideTap:)];
    [self.view addGestureRecognizer:hideKeyboardTap];
    
// CoreMotion setup for acceleration values
   // self.motionManager = [[CMMotionManager alloc] init];
   // self.motionManager.accelerometerUpdateInterval = .2;
   // self.motionManager.gyroUpdateInterval = .2;
    motionManager = [[CMMotionManager alloc] init];
    motionManager.accelerometerUpdateInterval = .2;
    motionManager.gyroUpdateInterval = .2;

    /*
    [self.motionManager startAccelerometerUpdatesToQueue:[NSOperationQueue currentQueue]
                                             withHandler:^(CMAccelerometerData  *accelerometerData, NSError *error) {
                                                 [self outputAccelerationData:accelerometerData.acceleration];
                                                 if(error){

                                                     NSLog(@"%@", error);
                                                 }
                                             }];
    */
    
   // [self.motionManager startDeviceMotionUpdatesUsingReferenceFrame:CMAttitudeReferenceFrameXArbitraryCorrectedZVertical toQueue:[NSOperationQueue currentQueue] withHandler:^(CMDeviceMotion *motion, NSError *error) {
    [motionManager startDeviceMotionUpdatesUsingReferenceFrame:CMAttitudeReferenceFrameXArbitraryCorrectedZVertical toQueue:[NSOperationQueue currentQueue] withHandler:^(CMDeviceMotion *motion, NSError *error) {
        [self outputAttitudeData:motion];
        if (error){
            NSLog(@"Error! %@", [error description]);
        }
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Core Motion Activity Update Handler Methods

-(void)outputAccelerationData:(CMAcceleration)acceleration
{
    // Tilt is the arcTan(Opposite accel Y / Adjacent accel X)
    double tilt = atan(acceleration.y / acceleration.x)*DEGREE_2_RADIAN;
    degreesTilt = tilt;
}

-(void)outputAttitudeData:(CMDeviceMotion*)motion{
    self.accelerationsLabel.text = [NSString stringWithFormat:@"Current angle = %2.0f", -motion.gravity.y*90];
    degreesTilt = -motion.gravity.y*90;
}

#pragma mark - Custom Methods


- (IBAction)showHelpButton:(id)sender
{
    NSLog(@"slides up a transparency that describes the buttons below");
    if (self.helpView.hidden) {
        self.helpView.hidden = NO;
    }
}

- (IBAction)hideHelpButton:(id)sender
{
    //    NSLog(@"hides the transparency that describes the buttons below");
    if (!self.helpView.hidden) {
        self.helpView.hidden = YES;
    }
}

- (IBAction)addButton:(id)sender
{
    UIAlertView *message = [[UIAlertView alloc] initWithTitle:@"Add Objects"
                                                      message:@"Enter object name"
                                                     delegate:nil
                                            cancelButtonTitle:@"Add"
                                            otherButtonTitles:@"Cancel", nil];
    [message setAlertViewStyle:UIAlertViewStylePlainTextInput];
    [message show];
}


- (IBAction)setAngleOneButton:(UIButton *)sender
{
    self.angleOneLabel.text = [NSString stringWithFormat:@"%2.1f", degreesTilt];
}

- (IBAction)setAngleTwoButton:(UIButton *)sender
{
    self.angleTwoLabel.text = [NSString stringWithFormat:@"%2.1f", degreesTilt];
}

- (IBAction)calculateButton:(UIButton *)sender
{
// converts textfields to floats in radians to calculate the height
    double bStep = [self.baseLength.text doubleValue];
    double aOne = [self.angleOneLabel.text doubleValue]/DEGREE_2_RADIAN;
    double aTwo = [self.angleTwoLabel.text doubleValue]/DEGREE_2_RADIAN;
    
    if (aTwo > aOne) {
        double temp = aTwo;
        aTwo = aOne;
        aOne = temp;
    }
    
// calculates the height based on 2 angles and a base length
   // double h = YOUR_HEIGHT + (bStep * tan(aOne) / ((tan(aOne)/tan(aTwo)) - 1));
    double h = YOUR_HEIGHT + (bStep * tan(aTwo) / (1-(tan(aTwo)/tan(aOne))));
    
// prints value
    self.height.text = [NSString stringWithFormat:@"%3.1f",h];
    NSLog(@"The height is %@", self.height.text);

}

- (void)hideTap:(UIGestureRecognizer *)gestureRecognizer
{
    NSLog(@"Screen TAPPED!!");
    [self.view endEditing:YES];  // or [self.baseLength resignFirstResponder];
}

@end
