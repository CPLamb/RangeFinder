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
<<<<<<< HEAD
    RFTabBarController *tabVC;
    int lastdegreeVal;
    UITapGestureRecognizer *tapToStoreAngle;
    UITapGestureRecognizer *tapToReplaceInnerAngle;
    UITapGestureRecognizer *tapToReplaceOuterAngle;
    UITapGestureRecognizer *tapToReplaceBaseLength;
    UITapGestureRecognizer *inputInnerAngle;
    UITapGestureRecognizer *inputBaseLength;
    UITapGestureRecognizer *inputOuterAngle;
    UILabel *innerAngleLabel;
    UILabel *baseLengthLabel;
    UILabel *outerAngleLabel;
    AngleLayer *innerAngleEmphasis;
    AngleLayer *baseLengthEmphasis;
    AngleLayer *outerAngleEmphasis;
    
    CAShapeLayer *innerTriangleLayer;
    CAShapeLayer *outerTriangleLayer;
    CAShapeLayer *baseLengthLayer;
    
    UIButton *innerAngleButton;
    UITextField *baseLengthText;
    //UIButton *baseLengthButton;
    UIButton *outerAngleButton;
    UIButton *calculateButton;
    
    BOOL startWithInnerAngle;
    enum findValueForAngle AngleVal;
    
    int bStep;
    int aOne;
    int aTwo;
=======
    BOOL angleOneButtonState;
    BOOL angleTwoButtonState;
>>>>>>> ae17683cdc8cfe1853284fc7f54b6fef988504d7
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
    motionManager = [[CMMotionManager alloc] init];
    motionManager.accelerometerUpdateInterval = .2;
    motionManager.gyroUpdateInterval = .2;

<<<<<<< HEAD
=======
    
    [motionManager startAccelerometerUpdatesToQueue:[NSOperationQueue currentQueue]
                                             withHandler:^(CMAccelerometerData  *accelerometerData, NSError *error) {
                                                 [self outputAccelerationData:accelerometerData.acceleration];
                                                 if(error){

                                                     NSLog(@"%@", error);
                                                 }
                                             }];
    
    
   // [self.motionManager startDeviceMotionUpdatesUsingReferenceFrame:CMAttitudeReferenceFrameXArbitraryCorrectedZVertical toQueue:[NSOperationQueue currentQueue] withHandler:^(CMDeviceMotion *motion, NSError *error) {
    /*
>>>>>>> ae17683cdc8cfe1853284fc7f54b6fef988504d7
    [motionManager startDeviceMotionUpdatesUsingReferenceFrame:CMAttitudeReferenceFrameXArbitraryCorrectedZVertical toQueue:[NSOperationQueue currentQueue] withHandler:^(CMDeviceMotion *motion, NSError *error) {
        [self outputAttitudeData:motion];
        if (error){
            NSLog(@"Error! %@", [error description]);
        }
     
    }];
<<<<<<< HEAD
    
    self.helpView.hidden = YES;
    self.helpView.alpha = 0;
    CGRect landScapeRight = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.height, [UIScreen mainScreen].bounds.size.width);
    self.helpView.frame = landScapeRight;
    self.helpView.bounds = landScapeRight;
    
    tabVC = (RFTabBarController*)self.parentViewController.parentViewController;
    lastdegreeVal = -1.00;
    tapToStoreAngle = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tappedScreen:)];
    tapToReplaceInnerAngle = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(replaceInnerAngle:)];
    tapToReplaceOuterAngle = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(replaceOuterAngle:)];
    inputBaseLength = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(setBaseLength:)];
    
    aOne = -1;
    bStep = -1;
    aTwo = -1;
    
    //[self drawSimpleLine:startPoint end:endPoint color:greencolor.CGColor];
    CGRect thisRect = self.parentViewController.view.bounds;
    TriangleView *myTriangles = [[TriangleView alloc] initWithFrame:thisRect];
    myTriangles.backgroundColor = [UIColor clearColor];
    
    [self.view addSubview:myTriangles]; //gets loaded after this in viewDidAppear
    self.degreeLabel.hidden = YES;
    
    innerAngleButton = nil;
    //baseLengthButton = nil;
    baseLengthText = nil;
    outerAngleButton = nil;
    startWithInnerAngle = YES;
}

-(void)viewDidAppear:(BOOL)animated{
   // NSUInteger subViews = [self.view.subviews count];
   // NSArray *triangeSublayers = ((TriangleView*)self.view.subviews[subViews-1]).layer.sublayers;
    NSArray *triangeSublayers = ((TriangleView*)self.view.subviews[3]).layer.sublayers;
    innerTriangleLayer = (CAShapeLayer *)triangeSublayers[1];
    outerTriangleLayer = (CAShapeLayer *)triangeSublayers[2];
    baseLengthLayer = (CAShapeLayer*)triangeSublayers[3];
    
    innerAngleEmphasis = (AngleLayer*)innerTriangleLayer.sublayers[0];
    baseLengthEmphasis = (AngleLayer*)baseLengthLayer.sublayers[0];
    outerAngleEmphasis = (AngleLayer*)outerTriangleLayer.sublayers[0];
    
    if ((aOne < 0) && (innerAngleButton == nil)) {
    innerAngleButton = [[UIButton alloc] initWithFrame:CGRectMake(innerAngleEmphasis.innerVertexPoint.x-100, innerAngleEmphasis.innerVertexPoint.y-75, 100, 50)];
    [innerAngleButton setTitle:@"Find Angle" forState:UIControlStateNormal];
    innerAngleButton.backgroundColor = [UIColor greenColor];
    [self.view addSubview:innerAngleButton];
    
    inputInnerAngle = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(inputInnerAngle:)];
    [innerAngleButton addGestureRecognizer:inputInnerAngle];
    }
    
    if (bStep<0 && (baseLengthText == nil)) {
        baseLengthText = [[UITextField alloc] initWithFrame:CGRectMake(baseLengthEmphasis.center.x+50, baseLengthEmphasis.center.y-50, 125, 50)];
        [baseLengthText setKeyboardType:UIKeyboardTypeNumbersAndPunctuation];
        baseLengthText.userInteractionEnabled = YES;
        baseLengthText.borderStyle = UITextBorderStyleLine;
        baseLengthText.text = @"Enter Distance";
        baseLengthText.delegate = self;
        baseLengthText.backgroundColor = [UIColor greenColor];
        baseLengthText.alpha = 0.0;
        baseLengthText.borderStyle = UITextBorderStyleNone;
        baseLengthText.textColor = [UIColor whiteColor];
        baseLengthText.textAlignment = NSTextAlignmentCenter;
        [self.view addSubview:baseLengthText];
    }
    
    if ((aTwo < 0) && (outerAngleButton == nil)) {
    outerAngleButton = [[UIButton alloc] initWithFrame:CGRectMake(outerAngleEmphasis.outerVertexPoint.x-100, outerAngleEmphasis.outerVertexPoint.y-75, 100, 50)];
    [outerAngleButton setTitle:@"Find Angle" forState:UIControlStateNormal];
    outerAngleButton.backgroundColor = [UIColor greenColor];
    [self.view addSubview:outerAngleButton];
    
        inputOuterAngle = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(inputOuterAngle:)];
    [outerAngleButton addGestureRecognizer:inputOuterAngle];
    }
}

-(void)setLayerStrokeLength:(AngleLayer *)layer value:(CGFloat)val{
    layer.strokeLength = val;
}
-(void)setLayerEndAngle:(AngleLayer *)layer value:(CGFloat)val{
    layer.endAngle = val;
=======
     */
>>>>>>> ae17683cdc8cfe1853284fc7f54b6fef988504d7
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
<<<<<<< HEAD
=======

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
>>>>>>> ae17683cdc8cfe1853284fc7f54b6fef988504d7

}

<<<<<<< HEAD
#pragma mark - Custom methods
=======
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

>>>>>>> ae17683cdc8cfe1853284fc7f54b6fef988504d7

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

<<<<<<< HEAD
#pragma mark - Core Motion Activity Update Handler Methods

-(void)outputAttitudeData:(CMDeviceMotion*)motion{
    //This is only necessary if the HeightViewController is on top of the Nav Controller
    if ([((RFNavigationController*)tabVC.selectedViewController).topViewController isKindOfClass:[HeightFinderViewController class]]){
    float degreeDec = -motion.gravity.y*90;
    degreesTilt = (int)round(degreeDec);
    if (degreesTilt >= 0){
        self.degreeLabel.text = [NSString stringWithFormat:@"%d°", degreesTilt];
        if (!self.degreeLabel.hidden && (degreesTilt != lastdegreeVal)){
        AudioServicesPlaySystemSound(0x450);
            lastdegreeVal = degreesTilt;
        }
    }
    else
        self.degreeLabel.text = @"0°";
=======
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
>>>>>>> ae17683cdc8cfe1853284fc7f54b6fef988504d7
    }
}

- (IBAction)setAngleOneButton:(UIButton *)sender
{
<<<<<<< HEAD
   // self.angleOne.text = [NSString stringWithFormat:@"%2.2f", degreesTilt];
=======
    //self.angleOneLabel.text = [NSString stringWithFormat:@"%2.1f", degreesTilt];
    angleOneButtonState = TRUE;
    // NSLog(@"Button state is %u", angleOneButtonState);
>>>>>>> ae17683cdc8cfe1853284fc7f54b6fef988504d7
}

- (IBAction)setAngleTwoButton:(UIButton *)sender
{
<<<<<<< HEAD
   // self.angleTwo.text = [NSString stringWithFormat:@"%2.2f", degreesTilt];
=======
    //self.angleTwoLabel.text = [NSString stringWithFormat:@"%2.1f", degreesTilt];
    angleTwoButtonState = TRUE;
>>>>>>> ae17683cdc8cfe1853284fc7f54b6fef988504d7
}

-(void)calculateHeight:(UITapGestureRecognizer*)gesture
{
// converts textfields to floats in radians to calculate the height
<<<<<<< HEAD
   // double bStep = [self.baseLength.text doubleValue];
   // double aOne = [self.angleOne.text doubleValue]/DEGREE_2_RADIAN;
   // double aTwo = [self.angleTwo.text doubleValue]/DEGREE_2_RADIAN;
=======
    double bStep = [self.baseLength.text doubleValue];
    double aOne = [self.angleOneLabel.text doubleValue]/DEGREE_2_RADIAN;
    double aTwo = [self.angleTwoLabel.text doubleValue]/DEGREE_2_RADIAN;
>>>>>>> ae17683cdc8cfe1853284fc7f54b6fef988504d7
    
    if (aTwo > aOne) {
        double temp = aTwo;
        aTwo = aOne;
        aOne = temp;
    }
    
// calculates the height based on 2 angles and a base length
    double h = YOUR_HEIGHT + (bStep * tan(aTwo) / (1-(tan(aTwo)/tan(aOne))));
<<<<<<< HEAD
    UILabel *heightLabel = [[UILabel alloc] initWithFrame:self.degreeLabel.frame];
    heightLabel.text = [NSString stringWithFormat:@"%f", h];
    [self.view addSubview:heightLabel];
=======
    
// prints value
    self.height.text = [NSString stringWithFormat:@"Object is %3.0f feet", h];
    NSLog(@"The height is %@", self.height.text);

>>>>>>> ae17683cdc8cfe1853284fc7f54b6fef988504d7
}

- (void)hideTap:(UIGestureRecognizer *)gestureRecognizer
{
    [self.view endEditing:YES];  // or [self.baseLength resignFirstResponder];
    
// resets dynamic data switch for angle textFields
    angleOneButtonState = FALSE;
    angleTwoButtonState = FALSE;
    //NSLog(@"Screen TAPPED button is %u", angleOneButtonState);
}

#pragma mark - Handler for screen tap
-(void)tappedScreen:(UITapGestureRecognizer*)gesture{
    
    innerAngleEmphasis.strokeLength = 0.0;
    outerAngleEmphasis.strokeLength = 0.0;
    
    //if (aOne < 0) {
    if (AngleVal == INNER_ANGLE_VALUE) {
    innerAngleLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.degreeLabel.frame.origin.x, self.degreeLabel.frame.origin.y, self.degreeLabel.bounds.size.width, self.degreeLabel.bounds.size.height)];
    innerAngleLabel.numberOfLines = 1;
    innerAngleLabel.adjustsFontSizeToFitWidth = YES;
    innerAngleLabel.minimumFontSize = self.degreeLabel.font.pointSize;
    innerAngleLabel.text = self.degreeLabel.text;
    [innerAngleLabel setFont:[UIFont systemFontOfSize:self.degreeLabel.font.pointSize]];
    innerAngleLabel.textAlignment = NSTextAlignmentCenter;
    [innerAngleLabel addGestureRecognizer:tapToReplaceInnerAngle];
    self.degreeLabel.hidden = YES;
    innerAngleLabel.center = self.degreeLabel.center;
    innerAngleLabel.userInteractionEnabled = YES;
    [self.view addSubview:innerAngleLabel];

    
    //we'll just try using a view transition for now
    [UIView animateWithDuration:0.75 animations:^{
        innerAngleLabel.transform = CGAffineTransformMakeScale(0.2, 0.2);
        innerAngleLabel.center = CGPointMake(innerAngleEmphasis.innerVertexPoint.x-25, innerAngleEmphasis.innerVertexPoint.y-10);
    }];
    aOne = (int)self.degreeLabel.text.integerValue;
    [self.view removeGestureRecognizer:tapToStoreAngle];
        self.degreeLabel.hidden = YES;
    
}

    if (bStep < 0) {
        baseLengthLayer.opacity = 1;
        baseLengthEmphasis.strokeLength += 2*baseLengthEmphasis.adjLength;
        [UIView transitionWithView:baseLengthText duration:0.75 options:UIViewAnimationOptionCurveEaseInOut animations:^{
            baseLengthText.alpha = 1.0;
        } completion:^(BOOL finished) {
            //
        }];
    }
    
    if (aTwo <0 && bStep >=0) {
        outerTriangleLayer.opacity = 1;
        outerAngleEmphasis.strokeLength = innerAngleEmphasis.innerVertexPoint.x + innerAngleEmphasis.rightAngleVertexPoint.x/2;
        self.degreeLabel.hidden = NO;
    }
    
        if (AngleVal==OUTER_ANGLE_VALUE) {
        outerAngleLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.degreeLabel.frame.origin.x, self.degreeLabel.frame.origin.y, self.degreeLabel.bounds.size.width, self.degreeLabel.bounds.size.height)];
        outerAngleLabel.numberOfLines = 1;
        outerAngleLabel.adjustsFontSizeToFitWidth = YES;
        outerAngleLabel.minimumFontSize = self.degreeLabel.font.pointSize;
        outerAngleLabel.text = self.degreeLabel.text;
        [outerAngleLabel setFont:[UIFont systemFontOfSize:self.degreeLabel.font.pointSize]];
        outerAngleLabel.textAlignment = NSTextAlignmentCenter;
        [outerAngleLabel addGestureRecognizer:tapToReplaceOuterAngle];
        self.degreeLabel.hidden = YES;
        outerAngleLabel.center = self.degreeLabel.center;
        outerAngleLabel.userInteractionEnabled = YES;
        [self.view addSubview:outerAngleLabel];
        
        [UIView animateWithDuration:0.75 animations:^{
            //firstAngleView.bounds.size = firstAngleView.bounds.size;
            outerAngleLabel.transform = CGAffineTransformMakeScale(0.2, 0.2);
            outerAngleLabel.center = CGPointMake(outerAngleEmphasis.outerVertexPoint.x-45, outerAngleEmphasis.outerVertexPoint.y-10);
        }];
        outerAngleEmphasis.strokeLength = 0.0;
            aTwo = (int)self.degreeLabel.text.integerValue;
            [self.view removeGestureRecognizer:tapToStoreAngle];
            self.degreeLabel.hidden = YES;
    }
    
    NSLog(@"Subview structure after adding the Angle label: %@", self.view.subviews);
    [self.view removeGestureRecognizer:tapToStoreAngle];
    AngleVal = !AngleVal;
    
    if ((aOne >=0) && (aTwo >=0) && (bStep >=0)) {
        calculateButton = [[UIButton alloc] initWithFrame:CGRectMake(self.degreeLabel.frame.origin.x, self.degreeLabel.frame.origin.y, self.degreeLabel.bounds.size.width, self.degreeLabel.bounds.size.height)];
        [calculateButton setTitle:@"Calculate" forState:UIControlStateNormal];
        calculateButton.backgroundColor = [UIColor greenColor];
        UITapGestureRecognizer *tapToCalculate = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(calculateHeight:)];
        [calculateButton addGestureRecognizer:tapToCalculate];
        [self.view addSubview:calculateButton];
    }
}

-(void)replaceInnerAngle:(UITapGestureRecognizer *)gesture{
    //[UIView animateWithDuration:0.75 animations:^{
    [UIView animateWithDuration:0.75 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        innerAngleLabel.transform = CGAffineTransformMakeScale(1.01, 1.01);
        innerAngleLabel.center = self.degreeLabel.center;
        //self.degreeLabel.hidden = NO;
        baseLengthEmphasis.strokeLength = 0.0;
        if (bStep<0) {
        baseLengthText.alpha = 0.0;
        }
        //baseLengthButton.alpha = 0.0;
        innerAngleEmphasis.strokeLength = innerAngleEmphasis.innerVertexPoint.x + innerAngleEmphasis.rightAngleVertexPoint.x/2;
        outerAngleEmphasis.strokeLength = 0.0;
        
    } completion:^(BOOL finished) {
        
        innerAngleLabel.hidden = YES;
        [innerAngleLabel removeFromSuperview];
      //  self.degreeLabel.hidden = NO;
        self.degreeLabel.hidden = NO;

       // NSUInteger topViewIndex = [self.view.subviews count]-1;
       // [self.view.subviews[topViewIndex] addSubview:self.degreeLabel];
        [self.view addGestureRecognizer:tapToStoreAngle];
    }];
    
    AngleVal = INNER_ANGLE_VALUE;
}

-(void)replaceOuterAngle:(UITapGestureRecognizer *)gesture{
    //[UIView animateWithDuration:0.75 animations:^{
    [UIView animateWithDuration:0.75 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        outerAngleLabel.transform = CGAffineTransformMakeScale(1.01, 1.01);
        outerAngleLabel.center = self.degreeLabel.center;
        //self.degreeLabel.hidden = NO;
        baseLengthEmphasis.strokeLength = 0.0;
        if (bStep<0) {
            baseLengthText.alpha = 0.0;
        }
        //baseLengthButton.alpha = 0.0;
        outerAngleEmphasis.strokeLength = innerAngleEmphasis.innerVertexPoint.x + innerAngleEmphasis.rightAngleVertexPoint.x/2;
        innerAngleEmphasis.strokeLength = 0.0;
        
    } completion:^(BOOL finished) {
        
        outerAngleLabel.hidden = YES;
        [outerAngleLabel removeFromSuperview];
        //  self.degreeLabel.hidden = NO;
        self.degreeLabel.hidden = NO;
        
        // NSUInteger topViewIndex = [self.view.subviews count]-1;
        // [self.view.subviews[topViewIndex] addSubview:self.degreeLabel];
        [self.view addGestureRecognizer:tapToStoreAngle];
    }];
    
    AngleVal = OUTER_ANGLE_VALUE;
}

-(void)textFieldDidBeginEditing:(UITextField *)textField{
    textField.text = @"";
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField{
   
    [textField resignFirstResponder];
    [UIView animateWithDuration:1.0 animations:^{
        textField.backgroundColor = [UIColor clearColor];
        textField.textColor = [UIColor blackColor];
        textField.textAlignment = NSTextAlignmentCenter;
        textField.adjustsFontSizeToFitWidth = YES;
        baseLengthEmphasis.strokeLength = 0.0;
        bStep = (int)textField.text.integerValue;

    } completion:^(BOOL finished) {
        //
        if ((aOne >= 0) && (aTwo <0)){
        outerAngleButton.hidden = YES;
        self.degreeLabel.hidden = NO;
        outerTriangleLayer.opacity = 1.0;
        outerAngleEmphasis.strokeLength = innerAngleEmphasis.innerVertexPoint.x + innerAngleEmphasis.rightAngleVertexPoint.x/2;
        outerAngleEmphasis.endAngle = -M_PI + acos(outerAngleEmphasis.adjLength/outerAngleEmphasis.hypLength);
            AngleVal = OUTER_ANGLE_VALUE;
        }
        else if ((aOne<0) && (aTwo>=0)){
            innerAngleButton.hidden = YES;
            self.degreeLabel.hidden = NO;
            innerTriangleLayer.opacity = 1.0;
            innerAngleEmphasis.strokeLength = innerAngleEmphasis.innerVertexPoint.x + innerAngleEmphasis.rightAngleVertexPoint.x/2;
            innerAngleEmphasis.endAngle = -M_PI + acos(innerAngleEmphasis.adjLength/innerAngleEmphasis.hypLength);
            AngleVal = INNER_ANGLE_VALUE;
        }
        else if ((aOne>=0) && (aTwo>0)){
            innerAngleButton.hidden = YES;
            outerAngleButton.hidden = YES;
        }
    }];
    
    [self.view addGestureRecognizer:tapToStoreAngle];
    
    return YES;
}

-(void)textFieldDidEndEditing:(UITextField *)textField{
    //[textField resignFirstResponder];
}

-(void)inputInnerAngle:(UITapGestureRecognizer *)gesture{
    
    startWithInnerAngle = YES;
    
    self.degreeLabel.hidden = NO;
    innerAngleButton.alpha = 0;
    outerAngleButton.alpha = 0;
    innerTriangleLayer.opacity = 1;
    innerAngleEmphasis.endAngle = -M_PI + acos(innerAngleEmphasis.adjLength/innerAngleEmphasis.hypLength);
    [self.view addGestureRecognizer:tapToStoreAngle];
    AngleVal = INNER_ANGLE_VALUE;
}

-(void)inputBaseLength:(UITapGestureRecognizer *)gesture{
    
    //maybe unused if we stick with the TextField approach
    
}

-(void)inputOuterAngle:(UITapGestureRecognizer *)gesture{
    self.degreeLabel.hidden = NO;
    startWithInnerAngle = NO;
    innerAngleButton.alpha = 0;
    outerAngleButton.alpha = 0;
    outerTriangleLayer.opacity = 1;
    outerAngleEmphasis.endAngle = -M_PI + acos(outerAngleEmphasis.adjLength/outerAngleEmphasis.hypLength);
    [self.view addGestureRecognizer:tapToStoreAngle];
    outerAngleEmphasis.strokeLength = outerAngleEmphasis.innerVertexPoint.x + outerAngleEmphasis.rightAngleVertexPoint.x/2;
    AngleVal = OUTER_ANGLE_VALUE;
}

@end
