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

@synthesize angle = _angle;
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
    NSLog(@"The angle is %f");
}

- (IBAction)calculateButton:(UIButton *)sender
{
    NSLog(@"The height is %f");

}


@end
