//
//  HeightFinderViewController.m
//  RangeFinder
//
//  Created by Chris Lamb on 11/7/14.
//  Copyright (c) 2014 CPL Consulting. All rights reserved.
//

#import "HeightFinderViewController.h"

@interface HeightFinderViewController ()
{
    float degreesTilt;
}
@end

@implementation HeightFinderViewController

#define DEGREE_2_RADIAN 57.3
#define YOUR_HEIGHT 6.0

@synthesize angleOne = _angleOne;
@synthesize angleTwo = _angleTwo;
@synthesize baseLength = _baseLength;
@synthesize height = _height;

@synthesize motionManager = _motionManager;
@synthesize accelerationsLabel = _accelerationsLabel;
//@synthesize myAcceleration = _myAcceleration;

@synthesize helpView =_helpView;

#pragma mark - Lifecycle Methods

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.helpView.hidden = YES;

// CoreMotion setup for acceleration values
    self.motionManager = [[CMMotionManager alloc] init];
    self.motionManager.accelerometerUpdateInterval = .2;
    self.motionManager.gyroUpdateInterval = .2;

    [self.motionManager startAccelerometerUpdatesToQueue:[NSOperationQueue currentQueue]
                                             withHandler:^(CMAccelerometerData  *accelerometerData, NSError *error) {
                                                 [self outputAccelertionData:accelerometerData.acceleration];
                                                 if(error){

                                                     NSLog(@"%@", error);
                                                 }
                                             }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationLandscapeRight);
}

#pragma mark - Custom methods

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

#pragma mark - Delegate Methods

-(void)outputAccelertionData:(CMAcceleration)acceleration
{
    //NSLog(@"Acceleration should work now???");
//    self.myAcceleration = acceleration;
    
    // Tilt is the arcTan(Opposite accel Y / Adjacent accel X)
    double tilt = atan(acceleration.y / acceleration.x)*DEGREE_2_RADIAN;
    degreesTilt = tilt;
    
    // Displays accelerations to the screen
    self.accelerationsLabel.text = [NSString stringWithFormat:@"Accels X= %1.3f Y= %1.3f Angle= %2.1f", acceleration.x, acceleration.y, tilt];
}

#pragma mark - Custom Methods

- (IBAction)setAngleOneButton:(UIButton *)sender
{
//    NSLog(@"The angle is %2.1f", degreesTilt);
    self.angleOne.text = [NSString stringWithFormat:@"%2.1f", degreesTilt];
}

- (IBAction)setAngleTwoButton:(UIButton *)sender
{
//    NSLog(@"The angle is %2.1f", degreesTilt);
    self.angleTwo.text = [NSString stringWithFormat:@"%2.1f", degreesTilt];
}

- (IBAction)calculateButton:(UIButton *)sender
{
// converts textfields to floats in radians to calculate the height
    double bStep = [self.baseLength.text doubleValue];
    double aOne = [self.angleOne.text doubleValue]/DEGREE_2_RADIAN;
    double aTwo = [self.angleTwo.text doubleValue]/DEGREE_2_RADIAN;
    
// calculates the height based on 2 angles and a base length
    double h = YOUR_HEIGHT + (bStep * tan(aOne) / ((tan(aOne)/tan(aTwo)) - 1));
    
// prints value
    self.height.text = [NSString stringWithFormat:@"%3.3f",h];
    NSLog(@"The height is %@", self.height.text);

}

- (IBAction)doneButton:(UIButton *)sender
{
    NSLog(@"Hides the keyboard");
    [self.angleOne resignFirstResponder];
    [self.angleTwo resignFirstResponder];
    [self.baseLength resignFirstResponder];
}

@end
