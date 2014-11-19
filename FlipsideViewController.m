//
//  FlipsideViewController.m
//  RangeFinder
//
//  Created by Chris Lamb on 6/3/12.
//  Copyright (c) 2012 CPL Consulting. All rights reserved.
//

#import "FlipsideViewController.h"

@implementation FlipsideViewController{
    NSArray *pickerItems;
    NSArray *objectPickerItems;
    NSArray *inchesPicker;
    NSDictionary *objectSizes;
    float flagHeight;
    float feetComponent;
    float inchesComponent;
}
@synthesize objectString = _objectString;

#pragma mark - Lifecycle Methods

- (void)viewDidLoad
{
    [super viewDidLoad];
    pickerItems = [[NSArray alloc] initWithObjects:@"0", @"1", @"2", @"3", @"4", @"5", @"6", @"7", @"8", @"9", @"10", @"11", @"12", @"15", @"20", @"30", @"40", @"50", nil];
    inchesPicker = [[NSArray alloc] initWithObjects:@"0", @"1", @"2", @"3", @"4", @"5", @"6", @"7", @"8", @"9", @"10", @"11", nil];
    objectPickerItems = [[NSArray alloc] initWithObjects:@" ",@"Add Object",@"None", @"Light switch", @"Car", @"Person", @"Door", @"Golf flag", @"Utility pole", @"Sailboat", @"Lighthouse",@"+", nil];
    
// sets defaults for the Picker
    self.heightMajorLabel.text = @"feet";
    self.heightMinorLabel.text = @"inches";
    self.unitsSelector.selectedSegmentIndex = 1;
    self.flagUnits = @"feet";
    
    self.objectString.text = @"Golf flag";
    self.flagValueString.text = @"";
    self.objectEqualsLabel.hidden = YES;
    
    self.helpView.hidden = YES;
    
    NSString *objectSizesPlist = [[NSBundle mainBundle] pathForResource:@"ObjectSizes" ofType:@"plist"];
    objectSizes = [[NSDictionary alloc] initWithContentsOfFile:objectSizesPlist];
    // NSLog(@"The dictionary %@", objectSizes);
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - Custom Methods

- (IBAction)editButton:(id)sender
{
    NSString *messageString = [NSString stringWithFormat:@"Delete %@ ?", self.objectString.text];
    UIAlertView *message = [[UIAlertView alloc] initWithTitle:@"Edit Object List"
                                                      message:messageString
                                                     delegate:nil
                                            cancelButtonTitle:@"Delete"
                                            otherButtonTitles:@"Cancel",nil];
    [message setAlertViewStyle:UIAlertViewStyleDefault];
    [message show];
}

- (IBAction)showHelpButton:(id)sender
{
    NSLog(@"slides up a transparency that describes the buttons below");
    if (self.helpView.hidden) {
        self.helpView.hidden = NO;
    }
}

- (IBAction)hideHelpButton:(id)sender
{
    //    NSLog(@"hides the transparency that describes the buttons below");
    if (!self.helpView.hidden) {
        self.helpView.hidden = YES;
    }
}

- (IBAction)done:(id)sender
{
    [self.delegate flipsideViewControllerDidFinish:self];
}

- (IBAction)unitsSelected:(id)sender
{
    switch(self.unitsSelector.selectedSegmentIndex) {
        case 0:
            self.flagUnits =  @"yards";
            self.heightMajorLabel.text = @"yards";
            self.heightMinorLabel.text = @"inches";
            break;
        case 1:
            self.flagUnits =  @"feet";
            self.heightMajorLabel.text = @"feet";
            self.heightMinorLabel.text = @"inches";
            break;
        case 2:
            self.flagUnits =  @"meters";
            self.heightMajorLabel.text = @"meters";
            self.heightMinorLabel.text = @"cms";
            break;
    }
    NSLog(@"Units selected are %@", self.flagUnits);
}

#pragma mark ---- UIPickerViewDataSource delegate methods ----

// returns the number of columns to display.
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    //return 2;
    if (pickerView == self.heightPicker)
        return 2;
    
    if (pickerView == self.objectPicker)
        return 1;
    
    return -1;  //we'll use this as an error condition
}

#pragma mark ---- UIPickerViewDelegate delegate methods ----

// returns the number of rows
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
	//return [self.pickerItems count];
    
    if (pickerView == self.heightPicker){
        //return [self.pickerItems count];
        if (component == 0)
           return [pickerItems count];
        return [inchesPicker count];
        }
    
    if (pickerView == self.objectPicker)
        //return [self.objectPickerItems count];
        return [objectPickerItems count];
    
    return -1; //error condition
}

// returns the title of each row
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    if (pickerView == self.heightPicker){
        if (component == 0)
            return [pickerItems objectAtIndex:row];
        return [inchesPicker objectAtIndex:row];
    }
    
    if (pickerView == self.objectPicker)
        //return [self.objectPickerItems objectAtIndex:row];
        return [objectPickerItems objectAtIndex:row];
    
    return nil; //error condition
}

// gets called when the user settles on a row
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    if (pickerView == self.heightPicker) {
        NSString *componentValue = [pickerItems objectAtIndex:row];
        
        // assigns row values to feet or inches & calculates the fractional feet
        if (component == 0) {
            feetComponent = [componentValue floatValue];
        }
        if (component == 1) {
            inchesComponent = [componentValue floatValue];
        }
        // calculates fractional feet value
        flagHeight = feetComponent + (inchesComponent / 12);
        
// FlipsideInfo is string sent to MainV
        self.flipsideInfo.text = [NSString stringWithFormat:@"%@ is %2.2f", self.objectString.text, flagHeight];
        NSLog(@"Object %@ is %2.2f", self.objectString.text, flagHeight);
        
        // displays value & units
        self.flagValueString.text = [[self.flipsideInfo.text stringByAppendingString:@"  " ] stringByAppendingString:self.flagUnits];
        
    }
    
    if (pickerView == self.objectPicker){
       // NSString *selectedObject = [self.objectPickerItems objectAtIndex:row];
        NSString *selectedObject = [objectPickerItems objectAtIndex:row];
        if ([selectedObject isEqualToString:@"None"]){
            self.objectString.text = @"";
            self.flagValueString.text = @"";
            self.objectEqualsLabel.hidden = YES;
        } else {
            self.objectString.text = selectedObject;
            self.objectEqualsLabel.hidden = NO;
            int val = [objectSizes[selectedObject] intValue];
            [self.heightPicker selectRow:1+(val/12) inComponent:0 animated:YES];
            [self.heightPicker selectRow:1+(val%12) inComponent:1 animated:YES];
            feetComponent = [[pickerItems objectAtIndex:[self.heightPicker selectedRowInComponent:0]] floatValue];
            inchesComponent = [[inchesPicker objectAtIndex:[self.heightPicker selectedRowInComponent:1]] floatValue];
            flagHeight = feetComponent + (inchesComponent / 12);
            self.flagValueString.text = [NSString stringWithFormat:@"%2.2f", flagHeight];
            self.flipsideInfo.text = [NSString stringWithFormat:@"%2.2f", flagHeight];
        }
    }
}

@end
