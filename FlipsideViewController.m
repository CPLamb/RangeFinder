//
//  FlipsideViewController.m
//  RangeFinder
//
//  Created by Chris Lamb on 6/3/12.
//  Copyright (c) 2012 CPL Consulting. All rights reserved.
//

#import "FlipsideViewController.h"

//@interface FlipsideViewController ()
   //no private
//@end

@implementation FlipsideViewController

@synthesize delegate = _delegate;
@synthesize heightPicker = _heightPicker;
@synthesize pickerItems = _pickerItems;
@synthesize objectPickerItems = _objectPickerItems;

@synthesize flipsideInfo = _flipsideInfo;
@synthesize unitsSelector = _unitsSelector;
@synthesize helpSwitch = _helpSwitch;

@synthesize flagUnits = _flagUnits;
@synthesize flagValueString = _flagValueString;
@synthesize objectString = _objectString;
@synthesize heightMinorLabel = _heightMinorLabel;
@synthesize heightMajorLabel = _heightMajorLabel;
@synthesize objectPicker = _objectPicker;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    self.pickerItems = [[NSArray alloc] initWithObjects:@"-", @"0", @"1", @"2", @"3", @"4", @"5", @"6", @"7", @"8", @"9", @"10", @"11", @"12", @"15", @"20", @"30", @"40", @"50", nil];
    self.objectPickerItems = [[NSArray alloc] initWithObjects:@"None", @"Light switch", @"Car", @"Person", @"Door", @"Golf flag", @"Power pole", @"Sailboat", @"Lighthouse", nil];
    
// sets defaults for the Picker
    self.heightMajorLabel.text = @"Feet";
    self.heightMinorLabel.text = @"Inches";
    self.unitsSelector.selectedSegmentIndex = 1;
    self.flagUnits = @"Feet";
}

- (void)viewDidAppear:(BOOL)animated
{
}

- (void)viewDidUnload
{
    [self setHeightPicker:nil];
    [self setFlipsideInfo:nil];
    [self setUnitsSelector:nil];
    [self setHelpSwitch:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - Actions

- (IBAction)done:(id)sender
{
    [self.delegate flipsideViewControllerDidFinish:self];
}

- (IBAction)unitsSelected:(id)sender
{
    switch(self.unitsSelector.selectedSegmentIndex) {
        case 0:
            self.flagUnits =  @"Yards";
            self.heightMajorLabel.text = @"Yards";
            self.heightMinorLabel.text = @"Inches";
            break;
        case 1:
            self.flagUnits =  @"Feet";
            self.heightMajorLabel.text = @"Feet";
            self.heightMinorLabel.text = @"Inches";
            break;
        case 2:
            self.flagUnits =  @"Meters";
            self.heightMajorLabel.text = @"Meters";
            self.heightMinorLabel.text = @"CMs";
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

// returns the number of rows
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
	//return [self.pickerItems count];
    
    if (pickerView == self.heightPicker)
        return [self.pickerItems count];
    
    if (pickerView == self.objectPicker)
        return [self.objectPickerItems count];
    
    return -1; //error condition
}

#pragma mark ---- UIPickerViewDelegate delegate methods ----

// returns the title of each row
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
   // return [self.pickerItems objectAtIndex:row];
    
    if (pickerView == self.heightPicker)
        return [self.pickerItems objectAtIndex:row];
    
    if (pickerView == self.objectPicker)
        return [self.objectPickerItems objectAtIndex:row];
    
    return nil; //error condition
}


// gets called when the user settles on a row
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
/*
// Picks out the component & it's value
    NSString *componentValue = [self.pickerItems objectAtIndex:row];
    
// assigns row values to feet or inches & calculates the fractional feet
    if (component == 0) {
        feetComponent = [componentValue floatValue];
    }
    if (component == 1) {
        inchesComponent = [componentValue floatValue];
    }
// calculates fractional feet value    
    flagHeight = feetComponent + (inchesComponent / 12);
    self.flipsideInfo.text = [NSString stringWithFormat:@"%2.2f", flagHeight];
    NSLog(@"Flipside flagheight is %2.2f", flagHeight);
    
// displays value & units
    self.flagValueString.text = [[self.flipsideInfo.text stringByAppendingString:@"  " ] stringByAppendingString:self.flagUnits];
*/
    
    if (pickerView == self.heightPicker) {
        NSString *componentValue = [self.pickerItems objectAtIndex:row];
        
        // assigns row values to feet or inches & calculates feet in decimal
        if (component == 0)
            feetComponent = [componentValue floatValue];
        
        if (component == 1)
            inchesComponent = [componentValue floatValue];
        
        flagHeight = feetComponent + (inchesComponent/12);
        self.flipsideInfo.text = [NSString stringWithFormat:@"%2.2f", flagHeight];
        
        self.flagValueString.text = [[self.flipsideInfo.text stringByAppendingString:@" "] stringByAppendingString:self.flagUnits];
    }
    
    if (pickerView == self.objectPicker){
        NSString *selectedObject = [self.objectPickerItems objectAtIndex:row];
        if ([selectedObject isEqualToString:@"None"])
            self.objectString.text = @"";
        else
            self.objectString.text = selectedObject;
      //  self.objectString.text = [self.objectPickerItems objectAtIndex:row];
    }

}



@end
