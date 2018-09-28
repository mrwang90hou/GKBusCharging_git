//
//  GKPersonalHeaderView.m
//  GKBusCharging
//
//  Created by L on 2018/9/28.
//  Copyright © 2018年 goockr. All rights reserved.
//
#import "GKPersonalHeaderView.h"
#import "DCZuoWenRightButton.h"

@implementation GKPersonalHeaderView
- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self){
//        self.backgroundColor = [UIColor lightGrayColor];
//        UIImageView * bgImageView = [UIImageView new];
//        [self addSubview:bgImageView];
//        MJWeakSelf;
//        [bgImageView mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.top.left.right.bottom.equalTo(weakSelf);
//        }];
//        bgImageView.image = [UIImage imageNamed:@"bg_personal_center"];
//        bgImageView.contentMode = UIViewContentModeScaleAspectFill;

//        定位基准线
        UIView *lineView = [UIView new];
        [lineView setBackgroundColor:[UIColor redColor]];
        [self addSubview:lineView];
        [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self);
            make.height.equalTo(@1);
            make.width.equalTo(@(ScreenW));
        }];
        [lineView setHidden:true];
        
        
        UILabel * headTitleLabel = [UILabel new];
        [self addSubview:headTitleLabel];
        [headTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.mas_equalTo(lineView.mas_top).with.offset(-3);
            make.left.mas_equalTo(self).with.offset(10);
//            make.centerX.equalTo(weakSelf);
            make.size.mas_equalTo(CGSizeMake(240, 24));
        }];
        headTitleLabel.text = @"租电客18577986175";
        headTitleLabel.font = GKBlodFont(18);

        UIButton * phoneBtn = [[UIButton alloc]init];
        [self addSubview:phoneBtn];
        [phoneBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(lineView.mas_bottom).with.offset(3);
            make.left.equalTo(headTitleLabel);
            make.size.mas_equalTo(CGSizeMake(120, 24));
        }];
//        phoneBtn.titleLabel.textColor = [UIColor redColor];
        phoneBtn.titleLabel.textAlignment = NSTextAlignmentLeft;
        
        [phoneBtn setTitle:@"绑定手机号码" forState:UIControlStateNormal] ;
        [phoneBtn setTitleColor:RGB(31, 206, 155) forState:UIControlStateNormal];
//        [phoneBtn setImage:[UIImage imageNamed:@"icon_namber_more"] forState:UIControlStateNormal];
        phoneBtn.titleLabel.font = GKBlodFont(14);
        self.phoneBtn = phoneBtn;

        UIImageView * iconImageView = [UIImageView new];
        [self addSubview:iconImageView];
        [iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(headTitleLabel);
//            make.bottom.mas_equalTo(phoneBtn.mas_top).with.offset(-15);
//            make.centerX.equalTo(weakSelf);
            make.right.mas_equalTo(lineView.mas_right).with.offset(-10);
            make.size.mas_equalTo(CGSizeMake(70, 70));
        }];
        iconImageView.layer.cornerRadius = 35;
        iconImageView.layer.masksToBounds = YES;
        iconImageView.layer.shouldRasterize = YES;
        iconImageView.layer.rasterizationScale = [UIScreen mainScreen].scale;
        iconImageView.layer.borderWidth = 2;
        iconImageView.layer.borderColor = UIColorFromHex(0xFFFFFF).CGColor;
        iconImageView.image = [UIImage imageNamed:@"icon_head_portrait"];
        
    }
    return self;
}
@end
