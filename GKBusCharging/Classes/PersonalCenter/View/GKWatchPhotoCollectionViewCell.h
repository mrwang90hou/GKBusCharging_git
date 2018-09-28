//
//  GKWatchPhotoCollectionViewCell.h
//  Record
//
//  Created by L on 2018/6/27.
//  Copyright © 2018年 L. All rights reserved.
//

#import <UIKit/UIKit.h>
@class FileModel; 
@interface GKWatchPhotoCollectionViewCell : UICollectionViewCell
@property (nonatomic,strong) UIImageView     * userImageView;
@property (nonatomic,strong) UILabel        * timeLabel;
@property (nonatomic,strong) UIView         * timeView;
//增加选择图标
@property (nonatomic,strong) UIImageView     * selectImageView;
@property (nonatomic,strong) UIImageView     * selectImageBackgroundView;


-(void)cellInfoWithDictionary:(FileModel *)model withEditingMode:(BOOL)isEditing;
@end
