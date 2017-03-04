//
//  STCameraOverlayView.h
//  ImagePicker
//
//  Created by Saeed Taheri on 2/25/17.
//  Copyright © 2017 Saeed Taheri. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "STCameraViewController.h"

@class STCameraOverlayView;

@protocol STCameraOverlayViewDelegate <NSObject>

- (void)shootImageInView:(STCameraOverlayView * _Nonnull)overlayView;
- (void)didTapOnDoneInView:(STCameraOverlayView * _Nonnull)overlayView;
- (void)didTapOnCancelInView:(STCameraOverlayView * _Nonnull)overlayView;
- (void)didTapOnFlashInView:(STCameraOverlayView * _Nonnull)overlayView;

@end

@interface STCameraOverlayView : UIView

@property (weak, nonatomic, nullable) id<STCameraOverlayViewDelegate> delegate;
@property (strong, nonatomic, nullable) NSMutableArray<UIImage *> *capturedImages;
@property (assign, nonatomic) UIImagePickerControllerCameraFlashMode flashMode;
@property (weak, nonatomic, nullable) IBOutlet UIButton *doneButton;
@property (weak, nonatomic, nullable) IBOutlet UIButton *cancelButton;

@end
