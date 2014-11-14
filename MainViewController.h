//
//  MainViewController.h
//  RangeFinder
//
//  Created by Chris Lamb on 6/3/12.
//  Copyright (c) 2012 CPL Consulting. All rights reserved.
//

#import "FlipsideViewController.h"

@interface MainViewController : UIViewController <FlipsideViewControllerDelegate, UINavigationControllerDelegate, UIImagePickerControllerDelegate>
{
   // CGFloat firstZoomFactor;
   // float secondZoomFactor;
   // float totalZoomFactor;
   // float flagHeight;
}
//@property (strong, nonatomic) NSString *distanceUnits;

@property (strong, nonatomic) IBOutlet UIImageView *cameraView;
@property (strong, nonatomic) IBOutlet UILabel *distanceLabel;
@property (strong, nonatomic) IBOutlet UILabel *myAssistantLabel;
//@property (strong, nonatomic) NSNumber *distance;

//<<<<<<< HEAD:MainViewController.h
//@property (strong, nonatomic) UIImageView *reticleView;
//=======
@property (strong, nonatomic) UIImageView *reticleView;
@property (strong, nonatomic) UISlider *reticleZoomSlider;
//>>>>>>> 262514d0c77a08c21caa6d57f6ae6ff8290bb89e:RangeFinder/MainViewController.h

//@property (strong, nonatomic) UIImagePickerController *imagePickerController;
@property (strong, nonatomic) IBOutlet UIButton *cameraButtonButton;

- (IBAction)camera:(UIButton *)sender;
//<<<<<<< HEAD:MainViewController.h
//- (IBAction)cameraButton:(UIBarButtonItem *)sender;
//=======

//>>>>>>> 262514d0c77a08c21caa6d57f6ae6ff8290bb89e:RangeFinder/MainViewController.h
@end
