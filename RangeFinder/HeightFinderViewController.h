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

@interface HeightFinderViewController : UIViewController

@property (nonatomic, strong) IBOutlet UITextField *baseLength;
@property (nonatomic, strong) IBOutlet UITextField *angleOne;
@property (nonatomic, strong) IBOutlet UITextField *angleTwo;
@property (nonatomic, strong) IBOutlet UILabel *height;
@property (readonly) CMAcceleration *acceleration;
@property (nonatomic, strong) IBOutlet UILabel *accelerationsLabel;

@property (strong, nonatomic) CMMotionManager *motionManager;

- (IBAction)setAngleButton:(UIButton *)sender;
- (IBAction)calculateButton:(UIButton *)sender;
- (IBAction)doneButton:(UIButton *)sender;

@end
