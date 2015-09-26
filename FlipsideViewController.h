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
#import "DistantObject.h"

@interface FlipsideViewController : UIViewController <UIAlertViewDelegate>

@property NSMutableArray *heightObjects;   // data array
@property DistantObject *theDistantObject;

@property (nonatomic) float flagHeight;

@property (strong, nonatomic) IBOutlet UIPickerView *objectPicker;
@property (strong, nonatomic) IBOutlet UIPickerView *heightPicker;

@property (strong, nonatomic) UITextField *flipsideInfo;

@property (strong, nonatomic) IBOutlet UISegmentedControl *unitsSelector;
@property (strong, nonatomic) IBOutlet UISwitch *helpSwitch;
@property (strong, nonatomic) IBOutlet UIView *helpView;

- (IBAction)unitsSelected:(id)sender;

- (IBAction)hideHelpButton:(id)sender;
- (IBAction)showHelpButton:(id)sender;

- (IBAction)editButton:(id)sender;
- (IBAction)testButton:(UIButton *)sender;
- (IBAction)test2Button:(UIBarButtonItem *)sender;

@end
