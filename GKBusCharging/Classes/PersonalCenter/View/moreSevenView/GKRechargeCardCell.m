//
//  GKRechargeCardCell.m
//  GKBusCharging
//
//  Created by L on 2018/10/18.
//  Copyright © 2018年 goockr. All rights reserved.
//

#import "GKRechargeCardCell.h"

// Controllers

// Models

// Views
// Vendors
//#import <UIImageView+WebCache.h>
//// Categories
//#import "UIView+DCRolling.h"
//#import "UIColor+DCColorChange.h"
// Others

@interface GKRechargeCardCell ()

@end

@implementation GKRechargeCardCell

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

    UIButton *btn = [[UIButton alloc]init];
    [btn setImage:[UIImage imageNamed:@"recharge_amount_bg_normal"] forState:UIControlStateNormal];
    [btn setImage:[UIImage imageNamed:@"recharge_amount_bg_selected"] forState:UIControlStateSelected];
    [btn setImage:[UIImage imageNamed:@"recharge_amount_bg_selected"] forState:UIControlStateHighlighted];
    [self addSubview:btn];
    
    [btn addTarget:self action:@selector(method) forControlEvents:UIControlEventTouchUpInside];
    [btn setUserInteractionEnabled:NO];
    self.uiButton = btn;
    
    
    self.titleLabel = [[UILabel alloc] init];
    self.titleLabel.font = PFR18Font;
    self.titleLabel.numberOfLines = 0;//表示label可以多行显示
//    self.titleLabel.lineBreakMode = NSLineBreakByCharWrapping;//换行模式，与上面的计算保持一致。
    // 换行的模式我们选择文本自适应
    self.titleLabel.textColor = [UIColor blackColor];
    self.titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
    
//    self.titleLabel.preferredMaxLayoutWidth = ScreenW/4;
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    [self.uiButton addSubview:self.titleLabel];
    
    self.infoLabel = [[UILabel alloc] init];
    self.infoLabel.font = [UIFont systemFontOfSize:12];
    self.infoLabel.textColor = [UIColor blackColor];
    self.infoLabel.textAlignment = NSTextAlignmentCenter;
    [self.uiButton addSubview:self.infoLabel];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    [self.uiButton mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.edges.equalTo(self);
        make.left.mas_equalTo(self).offset(2);
        make.right.mas_equalTo(self).offset(-2);
        make.center.equalTo(self);
        make.height.mas_equalTo(self);
    }];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self);
        make.centerY.mas_equalTo(self).offset(-10);;
        make.size.mas_equalTo(CGSizeMake(ScreenW/4, 15));
    }];

    [self.infoLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self);
        make.centerY.mas_equalTo(self).offset(15);
        make.size.mas_equalTo(CGSizeMake(ScreenW/3, 15));
    }];
    
}
-(void)method{
    [SVProgressHUD showInfoWithStatus:@"btn"];
}
@end
