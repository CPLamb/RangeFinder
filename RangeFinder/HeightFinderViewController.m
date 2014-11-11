//
//  HeightFinderViewController.m
//  RangeFinder
//
//  Created by Chris Lamb on 11/7/14.
//  Copyright (c) 2014 CPL Consulting. All rights reserved.
//

#import "HeightFinderViewController.h"

@interface HeightFinderViewController ()

@end

@implementation HeightFinderViewController

#define DEGREE2RADIAN 57.3

@synthesize angleOne = _angleOne;
@synthesize angleTwo = _angleTwo;
@synthesize baseLength = _baseLength;
@synthesize height = _height;


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)setAngleButton:(UIButton *)sender
{
    NSLog(@"The angle is %2.1f");
}

- (IBAction)calculateButton:(UIButton *)sender
{
// converts textfields to floats in radians to calculate the height
    double bStep = [self.baseLength.text doubleValue];
    double aOne = [self.angleOne.text doubleValue]/DEGREE2RADIAN;
    double aTwo = [self.angleTwo.text doubleValue]/DEGREE2RADIAN;
    
// calculates the height based on 2 angles and a base length
    double h = bStep * tan(aOne) / ((tan(aOne)/tan(aTwo)) - 1);
    
// prints value
    self.height.text = [NSString stringWithFormat:@"%3.3f",h];
    NSLog(@"The height is %@", self.height.text);

}

- (IBAction)doneButton:(UIButton *)sender
{
    NSLog(@"Hides the keyboard");
    [self.angleOne resignFirstResponder];
    [self.angleTwo resignFirstResponder];
    [self.baseLength resignFirstResponder];
}


@end
