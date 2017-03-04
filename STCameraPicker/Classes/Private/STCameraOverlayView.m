//
//  STCameraOverlayView.m
//  ImagePicker
//
//  Created by Saeed Taheri on 2/25/17.
//  Copyright © 2017 Saeed Taheri. All rights reserved.
//

#import "STCameraOverlayView.h"
#import "STCameraOverlayCollectionCell.h"

static NSString* const kCellIdentifier = @"kCellIdentifier";
static NSString* const kCellNibName = @"STCameraOverlayCollectionCell";

@interface STCameraOverlayView() <UICollectionViewDelegate, UICollectionViewDataSource>

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (weak, nonatomic) IBOutlet UIView *collectionViewBackground;
@property (weak, nonatomic) IBOutlet UIButton *captureButton;
@property (weak, nonatomic) IBOutlet UIButton *flashButton;

@end

@implementation STCameraOverlayView

@synthesize capturedImages = _capturedImages;

- (void)setFlashMode:(UIImagePickerControllerCameraFlashMode)flashMode {
    _flashMode = flashMode;
    
    switch (flashMode) {
        case UIImagePickerControllerCameraFlashModeOn:
            [self.flashButton setImage:[UIImage imageNamed:@"flashOn"] forState:UIControlStateNormal];
            break;
        case UIImagePickerControllerCameraFlashModeOff:
            [self.flashButton setImage:[UIImage imageNamed:@"flashOff"] forState:UIControlStateNormal];
            break;
        case UIImagePickerControllerCameraFlashModeAuto:
            [self.flashButton setImage:[UIImage imageNamed:@"flashAuto"] forState:UIControlStateNormal];
            break;
        default:
            break;
    }
}

- (void)setCollectionView:(UICollectionView *)collectionView {
    _collectionView = collectionView;
    
    [_collectionView registerNib:[UINib nibWithNibName:kCellNibName bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:kCellIdentifier];
    
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
}

- (NSMutableArray<UIImage *> *)capturedImages {
    if (!_capturedImages) {
        _capturedImages = [NSMutableArray array];
    }
    return _capturedImages;
}

- (void)setCapturedImages:(NSMutableArray<UIImage *> *)capturedImages {
    _capturedImages = capturedImages;
    
    [self.collectionView reloadData];

    NSInteger section = [self.collectionView numberOfSections] - 1;
    NSInteger item = [self.collectionView numberOfItemsInSection:section] - 1;
    if (section < 0 || item < 0) {
        return;
    }
    NSIndexPath *lastIndexPath = [NSIndexPath indexPathForItem:item inSection:section];
    [self.collectionView scrollToItemAtIndexPath:lastIndexPath atScrollPosition: UICollectionViewScrollPositionCenteredHorizontally animated:YES];
}

- (IBAction)captureImage:(UIButton *)sender {
    [self.delegate shootImageInView:self];
}

- (IBAction)doneButtonTapped:(UIButton *)sender {
    [self.delegate didTapOnDoneInView:self];
}

- (IBAction)cancelButtonTapped:(UIButton *)sender {
    [self.delegate didTapOnCancelInView:self];
}

- (IBAction)flashButtonTapped:(UIButton *)sender {
    switch (self.flashMode) {
        case UIImagePickerControllerCameraFlashModeOn:
            self.flashMode = UIImagePickerControllerCameraFlashModeOff;
            break;
        case UIImagePickerControllerCameraFlashModeOff:
            self.flashMode = UIImagePickerControllerCameraFlashModeAuto;
            break;
        case UIImagePickerControllerCameraFlashModeAuto:
            self.flashMode = UIImagePickerControllerCameraFlashModeOn;
            break;
        default:
            break;
    }
    [self.delegate didTapOnFlashInView:self];
}

#pragma mark - UICollectionView Methods

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    [UIView animateWithDuration:0.2 animations:^{
        if (self.capturedImages.count > 0) {
            self.collectionViewBackground.alpha = 0.4;
        } else {
            self.collectionViewBackground.alpha = 0.0;
        }
    }];
    return self.capturedImages.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    STCameraOverlayCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kCellIdentifier forIndexPath:indexPath];
    
    cell.imageView.image = self.capturedImages[indexPath.row];
    
    __weak STCameraOverlayView *weakSelf = self;
    cell.closeButtonTapped = ^(UIImage *image) {
        NSMutableArray *images = weakSelf.capturedImages;
        [images removeObject:image];
        weakSelf.capturedImages = images;
    };
    
    return cell;
}

@end
