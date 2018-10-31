//
//  GKPersonalHeaderView.m
//  GKBusCharging
//
//  Created by L on 2018/9/28.
//  Copyright © 2018年 goockr. All rights reserved.
//
#import "GKPersonalHeaderView.h"

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
        headTitleLabel.text = @"";
//        if ([DCObjManager dc_readUserDataForKey:@"UserName"] != nil) {
//            [headTitleLabel setText:[DCObjManager dc_readUserDataForKey:@"UserName"]];
//        }else{
            [headTitleLabel setText:@"昵称"];
//        }
//        [SVProgressHUD showInfoWithStatus:[DCObjManager dc_readUserDataForKey:@"UserName"]];
        headTitleLabel.font = GKBlodFont(24);
        headTitleLabel.textColor = RGB(88, 79, 96);
        self.headTitleLabel = headTitleLabel;
//        UIButton * phoneBtn = [[UIButton alloc]init];
        DCZuoWenRightButton *phoneBtn = [DCZuoWenRightButton buttonWithType:UIButtonTypeCustom];
        [self addSubview:phoneBtn];
        [phoneBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(lineView.mas_bottom).with.offset(3);
            make.left.equalTo(headTitleLabel);
            make.size.mas_equalTo(CGSizeMake(120, 24));
        }];
//        phoneBtn.titleLabel.textColor = [UIColor redColor];
        phoneBtn.titleLabel.textAlignment = NSTextAlignmentLeft;
        
//        if ([[DCObjManager dc_readUserDataForKey:@"myPhone"] length] == 11) {
//            [phoneBtn setTitle:[DCObjManager dc_readUserDataForKey:@"myPhone"] forState:UIControlStateNormal];
//        }else{
            [phoneBtn setTitle:@"绑定手机号码" forState:UIControlStateNormal];
//        }
        [phoneBtn setTitleColor:RGB(31, 206, 155) forState:UIControlStateNormal];
        [phoneBtn setImage:[UIImage imageNamed:@"icon_namber_more"] forState:UIControlStateNormal];
        phoneBtn.titleLabel.font = GKBlodFont(16);
        self.phoneBtn = phoneBtn;

    
        UIView * iconImageViewBGView = [[UIView alloc]init];
        [self addSubview:iconImageViewBGView];
        [iconImageViewBGView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(headTitleLabel);
            //            make.bottom.mas_equalTo(phoneBtn.mas_top).with.offset(-15);
            //            make.centerX.equalTo(weakSelf);
            make.right.mas_equalTo(lineView.mas_right).with.offset(-10);
            make.size.mas_equalTo(CGSizeMake(70, 70));
        }];
//        [(UIControl *)iconImageViewBGView addTarget:self action:@selector(logout) forControlEvents:UIControlEventTouchUpInside];
        
        
        UIButton * iconImageViewBtn = [UIButton new];
        [self addSubview:iconImageViewBtn];
        [iconImageViewBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(headTitleLabel);
//            make.bottom.mas_equalTo(phoneBtn.mas_top).with.offset(-15);
//            make.centerX.equalTo(weakSelf);
//            make.right.mas_equalTo(lineView.mas_right).with.offset(-10);
//            make.size.mas_equalTo(CGSizeMake(70, 70));
            make.center.equalTo(iconImageViewBGView);
            make.size.equalTo(iconImageViewBGView);
        }];
        iconImageViewBtn.layer.cornerRadius = 35;
        iconImageViewBtn.layer.masksToBounds = YES;
        iconImageViewBtn.layer.shouldRasterize = YES;
        iconImageViewBtn.layer.rasterizationScale = [UIScreen mainScreen].scale;
        iconImageViewBtn.layer.borderWidth = 2;
        iconImageViewBtn.layer.borderColor = UIColorFromHex(0xFFFFFF).CGColor;
//        [iconImageViewBtn addTarget:self action:@selector(turnToGKMeViewController) forControlEvents:UIControlEventTouchUpInside];
        [iconImageViewBtn setBackgroundImage:[UIImage imageNamed:@"icon_head_portrait"] forState:UIControlStateNormal];
//        iconImageView.image = [UIImage imageNamed:@"icon_head_portrait"];
        self.iconImageViewBtn = iconImageViewBtn;
    }
    return self;
}



@end
