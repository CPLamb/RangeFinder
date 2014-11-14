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
@property (nonatomic, strong) IBOutlet UITextField *angleOne;
@property (nonatomic, strong) IBOutlet UITextField *angleTwo;
@property (nonatomic, strong) IBOutlet UILabel *height;

//@property (nonatomic, strong) CMAcceleration *myAcceleration;
@property (nonatomic, strong) IBOutlet UILabel *accelerationsLabel;
//@property (strong, nonatomic) CMMotionManager *motionManager;

- (IBAction)setAngleOneButton:(UIButton *)sender;
- (IBAction)setAngleTwoButton:(UIButton *)sender;

- (IBAction)calculateButton:(UIButton *)sender;
- (IBAction)doneButton:(UIButton *)sender;

@end
