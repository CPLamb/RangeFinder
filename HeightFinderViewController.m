//
//  HeightFinderViewController.m
//  RangeFinder
//
//  Created by Chris Lamb on 11/7/14.
//  Copyright (c) 2014 CPL Consulting. All rights reserved.
//

#import "HeightFinderViewController.h"

@implementation HeightFinderViewController{
    int degreesTilt;
    CMMotionManager *motionManager;
    RFTabBarController *tabVC;
    int lastdegreeVal;
    UITapGestureRecognizer *tapToStoreAngle;
    UITapGestureRecognizer *tapToReplaceFirstAngle;
    UITapGestureRecognizer *replaceBaseLength;
    UITapGestureRecognizer *inputInnerAngle;
    UITapGestureRecognizer *inputBaseLength;
    UITapGestureRecognizer *inputOuterAngle;
    UILabel *firstAngleLabel;
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
    
    int bStep;
    int aOne;
    int aTwo;
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
    lastdegreeVal = -1.00;
    tapToStoreAngle = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tappedScreen:)];
    tapToReplaceFirstAngle = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapToReplaceFirstAngle:)];
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
    
    /*
    if (bStep<0 && (baseLengthButton == nil)) {
    baseLengthButton = [[UIButton alloc] initWithFrame:CGRectMake(baseLengthEmphasis.center.x+50, baseLengthEmphasis.center.y-50, 125, 50)];
    [baseLengthButton setTitle:@"Enter Distance" forState:UIControlStateNormal];
    baseLengthButton.backgroundColor = [UIColor greenColor];
    baseLengthButton.alpha = 0.0;
    [self.view addSubview:baseLengthButton];
    
    inputBaseLength = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(inputBaseLength:)];
    [baseLengthButton addGestureRecognizer:inputBaseLength];
    }
    */
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
    
    inputOuterAngle = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(inputOuterAngle)];
    [outerAngleButton addGestureRecognizer:inputOuterAngle];
    }
}

-(void)setLayerStrokeLength:(AngleLayer *)layer value:(CGFloat)val{
    layer.strokeLength = val;
}
-(void)setLayerEndAngle:(AngleLayer *)layer value:(CGFloat)val{
    layer.endAngle = val;
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
    }
}

#pragma mark - Custom Methods

- (IBAction)setAngleOneButton:(UIButton *)sender
{
   // self.angleOne.text = [NSString stringWithFormat:@"%2.2f", degreesTilt];
}

- (IBAction)setAngleTwoButton:(UIButton *)sender
{
   // self.angleTwo.text = [NSString stringWithFormat:@"%2.2f", degreesTilt];
}

- (IBAction)calculateButton:(UIButton *)sender
{
// converts textfields to floats in radians to calculate the height
   // double bStep = [self.baseLength.text doubleValue];
   // double aOne = [self.angleOne.text doubleValue]/DEGREE_2_RADIAN;
   // double aTwo = [self.angleTwo.text doubleValue]/DEGREE_2_RADIAN;
    
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

#pragma mark - Handler for screen tap
-(void)tappedScreen:(UITapGestureRecognizer*)gesture{
    
   // aOne = self.degreeLabel.text.integerValue;
    
    innerAngleEmphasis.strokeLength = 0.0;
    
    if (aOne < 0) {
    firstAngleLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.degreeLabel.frame.origin.x, self.degreeLabel.frame.origin.y, self.degreeLabel.bounds.size.width, self.degreeLabel.bounds.size.height)];
    firstAngleLabel.numberOfLines = 1;
    firstAngleLabel.adjustsFontSizeToFitWidth = YES;
    firstAngleLabel.minimumFontSize = self.degreeLabel.font.pointSize;
    firstAngleLabel.text = self.degreeLabel.text;
    [firstAngleLabel setFont:[UIFont systemFontOfSize:self.degreeLabel.font.pointSize]];
    firstAngleLabel.textAlignment = NSTextAlignmentCenter;
    [firstAngleLabel addGestureRecognizer:tapToReplaceFirstAngle];
    self.degreeLabel.hidden = YES;
    firstAngleLabel.center = self.degreeLabel.center;
    firstAngleLabel.userInteractionEnabled = YES;
    [self.view addSubview:firstAngleLabel];
    //NSUInteger topViewIndex = [self.view.subviews count]-1;
    //[self.view.subviews[topViewIndex] addSubview:firstAngleLabel];
    
    //we'll just try using a view transition for now
    [UIView animateWithDuration:0.75 animations:^{
        //firstAngleView.bounds.size = firstAngleView.bounds.size;
        firstAngleLabel.transform = CGAffineTransformMakeScale(0.2, 0.2);
        //firstAngleLabel.center = CGPointMake(innerAngleLayer.innerVertexPoint.x-25, innerAngleLayer.innerVertexPoint.y-10);
        firstAngleLabel.center = CGPointMake(innerAngleEmphasis.innerVertexPoint.x-25, innerAngleEmphasis.innerVertexPoint.y-10);
    }];
    aOne = self.degreeLabel.text.integerValue;
    [self.view removeGestureRecognizer:tapToStoreAngle];
        self.degreeLabel.hidden = YES;
    // this is terrible form, but we'll double the value here since we draw half the arc length in the animation
    //baseLengthLayer.strokeLength += 2*baseLengthLayer.adjLength;
    
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
    
    if (aTwo >=0) {
        
        outerAngleLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.degreeLabel.frame.origin.x, self.degreeLabel.frame.origin.y, self.degreeLabel.bounds.size.width, self.degreeLabel.bounds.size.height)];
        outerAngleLabel.numberOfLines = 1;
        outerAngleLabel.adjustsFontSizeToFitWidth = YES;
        outerAngleLabel.minimumFontSize = self.degreeLabel.font.pointSize;
        outerAngleLabel.text = self.degreeLabel.text;
        [outerAngleLabel setFont:[UIFont systemFontOfSize:self.degreeLabel.font.pointSize]];
        outerAngleLabel.textAlignment = NSTextAlignmentCenter;
        [outerAngleLabel addGestureRecognizer:tapToReplaceFirstAngle];
        self.degreeLabel.hidden = YES;
        outerAngleLabel.center = self.degreeLabel.center;
        outerAngleLabel.userInteractionEnabled = YES;
        [self.view addSubview:outerAngleLabel];
        
        [UIView animateWithDuration:0.75 animations:^{
            //firstAngleView.bounds.size = firstAngleView.bounds.size;
            outerAngleLabel.transform = CGAffineTransformMakeScale(0.2, 0.2);
            //firstAngleLabel.center = CGPointMake(innerAngleLayer.innerVertexPoint.x-25, innerAngleLayer.innerVertexPoint.y-10);
            outerAngleLabel.center = CGPointMake(outerAngleEmphasis.outerVertexPoint.x-25, outerAngleEmphasis.outerVertexPoint.y-10);
        }];
        outerAngleEmphasis.strokeLength = 0.0;
    }
    
    //UITextField *baseLengthText = [[UITextField alloc] initWithFrame:CGRectMake(baseLengthLayer.strokeLength/2, 100.0, 70.0, 50.0)];
    
    
    
    NSLog(@"Subview structure after adding the Angle label: %@", self.view.subviews);
    [self.view removeGestureRecognizer:tapToStoreAngle];
}

-(void)tapToReplaceFirstAngle:(UITapGestureRecognizer *)gesture{
    //[UIView animateWithDuration:0.75 animations:^{
    [UIView animateWithDuration:0.75 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        firstAngleLabel.transform = CGAffineTransformMakeScale(1.01, 1.01);
        firstAngleLabel.center = self.degreeLabel.center;
        //self.degreeLabel.hidden = NO;
        baseLengthEmphasis.strokeLength = 0.0;
        if (bStep<0) {
        baseLengthText.alpha = 0.0;
        }
        //baseLengthButton.alpha = 0.0;
        innerAngleEmphasis.strokeLength = innerAngleEmphasis.innerVertexPoint.x + innerAngleEmphasis.rightAngleVertexPoint.x/2;
        outerAngleEmphasis.strokeLength = 0.0;
        
    } completion:^(BOOL finished) {
        
        firstAngleLabel.hidden = YES;
        [firstAngleLabel removeFromSuperview];
      //  self.degreeLabel.hidden = NO;
        self.degreeLabel.hidden = NO;

       // NSUInteger topViewIndex = [self.view.subviews count]-1;
       // [self.view.subviews[topViewIndex] addSubview:self.degreeLabel];
        [self.view addGestureRecognizer:tapToStoreAngle];
    }];
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
        bStep = textField.text.integerValue;
       // textField.center.y += 25;
       // textField.bounds.size.height += 20;
        //textField.hidden = YES;
    } completion:^(BOOL finished) {
        //
        outerAngleButton.hidden = YES;
        self.degreeLabel.hidden = NO;
        outerTriangleLayer.opacity = 1.0;
        outerAngleEmphasis.strokeLength = innerAngleEmphasis.innerVertexPoint.x + innerAngleEmphasis.rightAngleVertexPoint.x/2;
        outerAngleEmphasis.endAngle = -M_PI + acos(outerAngleEmphasis.adjLength/outerAngleEmphasis.hypLength);
    }];
    
    [self.view addGestureRecognizer:tapToStoreAngle];
    
   // baseLengthLabel = [[UILabel alloc] initWithFrame:CGRectMake(firstAngleLabel.frame.origin.x, firstAngleLabel.frame.origin.y, firstAngleLabel.bounds.size.width, firstAngleLabel.bounds.size.height)];
   // [self.view addSubview:baseLengthLabel];
    
   // NSUInteger subViews = [self.view.subviews count];
   // NSArray *triangeSublayers = ((TriangleView*)self.view.subviews[subViews-1]).layer.sublayers;
   // textField.backgroundColor = [UIColor clearColor];
   // textField.textColor = [UIColor blackColor];

    
    //outerAngleEmphasis.endAngle = -M_PI + acos(outerAngleEmphasis.adjLength/outerAngleEmphasis.hypLength);
    
    return YES;
}

-(void)textFieldDidEndEditing:(UITextField *)textField{
    //[textField resignFirstResponder];
}

-(void)inputInnerAngle:(UITapGestureRecognizer *)gesture{
    self.degreeLabel.hidden = NO;
    innerAngleButton.alpha = 0;
    innerTriangleLayer.opacity = 1;
    innerAngleEmphasis.endAngle = -M_PI + acos(innerAngleEmphasis.adjLength/innerAngleEmphasis.hypLength);
    [self.view addGestureRecognizer:tapToStoreAngle];
}

-(void)inputBaseLength:(UITapGestureRecognizer *)gesture{
    
    
    
}

-(void)inputOuterAngle:(UITapGestureRecognizer *)gesture{
    
}

@end
