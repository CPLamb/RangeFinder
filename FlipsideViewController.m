//
//  FlipsideViewController.m
//  RangeFinder
//
//  Created by Chris Lamb on 6/3/12.
//  Copyright (c) 2012 CPL Consulting. All rights reserved.
//

#import "FlipsideViewController.h"

@implementation FlipsideViewController{
    NSArray *objectPickerItems;
    
    NSArray *heightItems;
    NSArray *unitsPicker;
    NSArray *yardInchesPicker;
    
    NSDictionary *objectSizes;
    NSDictionary *objectList;   // modified objectdict with object, height, units fields
    float flagHeight;
    
    NSString *objectName;
    NSString *heightUnits;
    NSString *distanceUnits;
    
    float unitsToFeet;      // used to convert distance units
    float feetToUnits;
}

#pragma mark - Lifecycle Methods

- (void)viewDidLoad
{
    [super viewDidLoad];
    
// Define pickerView items
    heightItems = [[NSArray alloc] initWithObjects:@"0", @"1", @"2", @"3", @"4", @"5", @"6", @"7", @"8", @"9", @"10", @"11", @"12", @"13", @"14", @"15", @"16", @"17", @"18", @"19", @"20", @"21", @"22", @"23", @"24", @"25", @"26", @"27", @"28", @"29", @"30", @"31", @"32", @"33", @"34", @"35", @"36", @"37", @"38", @"39",@"40", @"41", @"42", @"43", @"44", @"45", @"46", @"47", @"48", @"49", @"50", @"51", @"52", @"53", @"54", @"55", @"56", @"57", @"58", @"59", @"60", @"61", @"62", @"63", @"64", @"65", @"66", @"67", @"68", @"69", @"70", @"71", @"72", @"73", @"74", @"75", @"76", @"77", @"78", @"79", @"80", @"81", @"82", @"83", @"84", @"85", @"86", @"87", @"88", @"89",@"90", @"91", @"92", @"93", @"94", @"95", @"96", @"97", @"98", @"99", @"100", @"120", @"140", @"160", @"180", @"200", @"250", @"300", @"350", @"400", nil];
    unitsPicker = [[NSArray alloc] initWithObjects:@"inch", @"foot", @"yard", @"meter", @"kilo", @"mile", nil];
    objectPickerItems = [[NSArray alloc] initWithObjects:@"Light switch", @"Car", @"Person", @"Door", @"Golf flag", @"Utility pole", @"Sailboat", @"Lighthouse", nil];
        
// sets defaults for the Picker
    self.unitsSelector.selectedSegmentIndex = 1;
    heightUnits = @"foot";
    
    objectName = @"Golf flag";
    
    self.helpView.hidden = YES;
    
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
    NSLog(@"testing");
}

- (void)loadDataSingleton {
    NSString *name = objectName;
    NSString *height = [NSString stringWithFormat:@"%1.0f", self.flagHeight];
    NSString *passedHeightUnits = heightUnits;
    NSString *passedDistanceUnits = distanceUnits;
    
// access the data singleton & assigns it values
    self.theDistantObject = [DistantObject getSingeltonInstance];
    self.theDistantObject.objectName = name;
    self.theDistantObject.height = height;
    self.theDistantObject.heightUnits = passedHeightUnits;
    self.theDistantObject.distanceUnits = passedDistanceUnits;
    
    NSLog(@"passed data = %@, %@, %@, %@", name, height, passedHeightUnits, passedDistanceUnits);
}

- (void)loadInitialData
{
    DistantObject *item00 = [[DistantObject alloc] init];
    item00.objectName = @"START";
    item00.height = @"0000";
    item00.heightUnits = @"inches";
    [self.heightObjects addObject:item00];
    
    DistantObject *item01 = [[DistantObject alloc] init];
    item01.objectName = @"Golf Flag";
    item01.height = @"6";
    item01.heightUnits = @"feet";
    [self.heightObjects addObject:item01];
    
    DistantObject *item02 = [[DistantObject alloc] init];
    item02.objectName = @"Utility Pole";
    item02.height = @"20";
    item02.heightUnits = @"yards";
    [self.heightObjects addObject:item02];
    
    DistantObject *item03 = [[DistantObject alloc] init];
    item03.objectName = @"Person";
    item03.height = @"2";
    item03.heightUnits = @"meters";
    [self.heightObjects addObject:item03];
    
    DistantObject *item04 = [[DistantObject alloc] init];
    item04.objectName = @"Lighthouse";
    item04.height = @"2";
    item04.heightUnits = @"furlong";
    [self.heightObjects addObject:item04];
    
    DistantObject *item05 = [[DistantObject alloc] init];
    item05.objectName = @"END";
    item05.height = @"XXXX";
    item05.heightUnits = @"miles";
    [self.heightObjects addObject:item05];
    //   NSLog(@"Object count is %d", (int)[self.heightObjects count]);
}


- (IBAction)editButton:(id)sender
{
    NSString *messageString = [NSString stringWithFormat:@"Delete %@ ?", objectName];
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

- (IBAction)unitsSelected:(id)sender
{
    [self loadDataSingleton];
    switch(self.unitsSelector.selectedSegmentIndex) {
        case 0:
            distanceUnits =  @"inch";
            feetToUnits = 1/12;        // ToFeet/Units floats are for converting units
            unitsToFeet = 12;
            break;
        case 1:
            distanceUnits =  @"foot";
            feetToUnits = 1;
            unitsToFeet = 1;
            break;
        case 2:
            distanceUnits =  @"yard";
            feetToUnits = 3;
            unitsToFeet = 1/3;
            break;
        case 3:
            distanceUnits =  @"meter";
            feetToUnits = 3.3;
            unitsToFeet = 1/3.3;
            break;
        case 4:
            distanceUnits =  @"mile";
            feetToUnits = 5280;
            unitsToFeet = 1/5280;
            break;
    }
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
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    if (pickerView == self.heightPicker){
        if (component == 0)
           return [heightItems count];
        if (component == 1) {
            return [unitsPicker count];
        }
    }
    if (pickerView == self.objectPicker)
        return [self.heightObjects count];   //objectPickerItems
    return -1; //error condition
}

// returns the title of each row
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    if (pickerView == self.heightPicker){
        if (component == 0)
            return [heightItems objectAtIndex:row];
        if (component == 1) {
            return [unitsPicker objectAtIndex:row];
        }
    }
    if (pickerView == self.objectPicker)
        return [[self.heightObjects objectAtIndex:row] valueForKey:@"objectName"];    //objectPickerItems

    return nil;
}

// gets called when the user settles on a row
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    
// heightPicker
    if (pickerView == self.heightPicker) {
        if (component == 0) {
            NSString *componentValue = [heightItems objectAtIndex:row];
            self.flagHeight = [componentValue floatValue];
            [self loadDataSingleton];
        }
        if (component == 1) {
            NSString *unitsValue = [unitsPicker objectAtIndex:row];
            heightUnits = unitsValue;
            [self loadDataSingleton];
        }
        // FlipsideInfo is string sent to MainVC
        self.flipsideInfo.text = [NSString stringWithFormat:@"%2.2f", flagHeight];
        NSLog(@"Object %@ is %@", objectName, self.flipsideInfo.text);
        
    }
    
// Object Picker
    if (pickerView == self.objectPicker){
        NSString *selectedObject = [[self.heightObjects objectAtIndex:row] valueForKey:@"objectName"];       //objectPickerItems
        NSLog(@"selected object is %@", selectedObject);
        objectName = selectedObject;
        
        [self loadDataSingleton];
    }
}

@end
