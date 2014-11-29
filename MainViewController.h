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

@property (strong, nonatomic) IBOutlet UIButton *cameraButtonButton;
@property (strong, nonatomic) IBOutlet UIView *helpView;

- (IBAction)camera:(UIButton *)sender;

//@property (strong, nonatomic) UIImagePickerController *imagePickerController;
//@property (strong, nonatomic) IBOutlet UIButton *cameraButtonButton;

//- (IBAction)camera:(UIButton *)sender;
//<<<<<<< HEAD:MainViewController.h
//- (IBAction)cameraButton:(UIBarButtonItem *)sender;
//=======
- (IBAction)hideHelpButton:(id)sender;
- (IBAction)showHelpButton:(id)sender;

@end
