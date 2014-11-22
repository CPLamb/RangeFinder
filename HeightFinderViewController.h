//
//  HeightFinderViewController.h
//  RangeFinder
//
//  Created by Chris Lamb on 11/7/14.
//  Copyright (c) 2014 CPL Consulting. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import <CoreMotion/CoreMotion.h>
#import <AudioToolbox/AudioToolbox.h>
#import "FlipsideViewController.h"
#import "RFTabBarController.h"
#import "TriangleView.h"

@interface HeightFinderViewController : UIViewController<UIGestureRecognizerDelegate>

@property (nonatomic, strong) IBOutlet UITextField *baseLength;
@property (nonatomic, strong) IBOutlet UITextField *angleOne;
@property (nonatomic, strong) IBOutlet UITextField *angleTwo;
@property (strong, nonatomic) IBOutlet UIView *helpView;

@property (weak, nonatomic) IBOutlet UILabel *degreeLabel;

- (IBAction)setAngleOneButton:(UIButton *)sender;
- (IBAction)setAngleTwoButton:(UIButton *)sender;
- (IBAction)calculateButton:(UIButton *)sender;
- (IBAction)doneButton:(UIButton *)sender;
- (IBAction)showHelpButton:(id)sender;
- (IBAction)hideHelpButton:(id)sender;
@end
