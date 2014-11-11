//
//  FlipsideViewController.h
//  RangeFinder
//
//  Created by Chris Lamb on 6/3/12.
//  Copyright (c) 2012 CPL Consulting. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h> 

@class FlipsideViewController;

@protocol FlipsideViewControllerDelegate
- (void)flipsideViewControllerDidFinish:(FlipsideViewController *)controller;
@end

@interface FlipsideViewController : UIViewController {
    float flagHeight;
    float feetComponent;
    float inchesComponent;
}
@property (nonatomic) float flagheight;
@property (strong, nonatomic) NSString *flagUnits;
@property (strong, nonatomic) IBOutlet UILabel *flagValueString;
@property (strong, nonatomic) IBOutlet UILabel *objectString;
@property (strong, nonatomic) IBOutlet UIPickerView *objectPicker;

@property (weak, nonatomic) id <FlipsideViewControllerDelegate> delegate;

@property (strong, nonatomic) IBOutlet UIPickerView *heightPicker;
@property (strong, nonatomic) IBOutlet UILabel *heightMajorLabel;
@property (strong, nonatomic) IBOutlet UILabel *heightMinorLabel;

@property (strong, nonatomic) NSArray *pickerItems;
@property (strong, nonatomic) NSArray *objectPickerItems;

@property (strong, nonatomic) IBOutlet UITextField *flipsideInfo;
@property (strong, nonatomic) IBOutlet UISegmentedControl *unitsSelector;
@property (strong, nonatomic) IBOutlet UISwitch *helpSwitch;

- (IBAction)done:(id)sender;
- (IBAction)unitsSelected:(id)sender;

@end
