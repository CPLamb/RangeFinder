//
//  HeightFinderViewController.m
//  RangeFinder
//
//  Created by Chris Lamb on 11/7/14.
//  Copyright (c) 2014 CPL Consulting. All rights reserved.
//

#import "HeightFinderViewController.h"

enum findValueForAngle {INNER_ANGLE_VALUE, OUTER_ANGLE_VALUE};

@implementation HeightFinderViewController{
    int degreesTilt;
    CMMotionManager *motionManager;
    RFTabBarController *tabVC;
    
    int lastdegreeVal;
    UILabel *innerAngleLabel;
    UILabel *baseLengthLabel;
    UILabel *outerAngleLabel;
    AngleLayer *innerAngleEmphasis;
    AngleLayer *baseLengthEmphasis;
    AngleLayer *outerAngleEmphasis;
    
    UIButton *innerAngleButton;
    UIButton *startOverButton;
    UITextField *baseLengthText;

    UIButton *outerAngleButton;
    UIButton *calculateButton;
    
    BOOL startWithInnerAngle;
    enum findValueForAngle AngleVal;
    
    int bStep;
    float aOne;
    float aTwo;

    BOOL angleOneButtonState;
    BOOL angleTwoButtonState;
    
    DistantObject *theDistantObject;
    NSString *objectUnits;
}
@synthesize helpView = _helpView;

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
    
    
// Open the data singleton & retrieve values
    theDistantObject = [DistantObject getSingeltonInstance];
    self.testString.text = [NSString stringWithFormat:@"Distant object name is %@", theDistantObject.objectName];
    
// Tap to hide keyboard
    UITapGestureRecognizer *hideKeyboardTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideTap:)];
    [self.view addGestureRecognizer:hideKeyboardTap];
    
// CoreMotion setup for acceleration values
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
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Core Motion Activity Update Handler Methods

-(void)outputAccelerationData:(CMAcceleration)acceleration
{
    //  NSLog(@"reads accel X & Y and converts to degrees");
    degreesTilt = (int)round(atan(acceleration.y / acceleration.x)*DEGREE_2_RADIAN);
    self.degreeLabel.text = [NSString stringWithFormat:@"%d°", degreesTilt];
    
    if (degreesTilt >= 0){
        self.degreeLabel.text = [NSString stringWithFormat:@"%d°", degreesTilt];
        if (!self.degreeLabel.hidden && (degreesTilt != lastdegreeVal)){
            AudioServicesPlaySystemSound(0x450);
            lastdegreeVal = degreesTilt;
        }
    }
    else
        self.degreeLabel.text = @"0°";

// loads degreeTilt into angle textFields when the field is selected
    if (angleOneButtonState) {
        self.angleOneLabel.text = [NSString stringWithFormat:@"%d", degreesTilt];
    }
    if (angleTwoButtonState) {
        self.angleTwoLabel.text = [NSString stringWithFormat:@"%d", degreesTilt];
    }
}

#pragma mark - Custom Methods

- (void)hideTap:(UIGestureRecognizer *)gestureRecognizer
{
    [self.view endEditing:YES];  // or [self.baseLength resignFirstResponder];
    
    // resets dynamic data switch for angle textFields
    angleOneButtonState = FALSE;
    angleTwoButtonState = FALSE;
    //NSLog(@"Screen TAPPED button is %u", angleOneButtonState);
}

- (IBAction)setAngleOneButton:(UIButton *)sender
{
    self.angleOneLabel.text = [NSString stringWithFormat:@"%1.0d", degreesTilt];
    angleOneButtonState = TRUE;
    // NSLog(@"Button state is %u", angleOneButtonState);
}

- (IBAction)setAngleTwoButton:(UIButton *)sender
{
    self.angleTwoLabel.text = [NSString stringWithFormat:@"%2.1d", degreesTilt];
    angleTwoButtonState = TRUE;
}

- (IBAction)showHelpButton:(id)sender
{
    NSLog(@"slides up a transparency that describes the buttons below");
    if (self.helpView.hidden) {
        self.helpView.hidden = NO;
    }
}

- (IBAction)hideHelpButton:(id)sender
{
    NSLog(@"hides the transparency that describes the buttons below");
//    if (!self.helpView.hidden) {
        self.helpView.hidden = YES;
//    }
}

- (IBAction)addButton:(id)sender
{
    self.testString.text = [NSString stringWithFormat:@"Distant object name is %@", theDistantObject.objectName];
    NSLog(@"For testing singleton %@", self.testString.text);
    UIAlertView *message = [[UIAlertView alloc] initWithTitle:@"Enter object name"
                                                      message:nil
                                                     delegate:self
                                            cancelButtonTitle:@"Cancel"
                                            otherButtonTitles:@"Add", nil];
    [message setAlertViewStyle:UIAlertViewStylePlainTextInput];
    [message show];
    
// set text to objectName on ADD button
    
}

- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    NSLog(@"Button Index =%ld",(long)buttonIndex);
    if (buttonIndex == 1) {  //Login
        UITextField *username = [alertView textFieldAtIndex:0];
        
// assigns textField to distant Object
        theDistantObject.objectName = username.text;
        NSLog(@"Object name: %@", theDistantObject.objectName);
    }
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
// sets objectName to textField input
    if (buttonIndex == [alertView firstOtherButtonIndex]) {
        NSLog(@"buttonIndex = %ld", (long)buttonIndex);
        //self.objectName = [alertView textFieldAtIndex:buttonIndex];
        //NSLog(@"ObjectName is %@", self.objectName.text);
    } else {
        NSLog(@"buttonIndex = %ld", (long)buttonIndex);
    }
}

-(void)calculateButton:(UIButton *)sender{
// converts textfields to floats in radians to calculate the height
    bStep = [self.baseLength.text doubleValue];
    aOne = [self.angleOneLabel.text doubleValue]/DEGREE_2_RADIAN;
    aTwo = [self.angleTwoLabel.text doubleValue]/DEGREE_2_RADIAN;
    
    if (aTwo > aOne) {
        double temp = aTwo;
        aTwo = aOne;
        aOne = temp;
    }
    NSLog(@"The 3 values are %1.2f, %1.2f, %d", aOne, aTwo, bStep);
// calculates the height based on 2 angles and a base length
    double h = YOUR_HEIGHT + (bStep * tan(aTwo) / (1-(tan(aTwo)/tan(aOne))));
    
    objectUnits = @"foot";

    self.height.text =[NSString stringWithFormat:@"Tree is %3.0f %@ high", h, objectUnits];
    self.height.hidden = NO;
    [self.height removeFromSuperview];
    [self.view addSubview:self.height];
    
 //   self.calculateButtonObject.hidden = YES;
    
}

@end
