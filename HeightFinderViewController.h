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
#import "FlipsideViewController.h"

@interface HeightFinderViewController : UIViewController

@property (nonatomic, strong) IBOutlet UITextField *baseLength;
@property (nonatomic, strong) IBOutlet UILabel *angleOneLabel;
@property (nonatomic, strong) IBOutlet UILabel *angleTwoLabel;

@property (nonatomic, strong) IBOutlet UILabel *height;

//@property (nonatomic, strong) CMAcceleration *myAcceleration;
@property (nonatomic, strong) IBOutlet UILabel *accelerationsLabel;
//@property (strong, nonatomic) CMMotionManager *motionManager;

- (IBAction)setAngleOneButton:(UIButton *)sender;
- (IBAction)setAngleTwoButton:(UIButton *)sender;

- (IBAction)calculateButton:(UIButton *)sender;

@property (strong, nonatomic) IBOutlet UIView *helpView;

- (IBAction)showHelpButton:(id)sender;
- (IBAction)hideHelpButton:(id)sender;
@end
