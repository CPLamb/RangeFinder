//
//  MainViewController.h
//  RangeFinder
//
//  Created by Chris Lamb on 6/3/12.
//  Copyright (c) 2012 CPL Consulting. All rights reserved.
//

#import "FlipsideViewController.h"

@interface MainViewController : UIViewController <FlipsideViewControllerDelegate, UINavigationControllerDelegate, UIImagePickerControllerDelegate>

@property (strong, nonatomic) IBOutlet UIImageView *cameraView;
@property (strong, nonatomic) IBOutlet UILabel *distanceLabel;
@property (strong, nonatomic) IBOutlet UILabel *myAssistantLabel;
@property (strong, nonatomic) UIImageView *reticleView;
@property (strong, nonatomic) UISlider *reticleZoomSlider;
@property (strong, nonatomic) IBOutlet UIButton *cameraButtonButton;

- (IBAction)camera:(UIButton *)sender;
@end
