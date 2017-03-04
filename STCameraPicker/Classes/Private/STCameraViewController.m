//
//  STCameraViewController.m
//  ImagePicker
//
//  Created by Saeed Taheri on 2/25/17.
//  Copyright © 2017 Saeed Taheri. All rights reserved.
//

#import "STCameraViewController.h"
#import "STCameraOverlayView.h"
#import <AVFoundation/AVFoundation.h>

@interface STCameraViewController () <UINavigationControllerDelegate, UIImagePickerControllerDelegate, STCameraOverlayViewDelegate>

@property (strong, nonatomic) STCameraOverlayView *overlayView;
@property (strong, nonatomic) UIImagePickerController *imagePickerController;
@property (strong, nonatomic) NSArray<UIImage *> *images;

@end

@implementation STCameraViewController

#pragma mark - Properties

- (UIFont *)navigationBarFont {
    if (!_navigationBarFont) {
        _navigationBarFont = [[UIBarButtonItem appearance] titleTextAttributesForState:UIControlStateNormal][NSFontAttributeName];
    }
    return _navigationBarFont;
}

- (NSString *)doneButtonText {
    if (!_doneButtonText) {
        _doneButtonText = @"Done";
    }
    return _doneButtonText;
}

- (NSString *)cancelButtonText {
    if (!_cancelButtonText) {
        _cancelButtonText = @"Cancel";
    }
    return _cancelButtonText;
}

#pragma mark - ViewController Lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor blackColor];
    
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [self requestCameraPermission];
        });
    }
}

#pragma mark - Methods

- (void)requestCameraPermission {
    AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
    if (authStatus == AVAuthorizationStatusDenied)
    {
        // Denies access to camera, alert the user.
        // The user has previously denied access. Remind the user that we need camera access to be useful.
        UIAlertController *alertController =
        [UIAlertController alertControllerWithTitle:@"Unable to access the Camera"
                                            message:@"To enable access, go to Settings > Privacy > Camera and turn on Camera access for this app."
                                     preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *ok = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
        [alertController addAction:ok];
        
        [self presentViewController:alertController animated:YES completion:nil];
    }
    else if (authStatus == AVAuthorizationStatusNotDetermined)
        // The user has not yet been presented with the option to grant access to the camera hardware.
        // Ask for it.
        [AVCaptureDevice requestAccessForMediaType:AVMediaTypeVideo completionHandler:^( BOOL granted ) {
            // If access was denied, we do not set the setup error message since access was just denied.
            if (granted)
            {
                // Allowed access to camera, go ahead and present the UIImagePickerController.
                [self showImagePickerFromCamera];
            }
        }];
    else
    {
        // Allowed access to camera, go ahead and present the UIImagePickerController.
        [self showImagePickerFromCamera];
    }
}

- (void)showImagePickerFromCamera {
    UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
    imagePickerController.modalPresentationStyle = UIModalPresentationCurrentContext;
    imagePickerController.sourceType = UIImagePickerControllerSourceTypeCamera;
    imagePickerController.modalPresentationStyle = UIModalPresentationFullScreen;
    imagePickerController.delegate = self;

    // The user wants to use the camera interface. Set up our custom overlay view for the camera.
    imagePickerController.showsCameraControls = NO;
    
    // Adjust camera preview to be a little bit more centered instead of adjusted to the top
    CGSize screenSize = [[UIScreen mainScreen] bounds].size;
    
    float cameraAspectRatio = 4.0 / 3.0;
    float imageHeight = screenSize.width * cameraAspectRatio;
    float verticalAdjustment;
    if (screenSize.height - imageHeight <= 44.0f) {
        verticalAdjustment = 0;
    } else {
        verticalAdjustment = 54.0;
    }
    CGAffineTransform transform = imagePickerController.cameraViewTransform;
    transform.ty += verticalAdjustment;
    imagePickerController.cameraViewTransform = transform;
    
    /*
     Load the overlay view from the OverlayView nib file. Self is the File's Owner for the nib file, so the overlayView outlet is set to the main view in the nib. Pass that view to the image picker controller to use as its overlay view, and set self's reference to the view to nil.
     */
    self.overlayView = [[[NSBundle mainBundle] loadNibNamed:@"STCameraOverlayView" owner:self options:nil] firstObject];
    self.overlayView.frame = imagePickerController.cameraOverlayView.frame;
    self.overlayView.delegate = self;
    self.overlayView.flashMode = imagePickerController.cameraFlashMode;
    [self.overlayView.doneButton setTitle:self.doneButtonText forState:UIControlStateNormal];
    [self.overlayView.cancelButton setTitle:self.cancelButtonText forState:UIControlStateNormal];
    self.overlayView.doneButton.titleLabel.font = self.navigationBarFont;
    self.overlayView.cancelButton.titleLabel.font = self.navigationBarFont;

    imagePickerController.cameraOverlayView = self.overlayView;
    
    self.imagePickerController = imagePickerController;
    
    self.images = [NSMutableArray array];
    [self presentViewController:self.imagePickerController animated:NO completion:NULL];
}

#pragma mark - STCameraOverlayViewDelegate 

- (void)shootImageInView:(STCameraOverlayView *)overlayView {
    [self.imagePickerController takePicture];
}

- (void)didTapOnDoneInView:(STCameraOverlayView *)overlayView {
    self.images = overlayView.capturedImages;
    [self.delegate cameraViewDidFinishCapturingImages:self.images];
}

- (void)didTapOnCancelInView:(STCameraOverlayView *)overlayView {
    self.images = [[NSArray alloc] init];
    [self.delegate cameraViewDidTapOnCancelButton];
}

- (void)didTapOnFlashInView:(STCameraOverlayView *)overlayView {
    self.imagePickerController.cameraFlashMode = overlayView.flashMode;
}

#pragma mark - UIImagePickerControllerDelegate

// This method is called when an image has been chosen from the library or taken from the camera.
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    UIImage *image = [info valueForKey:UIImagePickerControllerOriginalImage];
    NSMutableArray *temp = self.overlayView.capturedImages;
    [temp addObject:image];
    self.overlayView.capturedImages = temp;
}

@end
