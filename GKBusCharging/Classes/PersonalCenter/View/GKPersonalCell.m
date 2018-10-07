//
//  GKPersonalCell.m
//  GKBusCharging
//
//  Created by L on 2018/9/28.
//  Copyright © 2018年 goockr. All rights reserved.
//

#import "GKPersonalCell.h"

// Controllers

// Models

// Views
// Vendors
//#import <UIImageView+WebCache.h>
//// Categories
//#import "UIView+DCRolling.h"
//#import "UIColor+DCColorChange.h"
// Others

@interface GKPersonalCell ()

@end

@implementation GKPersonalCell

#pragma mark - Intial
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        
        [self setUpUI];
        
    }
    return self;
}

- (void)setUpUI
{
//    self.backgroundColor = Main_Color;
    
    
    self.gridImageView = [[UIImageView alloc] init];
    self.gridImageView.contentMode = UIViewContentModeScaleAspectFill;
//    [self.gridImageView setImage:[UIImage imageNamed:@"icon_personal_center_app_down"]];
    [self addSubview:self.gridImageView];
    
    self.titleLabel = [[UILabel alloc] init];
    self.titleLabel.font = PFR15Font;
    self.titleLabel.numberOfLines = 0;//表示label可以多行显示
//    self.titleLabel.lineBreakMode = NSLineBreakByCharWrapping;//换行模式，与上面的计算保持一致。
    // 换行的模式我们选择文本自适应
    self.titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
    
    self.titleLabel.preferredMaxLayoutWidth = ScreenW/4;
//    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:self.titleLabel];
    
    self.infoLabel = [[UILabel alloc] init];
    self.infoLabel.font = [UIFont systemFontOfSize:10];
    self.infoLabel.backgroundColor = [UIColor whiteColor];
//    self.infoLabel.textAlignment = NSTextAlignmentCenter;
    self.infoLabel.textColor = RGB(31, 206, 155);
    self.infoLabel.text = @"";
    [self addSubview:self.infoLabel];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    [self.gridImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        [make.right.mas_equalTo(self.mas_right)setOffset:-DCMargin];
        if (iphone5) {
            make.size.mas_equalTo(CGSizeMake(38, 38));
        }else{
            make.size.mas_equalTo(CGSizeMake(45, 45));
        }
        make.centerY.equalTo(self);
    }];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self);
        [make.left.mas_equalTo(self.mas_left)setOffset:DCMargin];
        make.size.mas_equalTo(CGSizeMake(ScreenW/4, 15));
    }];

    [self.infoLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.titleLabel);
        make.top.mas_equalTo(self.titleLabel.mas_bottom).offset(6);
        make.size.mas_equalTo(CGSizeMake(ScreenW/3, 15));
    }];
    
}

@end
