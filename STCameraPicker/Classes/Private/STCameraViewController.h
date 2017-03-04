//
//  STCameraViewController.h
//  ImagePicker
//
//  Created by Saeed Taheri on 2/25/17.
//  Copyright © 2017 Saeed Taheri. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol STCameraViewDelegate <NSObject>

- (void)cameraViewDidFinishCapturingImages:(NSArray<UIImage *>*)capturedImages;
- (void)cameraViewDidTapOnCancelButton;

@end

@interface STCameraViewController : UIViewController

@property (weak, nonatomic) id<STCameraViewDelegate> delegate;
@property (strong, nonatomic) UIFont *navigationBarFont;
@property (strong, nonatomic) NSString *doneButtonText;
@property (strong, nonatomic) NSString *cancelButtonText;

@end

