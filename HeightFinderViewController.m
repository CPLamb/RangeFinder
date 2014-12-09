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
    UIButton *startOverButton;
    UITextField *baseLengthText;
    //UIButton *baseLengthButton;
    UIButton *outerAngleButton;
    UIButton *calculateButton;
    
    BOOL startWithInnerAngle;
    enum findValueForAngle AngleVal;
    
    int bStep;
    int aOne;
    int aTwo;

    BOOL angleOneButtonState;
    BOOL angleTwoButtonState;
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
    self.objectName.text = [NSString stringWithFormat:@"Stanford Tree"];

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
    
    /*
   // [self.motionManager startDeviceMotionUpdatesUsingReferenceFrame:CMAttitudeReferenceFrameXArbitraryCorrectedZVertical toQueue:[NSOperationQueue currentQueue] withHandler:^(CMDeviceMotion *motion, NSError *error) {
     */

    [motionManager startDeviceMotionUpdatesUsingReferenceFrame:CMAttitudeReferenceFrameXArbitraryCorrectedZVertical toQueue:[NSOperationQueue currentQueue] withHandler:^(CMDeviceMotion *motion, NSError *error) {
        [self outputAttitudeData:motion];
        if (error){
            NSLog(@"Error! %@", [error description]);
        }
     
    }];
   
    // self.helpView.alpha = 0;
    CGRect landScapeRight = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.height, [UIScreen mainScreen].bounds.size.width);
    self.helpView.frame = landScapeRight;
    self.helpView.bounds = landScapeRight;
    
    tabVC = (RFTabBarController*)self.parentViewController.parentViewController;
    lastdegreeVal = -1.00;
    tapToStoreAngle = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tappedScreen:)];
    tapToReplaceInnerAngle = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(replaceInnerAngle:)];
    tapToReplaceOuterAngle = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(replaceOuterAngle:)];
   // inputBaseLength = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(setBaseLength:)];
    
    aOne = -1;
    bStep = -1;
    aTwo = -1;
    
    //[self drawSimpleLine:startPoint end:endPoint color:greencolor.CGColor];
    CGRect thisRect = self.parentViewController.view.bounds;
    TriangleView *myTriangles = [[TriangleView alloc] initWithFrame:thisRect];
    myTriangles.backgroundColor = [UIColor clearColor];
    
    [self.view addSubview:myTriangles]; //gets loaded after this in viewDidAppear
 //   self.degreeLabel.hidden = YES;
    
    innerAngleButton = nil;
    //baseLengthButton = nil;
    baseLengthText = nil;
    outerAngleButton = nil;
    startWithInnerAngle = YES;
 //   self.calculateButtonObject.hidden = YES;
//    self.height.hidden = YES;
}

-(void)makeInnerAngleButton{
    innerAngleButton = [[UIButton alloc] initWithFrame:CGRectMake(innerAngleEmphasis.innerVertexPoint.x-100, innerAngleEmphasis.innerVertexPoint.y-50, 100, 50)];
    [innerAngleButton setTitle:@"Find Angle" forState:UIControlStateNormal];
    innerAngleButton.backgroundColor = [UIColor whiteColor];
    innerAngleButton.layer.borderColor = [UIColor yellowColor].CGColor;
    innerAngleButton.layer.borderWidth = 1;
    innerAngleButton.layer.cornerRadius = 20;
    innerAngleButton.layer.masksToBounds = YES;
    innerAngleButton.titleLabel.textColor = [UIColor blackColor];
    [self.view addSubview:innerAngleButton];
    
    inputInnerAngle = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(inputInnerAngle:)];
    [innerAngleButton addGestureRecognizer:inputInnerAngle];
}

-(void)makeOuterAngleButton{
    outerAngleButton = [[UIButton alloc] initWithFrame:CGRectMake(outerAngleEmphasis.outerVertexPoint.x-100, outerAngleEmphasis.outerVertexPoint.y-50, 100, 50)];
    [outerAngleButton setTitle:@"Find Angle" forState:UIControlStateNormal];
    outerAngleButton.backgroundColor = [UIColor whiteColor];
    outerAngleButton.layer.borderColor = [UIColor yellowColor].CGColor;
    outerAngleButton.layer.borderWidth = 1;
    outerAngleButton.layer.cornerRadius = 20;
    outerAngleButton.layer.borderWidth = 1;
    outerAngleLabel.layer.masksToBounds = YES;
    outerAngleButton.titleLabel.textColor = [UIColor blackColor];
    [self.view addSubview:outerAngleButton];
    
    inputOuterAngle = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(inputOuterAngle:)];
    [outerAngleButton addGestureRecognizer:inputOuterAngle];
}

-(void)makeBaseLengthTextField{
    baseLengthText = [[UITextField alloc] initWithFrame:CGRectMake(baseLengthEmphasis.center.x+25, baseLengthEmphasis.center.y-50, 125, 50)];
    [baseLengthText setKeyboardType:UIKeyboardTypeNumbersAndPunctuation];
    baseLengthText.userInteractionEnabled = YES;
    baseLengthText.borderStyle = UITextBorderStyleLine;
    baseLengthText.text = @"Enter Distance";
    baseLengthText.delegate = self;
    baseLengthText.backgroundColor = [UIColor greenColor];
    baseLengthText.layer.cornerRadius = 20;
    baseLengthText.alpha = 0.0;
    baseLengthText.borderStyle = UITextBorderStyleNone;
    baseLengthText.textColor = [UIColor whiteColor];
    baseLengthText.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:baseLengthText];
}

-(void)viewDidAppear:(BOOL)animated{
   // NSUInteger subViews = [self.view.subviews count];
   // NSArray *triangeSublayers = ((TriangleView*)self.view.subviews[subViews-1]).layer.sublayers;
    //NSLog(@"Subview Structure: %@", [self.view.subviews description]);
   
    //just for now we'll re-index the triangle Sublayers, but this VC needs to assign controls programmatically.
    //NSArray *triangeSublayers = ((TriangleView*)self.view.subviews[3]).layer.sublayers;
    NSArray *triangeSublayers = ((TriangleView*)self.view.subviews[[self.view.subviews count]-1]).layer.sublayers;
    innerTriangleLayer = (CAShapeLayer *)triangeSublayers[1];
    outerTriangleLayer = (CAShapeLayer *)triangeSublayers[2];
    baseLengthLayer = (CAShapeLayer*)triangeSublayers[3];
    
    innerAngleEmphasis = (AngleLayer*)innerTriangleLayer.sublayers[0];
    baseLengthEmphasis = (AngleLayer*)baseLengthLayer.sublayers[0];
    outerAngleEmphasis = (AngleLayer*)outerTriangleLayer.sublayers[0];
    
    if ((aOne < 0) && (innerAngleButton == nil))
        [self makeInnerAngleButton];
    
    if (bStep<0 && (baseLengthText == nil))
        [self makeBaseLengthTextField];
    
    if ((aTwo < 0) && (outerAngleButton == nil))
        [self makeOuterAngleButton];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Core Motion Activity Update Handler Methods

-(void)outputAccelerationData:(CMAcceleration)acceleration
{
    // Tilt is the arcTan(Opposite accel Y / Adjacent accel X)
    //double tilt = atan(acceleration.y / acceleration.x)*DEGREE_2_RADIAN;
    degreesTilt = (int)round(atan(acceleration.y / acceleration.x)*DEGREE_2_RADIAN);
 //   degreesTilt = tilt;
 //   self.accelerationsLabel.text = [NSString stringWithFormat:@"Current angle = %2.0f", degreesTilt];
    
// loads degreeTilt into angle textFields when the field is selected
 //   if (angleOneButtonState) {
 //       self.angleOneLabel.text = [NSString stringWithFormat:@"%2.0f", degreesTilt];
 //   }
 //   if (angleTwoButtonState) {
 //       self.angleTwoLabel.text = [NSString stringWithFormat:@"%2.0f", degreesTilt];
 //   }
//>>>>>>> ae17683cdc8cfe1853284fc7f54b6fef988504d7

}

#pragma mark - Custom Methods

- (void)flipsideViewControllerDidFinish:(FlipsideViewController *)controller
{
    NSLog(@" setup delegate call");
/*    // sets myAssistantLabel ON/OFF
    if (controller.helpSwitch.on) {
        self.myAssistantLabel.hidden = NO;
    } else {
        self.myAssistantLabel.hidden = YES;
    }
    self.myAssistantLabel.text = controller.flipsideInfo.text;
    [self dismissModalViewControllerAnimated:YES];
    flagHeight = [controller.flipsideInfo.text floatValue];
    NSLog(@"FlagHeight is %3.3f", flagHeight);
    //self.distanceUnits = controller.flagUnits;
    distanceUnits = controller.flagUnits;
*/
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

/*
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
*/
//<<<<<<< HEAD
#pragma mark - Core Motion Activity Update Handler Methods

-(void)outputAttitudeData:(CMDeviceMotion*)motion{
    //This is only necessary if the HeightViewController is on top of the Nav Controller
    if ([((RFNavigationController*)tabVC.selectedViewController).topViewController isKindOfClass:[HeightFinderViewController class]]){
  //  float degreeDec = -motion.gravity.y*90;
 //   degreesTilt = (int)round(degreeDec);
    if (degreesTilt >= 0){
        self.degreeLabel.text = [NSString stringWithFormat:@"%d°", degreesTilt];
        if (!self.degreeLabel.hidden && (degreesTilt != lastdegreeVal)){
        AudioServicesPlaySystemSound(0x450);
            lastdegreeVal = degreesTilt;
        }
    }
    else
        self.degreeLabel.text = @"0°";
    }
}
//=======
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
        NSLog(@"buttonIndex = %ld", (long)buttonIndex);
        //self.objectName = [alertView textFieldAtIndex:buttonIndex];
        //NSLog(@"ObjectName is %@", self.objectName.text);
    } else {
        NSLog(@"buttonIndex = %d", buttonIndex);
    }
}

-(void)calculateButton:(UIButton *)sender{
// converts textfields to floats in radians to calculate the height
 //   double bStep = [self.baseLength.text doubleValue];
 //   double aOne = [self.angleOneLabel.text doubleValue]/DEGREE_2_RADIAN;
 //   double aTwo = [self.angleTwoLabel.text doubleValue]/DEGREE_2_RADIAN;
    
    if (aTwo > aOne) {
        double temp = aTwo;
        aTwo = aOne;
        aOne = temp;
    }
    
// calculates the height based on 2 angles and a base length
    double h = YOUR_HEIGHT + (bStep * tan(aTwo) / (1-(tan(aTwo)/tan(aOne))));
//<<<<<<< HEAD
    //UILabel *heightLabel = [[UILabel alloc] initWithFrame:self.degreeLabel.frame];
    //heightLabel.text = [NSString stringWithFormat:@"%f", h];
    //[self.view addSubview:heightLabel];
    
    self.height.text =[NSString stringWithFormat:@"Tree is %3.0f feet high", h];
    self.height.hidden = NO;
    [self.height removeFromSuperview];
    [self.view addSubview:self.height];
    
 //   self.calculateButtonObject.hidden = YES;
    
    startOverButton = [[UIButton alloc] initWithFrame:self.calculateButtonObject.frame];
    startOverButton.layer.cornerRadius = self.calculateButtonObject.layer.cornerRadius;
    startOverButton.backgroundColor = self.calculateButtonObject.backgroundColor;
    [startOverButton setTitle:@"Start Over" forState:UIControlStateNormal];
    
    UITapGestureRecognizer *tapToStartOver = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(startOver:)];
    [startOverButton addGestureRecognizer:tapToStartOver];
    [self.view addSubview:startOverButton];
}

#pragma mark - Handlers for screen tap

-(void)tappedScreen:(UITapGestureRecognizer*)gesture{
    
    innerAngleEmphasis.strokeLength = 0.0;
    outerAngleEmphasis.strokeLength = 0.0;
    
    //if (aOne < 0) {
    if (AngleVal == INNER_ANGLE_VALUE) {
    innerAngleLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.degreeLabel.frame.origin.x, self.degreeLabel.frame.origin.y, self.degreeLabel.bounds.size.width, self.degreeLabel.bounds.size.height)];
    innerAngleLabel.numberOfLines = 1;
    innerAngleLabel.adjustsFontSizeToFitWidth = YES;
  //  innerAngleLabel.minimumFontSize = self.degreeLabel.font.pointSize;
    innerAngleLabel.text = self.degreeLabel.text;
    [innerAngleLabel setFont:[UIFont systemFontOfSize:self.degreeLabel.font.pointSize]];
    innerAngleLabel.textAlignment = NSTextAlignmentCenter;
    [innerAngleLabel addGestureRecognizer:tapToReplaceInnerAngle];
//    self.degreeLabel.hidden = YES;
    innerAngleLabel.center = self.degreeLabel.center;
    innerAngleLabel.userInteractionEnabled = YES;
    innerAngleLabel.textColor = [UIColor blackColor];
    [self.view addSubview:innerAngleLabel];

    
    //we'll just try using a view transition for now
    [UIView animateWithDuration:0.75 animations:^{
        innerAngleLabel.transform = CGAffineTransformMakeScale(0.33, 0.33);
        innerAngleLabel.center = CGPointMake(innerAngleEmphasis.innerVertexPoint.x-25, innerAngleEmphasis.innerVertexPoint.y-10);
    }];
    aOne = (int)self.degreeLabel.text.integerValue;
    [self.view removeGestureRecognizer:tapToStoreAngle];
 //       self.degreeLabel.hidden = YES;
    
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
      //  outerAngleLabel.minimumFontSize = self.degreeLabel.font.pointSize;
        outerAngleLabel.text = self.degreeLabel.text;
        [outerAngleLabel setFont:[UIFont systemFontOfSize:self.degreeLabel.font.pointSize]];
        outerAngleLabel.textAlignment = NSTextAlignmentCenter;
        [outerAngleLabel addGestureRecognizer:tapToReplaceOuterAngle];
 //       self.degreeLabel.hidden = YES;
        outerAngleLabel.center = self.degreeLabel.center;
        outerAngleLabel.userInteractionEnabled = YES;
        outerAngleLabel.textColor = [UIColor blackColor];
        [self.view addSubview:outerAngleLabel];
        
        [UIView animateWithDuration:0.75 animations:^{
            //firstAngleView.bounds.size = firstAngleView.bounds.size;
            outerAngleLabel.transform = CGAffineTransformMakeScale(0.33, 0.33);
            outerAngleLabel.center = CGPointMake(outerAngleEmphasis.outerVertexPoint.x-45, outerAngleEmphasis.outerVertexPoint.y-10);
        }];
        outerAngleEmphasis.strokeLength = 0.0;
            aTwo = (int)self.degreeLabel.text.integerValue;
            [self.view removeGestureRecognizer:tapToStoreAngle];
//            self.degreeLabel.hidden = YES;
    }
    
    //NSLog(@"Subview structure after adding the Angle label: %@", self.view.subviews);
    [self.view removeGestureRecognizer:tapToStoreAngle];
    AngleVal = !AngleVal;
    
    if ((aOne >=0) && (aTwo >=0) && (bStep >=0)) {
        /*
        calculateButton = [[UIButton alloc] initWithFrame:CGRectMake(self.degreeLabel.frame.origin.x, self.degreeLabel.frame.origin.y, self.degreeLabel.bounds.size.width, self.degreeLabel.bounds.size.height)];
        [calculateButton setTitle:@"Calculate" forState:UIControlStateNormal];
        calculateButton.backgroundColor = [UIColor greenColor];
        UITapGestureRecognizer *tapToCalculate = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(calculateHeight:)];
        [calculateButton addGestureRecognizer:tapToCalculate];
        [self.view addSubview:calculateButton];
         */
        self.calculateButtonObject.hidden = NO;
        //self.calculateButtonObject.enabled = YES;
        //self.calculateButtonObject.userInteractionEnabled = YES;
 //       [self.calculateButtonObject removeFromSuperview];
        [self.view addSubview:self.calculateButtonObject];
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
        if (bStep <0)
            textField.center = CGPointMake(textField.center.x, textField.center.y+15);
        
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
    
    //startWithInnerAngle = YES;
    
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

-(void)hideTap:(UITapGestureRecognizer *)gesture{
    //stubbed
}

-(void)startOver:(UITapGestureRecognizer*)gesture{
    baseLengthText.hidden = YES;
    baseLengthText = nil;
    innerAngleLabel.hidden = YES;
    outerAngleLabel.hidden = YES;
    innerAngleLabel = nil;
    outerAngleLabel = nil;
    innerAngleButton.alpha = 1;
    outerAngleButton.alpha = 1;
//    self.degreeLabel.hidden = YES;
//    self.height.hidden = YES;
    aOne = -1;
    aTwo = -1;
    bStep = -1;
    baseLengthText.center = CGPointMake(baseLengthText.center.x, baseLengthText.center.y+15);
    startOverButton.hidden=YES;
    startOverButton = nil;
    
    [self makeInnerAngleButton];
    [self makeBaseLengthTextField];
    [self makeOuterAngleButton];
    
}

@end
