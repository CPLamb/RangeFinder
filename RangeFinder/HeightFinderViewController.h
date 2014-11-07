//
//  HeightFinderViewController.h
//  RangeFinder
//
//  Created by Chris Lamb on 11/7/14.
//  Copyright (c) 2014 CPL Consulting. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HeightFinderViewController : UIViewController

@property (nonatomic, strong) IBOutlet NSNumber *baseLength;
@property (nonatomic, strong) IBOutlet NSNumber *angle;
@property (nonatomic, strong) IBOutlet NSNumber *height;

- (IBAction)setAngleButton:(UIButton *)sender;
- (IBAction)calculateButton:(UIButton *)sender;

@end
