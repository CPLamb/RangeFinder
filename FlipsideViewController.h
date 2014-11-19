//
//  FlipsideViewController.h
//  RangeFinder
//
//  Created by Chris Lamb on 6/3/12.
//  Copyright (c) 2012 CPL Consulting. All rights reserved.
//

#import <UIKit/UIKit.h>

@class FlipsideViewController;

@protocol FlipsideViewControllerDelegate
- (void)flipsideViewControllerDidFinish:(FlipsideViewController *)controller;
@end

@interface FlipsideViewController : UIViewController

@property (nonatomic) float flagheight;
@property (strong, nonatomic) NSString *flagUnits;
@property (strong, nonatomic) IBOutlet UILabel *flagValueString;
@property (strong, nonatomic) IBOutlet UILabel *objectString;
@property (strong, nonatomic) IBOutlet UIPickerView *objectPicker;

@property (weak, nonatomic) id <FlipsideViewControllerDelegate> delegate;

@property (strong, nonatomic) IBOutlet UIPickerView *heightPicker;
@property (strong, nonatomic) IBOutlet UILabel *heightMajorLabel;
@property (strong, nonatomic) IBOutlet UILabel *heightMinorLabel;

//@property (strong, nonatomic) NSArray *pickerItems;
//@property (strong, nonatomic) NSArray *objectPickerItems;

@property (strong, nonatomic) IBOutlet UITextField *flipsideInfo;
@property (strong, nonatomic) IBOutlet UISegmentedControl *unitsSelector;
@property (strong, nonatomic) IBOutlet UISwitch *helpSwitch;

//<<<<<<< HEAD:FlipsideViewController.h
@property (weak, nonatomic) IBOutlet UILabel *objectEqualsLabel;
//=======
@property (strong, nonatomic) IBOutlet UIView *helpView;
//>>>>>>> 262514d0c77a08c21caa6d57f6ae6ff8290bb89e:RangeFinder/FlipsideViewController.h

- (IBAction)done:(id)sender;
- (IBAction)unitsSelected:(id)sender;

- (IBAction)hideHelpButton:(id)sender;
- (IBAction)showHelpButton:(id)sender;

- (IBAction)editButton:(id)sender;

@end
