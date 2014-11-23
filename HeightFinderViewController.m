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
    BOOL angleOneButtonState;
    BOOL angleTwoButtonState;
}
@synthesize angleOneButton = _angleOneButton;
@synthesize angleTwoButton = _angleTwoButton;
@synthesize objectName = _objectName;

#define DEGREE_2_RADIAN 57.3
#define YOUR_HEIGHT 6.0

#pragma mark - Lifecycle Methods

- (void)viewDidLoad {
    [super viewDidLoad];
    
// Additional setup stuff
    self.helpView.hidden = YES;
    angleOneButtonState = FALSE;
    angleTwoButtonState = FALSE;
    self.objectName.text = [NSString stringWithFormat:@"Object"];

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

    
    [motionManager startAccelerometerUpdatesToQueue:[NSOperationQueue currentQueue]
                                             withHandler:^(CMAccelerometerData  *accelerometerData, NSError *error) {
                                                 [self outputAccelerationData:accelerometerData.acceleration];
                                                 if(error){

                                                     NSLog(@"%@", error);
                                                 }
                                             }];
    
    
   // [self.motionManager startDeviceMotionUpdatesUsingReferenceFrame:CMAttitudeReferenceFrameXArbitraryCorrectedZVertical toQueue:[NSOperationQueue currentQueue] withHandler:^(CMDeviceMotion *motion, NSError *error) {
    /*
    [motionManager startDeviceMotionUpdatesUsingReferenceFrame:CMAttitudeReferenceFrameXArbitraryCorrectedZVertical toQueue:[NSOperationQueue currentQueue] withHandler:^(CMDeviceMotion *motion, NSError *error) {
        [self outputAttitudeData:motion];
        if (error){
            NSLog(@"Error! %@", [error description]);
        }
     
    }];
     */
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
    self.accelerationsLabel.text = [NSString stringWithFormat:@"Current angle = %2.0f", degreesTilt];
    
// loads degreeTilt into angle textFields when the field is selected
    if (angleOneButtonState) {
        self.angleOneLabel.text = [NSString stringWithFormat:@"%2.0f", degreesTilt];
    }
    if (angleTwoButtonState) {
        self.angleTwoLabel.text = [NSString stringWithFormat:@"%2.0f", degreesTilt];
    }

}

-(void)outputAttitudeData:(CMDeviceMotion*)motion{
    //self.accelerationsLabel.text = [NSString stringWithFormat:@"Current angle = %2.0f", -motion.gravity.y*90];
 //   degreesTilt = -motion.gravity.y*90;
    
// loads degreeTilt into angle textFields when the field is selected
    if (angleOneButtonState) {
        self.angleOneLabel.text = [NSString stringWithFormat:@"%2.0f", degreesTilt];
    }
    if (angleTwoButtonState) {
        self.angleTwoLabel.text = [NSString stringWithFormat:@"%2.0f", degreesTilt];
    }
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
    UIAlertView *message = [[UIAlertView alloc] initWithTitle:@"Enter object name"
                                                      message:nil
                                                     delegate:self
                                            cancelButtonTitle:@"Cancel"
                                            otherButtonTitles:@"Add", nil];
    [message setAlertViewStyle:UIAlertViewStylePlainTextInput];
    [message show];
    
// set text to objectName on ADD button
    
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
// sets objectName to textField input
    if (buttonIndex == [alertView firstOtherButtonIndex]) {
        NSLog(@"buttonIndex = %d", buttonIndex);
        //self.objectName = [alertView textFieldAtIndex:buttonIndex];
        //NSLog(@"ObjectName is %@", self.objectName.text);
    } else {
        NSLog(@"buttonIndex = %d", buttonIndex);
    }
}

- (IBAction)setAngleOneButton:(UIButton *)sender
{
    //self.angleOneLabel.text = [NSString stringWithFormat:@"%2.1f", degreesTilt];
    angleOneButtonState = TRUE;
    // NSLog(@"Button state is %u", angleOneButtonState);
}

- (IBAction)setAngleTwoButton:(UIButton *)sender
{
    //self.angleTwoLabel.text = [NSString stringWithFormat:@"%2.1f", degreesTilt];
    angleTwoButtonState = TRUE;
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
    self.height.text = [NSString stringWithFormat:@"Object is %3.0f feet", h];
    NSLog(@"The height is %@", self.height.text);

}

- (void)hideTap:(UIGestureRecognizer *)gestureRecognizer
{
    [self.view endEditing:YES];  // or [self.baseLength resignFirstResponder];
    
// resets dynamic data switch for angle textFields
    angleOneButtonState = FALSE;
    angleTwoButtonState = FALSE;
    //NSLog(@"Screen TAPPED button is %u", angleOneButtonState);
}

@end
