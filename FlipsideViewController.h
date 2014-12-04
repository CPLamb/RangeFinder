//
//  FlipsideViewController.h
//  RangeFinder
//
//  Created by Chris Lamb on 6/3/12.
//  Copyright (c) 2012 CPL Consulting. All rights reserved.
//
/*  This view is used for setup of the app including setting of the sighted object's
    height, app's length units and whatever else is necessary.
    The app uses a scrollView so that there is no restriction on setup items.UIGestureRecognizer
 */
//

#import <UIKit/UIKit.h>

@class FlipsideViewController;

@protocol FlipsideViewControllerDelegate
- (void)flipsideViewControllerDidFinish:(FlipsideViewController *)controller;
@end

@interface FlipsideViewController : UIViewController

@property NSMutableArray *heightObjects;

@property (nonatomic) float flagheight;
@property (strong, nonatomic) NSString *flagUnits;
@property (strong, nonatomic) IBOutlet UILabel *flagValueString;
@property (strong, nonatomic) IBOutlet UILabel *objectString;

@property (weak, nonatomic) id <FlipsideViewControllerDelegate> delegate;

@property (strong, nonatomic) IBOutlet UIPickerView *objectPicker;
@property (strong, nonatomic) IBOutlet UIPickerView *heightPicker;
@property (strong, nonatomic) IBOutlet UILabel *heightMajorLabel;
@property (strong, nonatomic) IBOutlet UILabel *heightMinorLabel;

@property (strong, nonatomic) IBOutlet UITextField *flipsideInfo;
@property (strong, nonatomic) IBOutlet UISegmentedControl *unitsSelector;
@property (strong, nonatomic) IBOutlet UISwitch *helpSwitch;
@property (weak, nonatomic) IBOutlet UILabel *objectEqualsLabel;
@property (strong, nonatomic) IBOutlet UIView *helpView;

- (IBAction)done:(id)sender;
- (IBAction)unitsSelected:(id)sender;

- (IBAction)hideHelpButton:(id)sender;
- (IBAction)showHelpButton:(id)sender;

- (IBAction)editButton:(id)sender;

@end
