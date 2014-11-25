//
//  MainViewController.h
//  RangeFinder
//
//  Created by Chris Lamb on 6/3/12.
//  Copyright (c) 2012 CPL Consulting. All rights reserved.
//
/*  This view is used for determining the to an object an object using
    the device's camera & zoom effects.  The calculation is based upon 2 zoom
    factors (digital zoom & CGRect zoom) X the height of a known object (person, 
    stop sign, etc).  
 */
//

#import "FlipsideViewController.h"

@interface MainViewController : UIViewController <FlipsideViewControllerDelegate, UINavigationControllerDelegate, UIImagePickerControllerDelegate>

@property (strong, nonatomic) IBOutlet UIImageView *cameraView;
@property (strong, nonatomic) IBOutlet UILabel *distanceLabel;
@property (strong, nonatomic) IBOutlet UILabel *myAssistantLabel;
@property (strong, nonatomic) UIImageView *reticleView;
@property (strong, nonatomic) UISlider *reticleZoomSlider;
<<<<<<< HEAD
@property (strong, nonatomic) IBOutlet UIButton *cameraButtonButton;

- (IBAction)camera:(UIButton *)sender;
=======
//>>>>>>> 262514d0c77a08c21caa6d57f6ae6ff8290bb89e:RangeFinder/MainViewController.h
@property (strong, nonatomic) IBOutlet UIView *helpView;

//@property (strong, nonatomic) UIImagePickerController *imagePickerController;
@property (strong, nonatomic) IBOutlet UIButton *cameraButtonButton;

- (IBAction)camera:(UIButton *)sender;
//<<<<<<< HEAD:MainViewController.h
//- (IBAction)cameraButton:(UIBarButtonItem *)sender;
//=======
- (IBAction)hideHelpButton:(id)sender;
- (IBAction)showHelpButton:(id)sender;

//>>>>>>> 262514d0c77a08c21caa6d57f6ae6ff8290bb89e:RangeFinder/MainViewController.h
>>>>>>> ae17683cdc8cfe1853284fc7f54b6fef988504d7
@end
