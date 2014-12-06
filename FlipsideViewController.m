//
//  FlipsideViewController.m
//  RangeFinder
//
//  Created by Chris Lamb on 6/3/12.
//  Copyright (c) 2012 CPL Consulting. All rights reserved.
//

#import "FlipsideViewController.h"
#import "DistantObject.h"

@implementation FlipsideViewController{
    NSArray *objectPickerItems;
    
    NSArray *heightItems;
    NSArray *unitsPicker;
    NSArray *yardInchesPicker;
    NSMutableArray *minorUnitsPicker;  // second height component
    
    NSDictionary *objectSizes;
    NSDictionary *objectList;   // modified objectdict with object, height, units fields
    float flagHeight;
    float feetComponent;
    float inchesComponent;
}
@synthesize objectString = _objectString;

#pragma mark - Lifecycle Methods

- (void)viewDidLoad
{
    [super viewDidLoad];
    
// Define pickerView items
    heightItems = [[NSArray alloc] initWithObjects:@"0", @"1", @"2", @"3", @"4", @"5", @"6", @"7", @"8", @"9", @"10", @"11", @"12", @"13", @"14", @"15", @"16", @"17", @"18", @"19", @"20", @"21", @"22", @"23", @"24", @"25", @"26", @"27", @"28", @"29", @"30", @"31", @"32", @"33", @"34", @"35", @"36", @"37", @"38", @"39",@"40", @"41", @"42", @"43", @"44", @"45", @"46", @"47", @"48", @"49", @"50", @"51", @"52", @"53", @"54", @"55", @"56", @"57", @"58", @"59", @"60", @"61", @"62", @"63", @"64", @"65", @"66", @"67", @"68", @"69", @"70", @"71", @"72", @"73", @"74", @"75", @"76", @"77", @"78", @"79", @"80", @"81", @"82", @"83", @"84", @"85", @"86", @"87", @"88", @"89",@"90", @"91", @"92", @"93", @"94", @"95", @"96", @"97", @"98", @"99", @"100", @"120", @"140", @"160", @"180", @"200", @"250", @"300", @"350", @"400", nil];
    unitsPicker = [[NSArray alloc] initWithObjects:@"inch", @"foot", @"yard", @"meter", @"kilo", @"mile", nil];
    objectPickerItems = [[NSArray alloc] initWithObjects:@"Light switch", @"Car", @"Person", @"Door", @"Golf flag", @"Utility pole", @"Sailboat", @"Lighthouse", nil];
        
// sets defaults for the Picker
    self.heightMajorLabel.text = @"feet";
    self.heightMinorLabel.text = @"inches";
    self.unitsSelector.selectedSegmentIndex = 1;
    self.flagUnits = @"feet";
    
    self.objectString.text = @"Golf flag";
    self.flagValueString.text = @"";
    self.objectEqualsLabel.hidden = YES;
    
    self.helpView.hidden = NO;
    
// loads objectSizes dictionary
    NSString *objectSizesPlist = [[NSBundle mainBundle] pathForResource:@"ObjectSizes" ofType:@"plist"];
    objectSizes = [[NSDictionary alloc] initWithContentsOfFile:objectSizesPlist];
    // NSLog(@"The dictionary %@", objectSizes);
    
// loads new data objects
    self.heightObjects = [[NSMutableArray alloc] init];
    [self loadInitialData];
}

-(BOOL)shouldAutorotate{
    return NO;
}

#pragma mark - Custom Methods

- (IBAction)testButton:(UIButton *)sender
{
    NSString *name = self.objectString.text;
    NSString *height = [NSString stringWithFormat:@"%f", self.flagHeight];
    NSString *units = self.flagUnits;
    
    DistantObject *theDistantObject = [[DistantObject alloc] initWithName:name height:height unit:units];
    //   NSLog(@"The object is %@ name is %@", theDistantObject, theDistantObject.objectName);
    
    // Now let's get back to the RangeFinder
    NSLog(@"2 - calls delegate method in MainVC");
    [self.delegate flipsideViewControllerDidFinish:self];
}

- (void)loadInitialData
{
    DistantObject *item00 = [[DistantObject alloc] init];
    item00.objectName = @"START";
    item00.height = @"0000";
    item00.units = @"inches";
    [self.heightObjects addObject:item00];
    
    DistantObject *item01 = [[DistantObject alloc] init];
    item01.objectName = @"Golf Flag";
    item01.height = @"6";
    item01.units = @"feet";
    [self.heightObjects addObject:item01];
    
    DistantObject *item02 = [[DistantObject alloc] init];
    item02.objectName = @"Utility Pole";
    item02.height = @"20";
    item02.units = @"yards";
    [self.heightObjects addObject:item02];
    
    DistantObject *item03 = [[DistantObject alloc] init];
    item03.objectName = @"Person";
    item03.height = @"2";
    item03.units = @"meters";
    [self.heightObjects addObject:item03];
    
    DistantObject *item04 = [[DistantObject alloc] init];
    item04.objectName = @"Lighthouse";
    item04.height = @"2";
    item04.units = @"furlong";
    [self.heightObjects addObject:item04];
    
    DistantObject *item05 = [[DistantObject alloc] init];
    item05.objectName = @"END";
    item05.height = @"XXXX";
    item05.units = @"miles";
    [self.heightObjects addObject:item05];
    //   NSLog(@"Object count is %d", (int)[self.heightObjects count]);
}


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
    // NSLog(@"slides up a transparency that describes the buttons below");
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
    NSLog(@"Closes the setup screen and goes back to the rangeFinder");
    [self.delegate flipsideViewControllerDidFinish:self];
}


- (IBAction)unitsSelected:(id)sender
{
    [minorUnitsPicker removeAllObjects];         //sets trailing number to different ranges
    switch(self.unitsSelector.selectedSegmentIndex) {
        case 0:
            self.flagUnits =  @"yards";
            self.heightMajorLabel.text = @"yards";
            self.heightMinorLabel.text = @"inches";
            [minorUnitsPicker addObjectsFromArray:yardInchesPicker];   //yardInchesPicker];
            break;
        case 1:
            self.flagUnits =  @"feet";
            self.heightMajorLabel.text = @"feet";
            self.heightMinorLabel.text = @"inches";
            [minorUnitsPicker addObjectsFromArray:unitsPicker];   //inchesPicker];
            break;
        case 2:
            self.flagUnits =  @"meters";
            self.heightMajorLabel.text = @"meters";
            self.heightMinorLabel.text = @"cms";
            [minorUnitsPicker addObjectsFromArray:heightItems];
            break;
        case 3:
            self.flagUnits =  @"furlong";            // a furlong is 220 yards or 1/8 mile
            self.heightMajorLabel.text = @"furlong";
            self.heightMinorLabel.text = @"yards";
            [minorUnitsPicker addObjectsFromArray:heightItems];
            break;
    }
    // NSLog(@"Array is %@", minorUnitsPicker);
    //[self pickerView:self.heightPicker numberOfRowsInComponent:[minorUnitsPicker count]];
    NSLog(@"Units selected are %@ and %lu count", self.flagUnits, (unsigned long)[minorUnitsPicker count]);
    
// Redraws the pickerView content
    [self.heightPicker reloadAllComponents];
}

#pragma mark ---- UIPickerViewDataSource delegate methods ----

// returns the number of columns to display.
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {

    if (pickerView == self.heightPicker)
        return 2;
    
    if (pickerView == self.objectPicker)
        return 1;
    
    return -1;  //we'll use this as an error condition
}

#pragma mark ---- UIPickerViewDelegate delegate methods ----

// returns the number of rows
#pragma mark - NOTE:This method is only run once therefore we can't change the miorUnits values
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    if (pickerView == self.heightPicker){
        if (component == 0)
           return [heightItems count];
        if (component == 1) {
            NSLog(@"Array is %d", [minorUnitsPicker count]);
            return [unitsPicker count];
        }
    }
    if (pickerView == self.objectPicker)
        return [objectPickerItems count];   //objectPickerItems
    return -1; //error condition
}

#pragma mark - NOTE: refactor to convert to different units
// returns the title of each row
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    if (pickerView == self.heightPicker){
        if (component == 0)
            return [heightItems objectAtIndex:row];
        if (component == 1) {
//            NSLog(@"Array is %d", [minorUnitsPicker count]);
            return [unitsPicker objectAtIndex:row];
        }
    }
    if (pickerView == self.objectPicker)
        return [objectPickerItems objectAtIndex:row];      //objectPickerItems

    return nil;
}

// gets called when the user settles on a row
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    
// heightPicker
    if (pickerView == self.heightPicker) {
        NSString *componentValue = [heightItems objectAtIndex:row];
/*
        // assigns row values to feet or inches & calculates the fractional feet
        if (component == 0) {
            feetComponent = [componentValue floatValue];
        }
        if (component == 1) {
            inchesComponent = [componentValue floatValue];
        }
        // calculates fractional feet value
        flagHeight = feetComponent + (inchesComponent / 12);
*/        
// FlipsideInfo is string sent to MainVC
        self.flipsideInfo.text = [NSString stringWithFormat:@"%2.2f", flagHeight];
        NSLog(@"Object %@ is %@", self.objectString.text, self.flipsideInfo.text);
        
        // displays value & units
        self.flagValueString.text = [[self.flipsideInfo.text stringByAppendingString:@"  " ] stringByAppendingString:self.flagUnits];
    }
   
// Object Picker
    if (pickerView == self.objectPicker){
       // NSString *selectedObject = [self.objectPickerItems objectAtIndex:row];
        NSString *selectedObject = [objectPickerItems objectAtIndex:row];       //objectPickerItems
        if ([selectedObject isEqualToString:@"None"]){
            self.objectString.text = @"";
            self.flagValueString.text = @"";
            self.objectEqualsLabel.hidden = YES;
        } else {                                    // Calculates fractional height
            self.objectString.text = selectedObject;
            self.objectEqualsLabel.hidden = NO;
            int val = [objectSizes[selectedObject] intValue];
            [self.heightPicker selectRow:1+(val/100) inComponent:0 animated:YES];
            [self.heightPicker selectRow:1+(val%100) inComponent:1 animated:YES];
            feetComponent = [[heightItems objectAtIndex:[self.heightPicker selectedRowInComponent:0]] floatValue];
            inchesComponent = [[minorUnitsPicker objectAtIndex:[self.heightPicker selectedRowInComponent:1]] floatValue];
            flagHeight = feetComponent + (inchesComponent / 100);
            self.flagValueString.text = [NSString stringWithFormat:@"%2.2f", flagHeight];
            self.flipsideInfo.text = [NSString stringWithFormat:@"%2.2f", flagHeight];
            NSLog(@"Object %@ is %2.2f", self.objectString.text, flagHeight);
        }
    }
}

@end
