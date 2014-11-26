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

//<<<<<<< HEAD
@interface HeightFinderViewController : UIViewController<UIGestureRecognizerDelegate, UITextFieldDelegate>

@property (nonatomic, strong) IBOutlet UITextField *baseLength;
@property (nonatomic, strong) IBOutlet UITextField *angleOne;
@property (nonatomic, strong) IBOutlet UITextField *angleTwo;
@property (strong, nonatomic) IBOutlet UIView *helpView;
//=======
//@interface HeightFinderViewController : UIViewController <UIAlertViewDelegate>

//@property (nonatomic, strong) IBOutlet UITextField *baseLength;
@property (nonatomic, strong) IBOutlet UITextField *angleOneLabel;
@property (nonatomic, strong) IBOutlet UITextField *angleTwoLabel;

@property (nonatomic, strong) IBOutlet UILabel *height;
@property (nonatomic, strong) IBOutlet UITextField *objectName;
//>>>>>>> ae17683cdc8cfe1853284fc7f54b6fef988504d7

@property (weak, nonatomic) IBOutlet UILabel *degreeLabel;

@property (nonatomic, strong) IBOutlet UIButton *angleOneButton;
@property (nonatomic, strong) IBOutlet UIButton *angleTwoButton;

- (IBAction)setAngleOneButton:(UIButton *)sender;
- (IBAction)setAngleTwoButton:(UIButton *)sender;
- (IBAction)calculateButton:(UIButton *)sender;
//<<<<<<< HEAD
- (IBAction)doneButton:(UIButton *)sender;
//=======
@property (weak, nonatomic) IBOutlet UILabel *accelerationsLabel;

//@property (strong, nonatomic) IBOutlet UIView *helpView;

//>>>>>>> ae17683cdc8cfe1853284fc7f54b6fef988504d7
- (IBAction)showHelpButton:(id)sender;
- (IBAction)hideHelpButton:(id)sender;
@end
