//
//  STCameraOverlayCollectionCell.m
//  ImagePicker
//
//  Created by Saeed Taheri on 2/25/17.
//  Copyright © 2017 Saeed Taheri. All rights reserved.
//

#import "STCameraOverlayCollectionCell.h"

@implementation STCameraOverlayCollectionCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.imageView.layer.cornerRadius = 4.0;
    self.imageView.layer.masksToBounds = YES;
}

- (IBAction)closeButtonTapped:(UIButton *)sender {
    self.closeButtonTapped(self.imageView.image);
}

@end
