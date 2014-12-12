//
//  HeightFinderViewController.h
//  RangeFinder
//
//  Created by Chris Lamb on 11/7/14.
//  Copyright (c) 2014 CPL Consulting. All rights reserved.
//
/*  This view is used for determining the height of an object using
    trig, the tangent of 2 angles.  The angles are determined by tilting the iPhone
    and recording the device's Y magnetomter tilt
 */
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import <CoreMotion/CoreMotion.h>
#import <AudioToolbox/AudioToolbox.h>
#import "FlipsideViewController.h"
#import "RFTabBarController.h"
#import "TriangleView.h"
#import "DistantObject.h"

@interface HeightFinderViewController : UIViewController<UIGestureRecognizerDelegate, UITextFieldDelegate>

@property (strong, nonatomic) IBOutlet UIView *helpView;

@property (nonatomic, strong) IBOutlet UILabel *height;
@property (nonatomic, strong) IBOutlet UITextField *objectName;

@property (weak, nonatomic) IBOutlet UIButton *calculateButtonObject;

@property (weak, nonatomic) IBOutlet UILabel *degreeLabel;
@property (weak, nonatomic) IBOutlet UILabel *accelerationsLabel;

@property (nonatomic, strong) IBOutlet UITextField *baseLength;
@property (nonatomic, strong) IBOutlet UITextField *angleOneLabel;
@property (nonatomic, strong) IBOutlet UITextField *angleTwoLabel;
@property (nonatomic, strong) IBOutlet UIButton *angleOneButton;
@property (nonatomic, strong) IBOutlet UIButton *angleTwoButton;

- (IBAction)setAngleOneButton:(UIButton *)sender;
- (IBAction)setAngleTwoButton:(UIButton *)sender;

- (IBAction)calculateButton:(UIButton *)sender;
- (IBAction)showHelpButton:(id)sender;
- (IBAction)hideHelpButton:(id)sender;

- (IBAction)addButton:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UILabel *testString;

/*

 @interface HeightFinderViewController : UIViewController
 
 @property (nonatomic, strong) IBOutlet UITextField *baseLength;
 @property (nonatomic, strong) IBOutlet UITextField *angleOneLabel;
 @property (nonatomic, strong) IBOutlet UITextField *angleTwoLabel;
 
 @property (nonatomic, strong) IBOutlet UILabel *height;
 @property (nonatomic, strong) IBOutlet UITextField *objectName;
 
 //@property (nonatomic, strong) CMAcceleration *myAcceleration;
 @property (nonatomic, strong) IBOutlet UILabel *accelerationsLabel;
 //@property (strong, nonatomic) CMMotionManager *motionManager;
 
 @property (nonatomic, strong) IBOutlet UIButton *angleOneButton;
 @property (nonatomic, strong) IBOutlet UIButton *angleTwoButton;
 
 - (IBAction)setAngleOneButton:(UIButton *)sender;
 - (IBAction)setAngleTwoButton:(UIButton *)sender;
 
 - (IBAction)calculateButton:(UIButton *)sender;
 
 @property (strong, nonatomic) IBOutlet UIView *helpView;
 
 - (IBAction)showHelpButton:(id)sender;
 - (IBAction)hideHelpButton:(id)sender;
 
 
*/

@end
