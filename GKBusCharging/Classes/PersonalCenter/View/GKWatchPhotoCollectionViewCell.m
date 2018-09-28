//
//  GKWatchPhotoCollectionViewCell.m
//  Record
//
//  Created by L on 2018/6/27.
//  Copyright © 2018年 L. All rights reserved.
//

#import "GKWatchPhotoCollectionViewCell.h"

@implementation GKWatchPhotoCollectionViewCell
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        __weak typeof(self) weakself = self;
        CGFloat xMargin = FixWidthNumber(6);
        CGFloat itemWidth = (SCREEN_WIDTH-FixWidthNumber(15)*2)/3.0 - xMargin*2;
        
        UIImageView * userImageView = [UIImageView new];
        [self addSubview:userImageView];
        [userImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.right.bottom.left.equalTo(weakself);
        }];
        userImageView.image = [UIImage imageNamed:@"img_1"];
        userImageView.contentMode = UIViewContentModeScaleAspectFill;
        self.userImageView = userImageView;
        userImageView.clipsToBounds = YES;
        
        CGFloat timeViewHeight = 20;
        UIView * timeView = [UIView new];
        [self addSubview:timeView];
        [timeView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.mas_equalTo(weakself);
            make.left.right.mas_equalTo(weakself);
            make.height.mas_equalTo(timeViewHeight);
        }];
        //颜色渐变
        CAGradientLayer *layer = [CAGradientLayer layer];
        layer.frame = CGRectMake(0, 0, self.frame.size.width, timeViewHeight);
        layer.startPoint = CGPointMake(0, 0);
        layer.endPoint = CGPointMake(1, 1);
        layer.colors = @[(id)[UIColor colorWithRed:0 green:0 blue:0 alpha:0].CGColor,(id)[UIColor colorWithRed:84/255. green:84/255. blue:84/255. alpha:.8].CGColor];
        [timeView.layer addSublayer:layer];
        self.timeView = timeView;
        
        UILabel * timeLabel = [UILabel new];
        [timeView addSubview:timeLabel];
        [timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.bottom.mas_equalTo(timeView);
            make.right.mas_equalTo(timeView).with.offset(-9);
        }];
        timeLabel.textColor = [UIColor whiteColor];
        timeLabel.font = [UIFont systemFontOfSize:11];
        timeLabel.text = @"01:22";
        timeLabel.textAlignment = NSTextAlignmentRight;
        self.timeLabel = timeLabel;
        //增加选择图标
        UIImageView * selectImageBackgroundView = [UIImageView new];
        [self addSubview:selectImageBackgroundView];
        [selectImageBackgroundView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(weakself);
            make.right.mas_equalTo(weakself);
            make.height.mas_equalTo(FixWidthNumber(25));
        }];
        selectImageBackgroundView.image = [UIImage imageNamed:@"icon_album_choice_unselected"];
        selectImageBackgroundView.contentMode = UIViewContentModeScaleAspectFill;
        selectImageBackgroundView.clipsToBounds = YES;
        selectImageBackgroundView.hidden = true;
        self.selectImageBackgroundView = selectImageBackgroundView;
        
        UIImageView * selectImageView = [UIImageView new];
        [self addSubview:selectImageView];
        [selectImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(weakself);
            make.right.mas_equalTo(weakself);
            make.height.mas_equalTo(FixWidthNumber(25));
        }];
        selectImageView.image = [UIImage imageNamed:@"icon_album_choice"];
        selectImageView.contentMode = UIViewContentModeScaleAspectFill;
        selectImageView.clipsToBounds = YES;
        selectImageView.hidden = true;
        self.selectImageView = selectImageView;
    }
    return self;
}


-(void)cellInfoWithDictionary:(FileModel *)model withEditingMode:(BOOL)isEditing{
//    self.selectImageView.hidden = YES;
//    if (isEditing) {
//
//        if ([model.select intValue] == 1) {
//            self.selectImageView.hidden = NO;
//        }
//    }
    return;
}


@end
