//
//  STCameraOverlayCollectionCell.h
//  ImagePicker
//
//  Created by Saeed Taheri on 2/25/17.
//  Copyright © 2017 Saeed Taheri. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface STCameraOverlayCollectionCell : UICollectionViewCell

@property (copy, nonatomic) void (^closeButtonTapped)(UIImage *image);
@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@end
