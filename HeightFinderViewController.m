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
    UILabel *firstAngleLabel;
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
    
    aOne = -1;
    bStep = -1;
    aTwo = -1;
    
    //[self drawSimpleLine:startPoint end:endPoint color:greencolor.CGColor];
    CGRect thisRect = self.parentViewController.view.bounds;
    TriangleView *myTriangles = [[TriangleView alloc] initWithFrame:thisRect];
    myTriangles.backgroundColor = [UIColor clearColor];
    
    [self.view addSubview:myTriangles]; //gets loaded after this in viewDidAppear
}

-(void)viewDidAppear:(BOOL)animated{
    NSUInteger subViews = [self.view.subviews count];
    NSArray *triangeSublayers = ((TriangleView*)self.view.subviews[subViews-1]).layer.sublayers;
    CAShapeLayer *innerTriangleLayer = (CAShapeLayer *)triangeSublayers[1];
    AngleLayer *innerAngleLayer = (AngleLayer*)innerTriangleLayer.sublayers[0];
    innerAngleLayer.endAngle = -M_PI + acos(innerAngleLayer.adjLength/innerAngleLayer.hypLength);
    
    //[self.degreeLabel removeFromSuperview];
    NSUInteger topViewIndex = [self.view.subviews count]-1;
    [self.view.subviews[topViewIndex] addSubview:self.degreeLabel];
    [self.view addGestureRecognizer:tapToStoreAngle];
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
    NSUInteger subViews = [self.view.subviews count];
    NSArray *triangeSublayers = ((TriangleView*)self.view.subviews[subViews-1]).layer.sublayers;
    CAShapeLayer *innerTriangleLayer = (CAShapeLayer *)triangeSublayers[1];
    AngleLayer *innerAngleLayer = (AngleLayer*)innerTriangleLayer.sublayers[0];
    
    CAShapeLayer *baseLayer = (CAShapeLayer *)triangeSublayers[3];
    AngleLayer *baseLengthLayer = (AngleLayer*)baseLayer.sublayers[0];
    
    NSLog(@"Triangle sublayer structure: %@", [triangeSublayers description]);
    //I think I like this. Shrinks the wedge to the vertex.
    innerAngleLayer.strokeLength = 0.0;
    
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
    //[self.view addSubview:firstAngleLabel];
    NSUInteger topViewIndex = [self.view.subviews count]-1;
    [self.view.subviews[topViewIndex] addSubview:firstAngleLabel];
    
    //we'll just try using a view transition for now
    [UIView animateWithDuration:0.75 animations:^{
        //firstAngleView.bounds.size = firstAngleView.bounds.size;
        firstAngleLabel.transform = CGAffineTransformMakeScale(0.2, 0.2);
        firstAngleLabel.center = CGPointMake(innerAngleLayer.innerVertexPoint.x-25, innerAngleLayer.innerVertexPoint.y-10);
    }];
    
    [self.view removeGestureRecognizer:tapToStoreAngle];
    // this is terrible form, but we'll double the value here since we draw half the arc length in the animation
    baseLengthLayer.strokeLength += 2*baseLengthLayer.adjLength;
    
    NSLog(@"Subview structure after adding the Angle label: %@", self.view.subviews);
}

-(void)tapToReplaceFirstAngle:(UITapGestureRecognizer *)gesture{
    //[UIView animateWithDuration:0.75 animations:^{
    [UIView animateWithDuration:0.75 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        firstAngleLabel.transform = CGAffineTransformMakeScale(1.01, 1.01);
        firstAngleLabel.center = self.degreeLabel.center;
        
        NSUInteger subViews = [self.view.subviews count];
        NSArray *triangeSublayers = ((TriangleView*)self.view.subviews[subViews-1]).layer.sublayers;
        CAShapeLayer *innerTriangleLayer = (CAShapeLayer *)triangeSublayers[1];
        AngleLayer *innerAngleLayer = (AngleLayer*)innerTriangleLayer.sublayers[0];
        //innerAngleLayer.endAngle = -M_PI + acos(innerAngleLayer.adjLength/innerAngleLayer.hypLength);
        innerAngleLayer.strokeLength = innerAngleLayer.innerVertexPoint.x + 25;
        
        CAShapeLayer *baseLayer = (CAShapeLayer *)triangeSublayers[3];
        AngleLayer *baseLengthLayer = (AngleLayer*)baseLayer.sublayers[0];
        baseLengthLayer.strokeLength = 0.0;
        
    } completion:^(BOOL finished) {
        
        firstAngleLabel.hidden = YES;
        self.degreeLabel.hidden = NO;
        /*
        NSUInteger subViews = [self.view.subviews count];
        NSArray *triangeSublayers = ((TriangleView*)self.view.subviews[subViews-1]).layer.sublayers;
        CAShapeLayer *innerTriangleLayer = (CAShapeLayer *)triangeSublayers[1];
        AngleLayer *innerAngleLayer = (AngleLayer*)innerTriangleLayer.sublayers[0];
        //innerAngleLayer.endAngle = -M_PI + acos(innerAngleLayer.adjLength/innerAngleLayer.hypLength);
        innerAngleLayer.strokeLength = innerAngleLayer.innerVertexPoint.x - 25.0;
        */
        //[self.degreeLabel removeFromSuperview];
        NSUInteger topViewIndex = [self.view.subviews count]-1;
        [self.view.subviews[topViewIndex] addSubview:self.degreeLabel];
        [self.view addGestureRecognizer:tapToStoreAngle];
    }
     /*
        //firstAngleView.bounds.size = firstAngleView.bounds.size;
        firstAngleLabel.transform = CGAffineTransformMakeScale(1.2, 1.2);
        firstAngleLabel.center = self.degreeLabel.center;
        
        
         firstAngleLabel.hidden = YES;
         self.degreeLabel.hidden = NO;
         NSUInteger subViews = [self.view.subviews count];
         NSArray *triangeSublayers = ((TriangleView*)self.view.subviews[subViews-1]).layer.sublayers;
         CAShapeLayer *innerTriangleLayer = (CAShapeLayer *)triangeSublayers[1];
         AngleLayer *innerAngleLayer = (AngleLayer*)innerTriangleLayer.sublayers[0];
         //innerAngleLayer.endAngle = -M_PI + acos(innerAngleLayer.adjLength/innerAngleLayer.hypLength);
         innerAngleLayer.strokeLength = 1.0;
         
         //[self.degreeLabel removeFromSuperview];
         NSUInteger topViewIndex = [self.view.subviews count]-1;
         [self.view.subviews[topViewIndex] addSubview:self.degreeLabel];
         [self.view addGestureRecognizer:tapToStoreAngle];
        */
        
    ];
}

@end
