//
//  GKMeHeaderView.m
//  GKBusCharging
//
//  Created by L on 2018/7/2.
//  Copyright © 2018年 L. All rights reserved.
//

#import "GKMeHeaderView.h"

@implementation GKMeHeaderView
- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self){
        self.backgroundColor = [UIColor whiteColor];
        UIImageView * bgImageView = [UIImageView new];
        [self addSubview:bgImageView];
        MJWeakSelf;
        [bgImageView mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.top.equalTo(weakSelf).offset(K_HEIGHT_STATUSBAR);
            make.top.left.right.bottom.equalTo(weakSelf);
        }];
//        bgImageView.image = [UIImage imageNamed:@"bg_personal_center"];
        bgImageView.contentMode = UIViewContentModeScaleAspectFill;
//        [bgImageView setHidden:true];
        [bgImageView setBackgroundColor:[UIColor whiteColor]];
        
        UIImageView * iconImageView = [UIImageView new];
        [self addSubview:iconImageView];
        [iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.bottom.mas_equalTo(changeNameBtn.mas_top).with.offset(-15);
            make.centerX.equalTo(weakSelf);
//            make.centerY.mas_equalTo(weakSelf.dc_centerY-K_HEIGHT_NAVBAR).offset(-40);
//            make.top.mas_equalTo(weakSelf).offset(K_HEIGHT_NAVBAR);
            make.top.mas_equalTo(K_HEIGHT_NAVBAR+((ScreenH/5*2-K_HEIGHT_NAVBAR)/2)/2-45);
            make.size.mas_equalTo(CGSizeMake(70, 70));
        }];
        CGFloat iconImageViewGetY = (K_HEIGHT_NAVBAR+((ScreenH/5*2-K_HEIGHT_NAVBAR)/2)/2+45);
        iconImageView.layer.cornerRadius = 35;
        iconImageView.layer.masksToBounds = YES;
        iconImageView.layer.shouldRasterize = YES;
        iconImageView.layer.rasterizationScale = [UIScreen mainScreen].scale;
        iconImageView.layer.borderWidth = 2;
        iconImageView.layer.borderColor = UIColorFromHex(0xFFFFFF).CGColor;
        iconImageView.image = [UIImage imageNamed:@"icon_head_portrait"];
        
        UILabel * nameLabel = [UILabel new];
        [self addSubview:nameLabel];
//        CGFloat halfLastHeight = (ScreenH/5*2 - K_HEIGHT_NAVBAR - 70)/2;
        CGFloat halfLastHeight = (ScreenH/5*2 - iconImageViewGetY)/2;
//        CGFloat halfLastHeight = (ScreenH/5*2 - CGRectGetMaxX(iconImageView.frame))/2;
//        NSLog(@"CGRectGetMaxX(iconImageView.frame) = %lf",CGRectGetMaxX(iconImageView.frame));
        [nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.bottom.mas_equalTo(weakSelf).with.offset(-30);
            //            make.top.mas_equalTo(weakSelf)
//            make.bottom.mas_equalTo(iconImageView.mas_bottom).offset(halfLastHeight/2+12);
            make.top.mas_equalTo(iconImageView.mas_bottom).offset(halfLastHeight/2+12);
            make.centerX.equalTo(weakSelf);
            make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH/2, 24));
        }];
//        [nameLabel setText:@"租电客118"];
        [nameLabel setFont:GKBlodFont(22)];
        nameLabel.textAlignment = NSTextAlignmentCenter;
        [nameLabel setTextColor:RGBA(88, 79, 96, 0.9)];
        [nameLabel setText:@""];
        if ([DCObjManager dc_readUserDataForKey:@"UserName"] != nil) {
            [nameLabel setText:[DCObjManager dc_readUserDataForKey:@"UserName"]];
        }else{
            [nameLabel setText:@"昵称"];
        }
        self.nameLabel = nameLabel;
        
        UIButton * changeNameBtn = [UIButton new];
        [self addSubview:changeNameBtn];
        [changeNameBtn mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.bottom.mas_equalTo(weakSelf).with.offset(-10);
//            make.top.mas_equalTo(ScreenH/5*2 - halfLastHeight + 12);
            make.top.mas_equalTo(ScreenH/5*2 - halfLastHeight);
            
            make.centerX.equalTo(weakSelf);
            make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH, 18));
        }];
//        [changeNameBtn setBackgroundColor:[UIColor redColor]];
        changeNameBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
//        changeNameBtn.titleLabel.textColor = RGBall(104);
        [changeNameBtn setTitleColor:RGBall(221) forState:UIControlStateNormal];
        [changeNameBtn setTitle:@"更改昵称" forState:UIControlStateNormal] ;
        changeNameBtn.titleLabel.font = GKBlodFont(14);
        self.changeNameBtn = changeNameBtn;
        
//        UILabel * vcTitleLabel = [UILabel new];
//        [self addSubview:vcTitleLabel];
//        [vcTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.bottom.mas_equalTo(iconImageView.mas_top).with.offset(-22);
//            make.centerX.equalTo(weakSelf);
//            make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH, 24));
//        }];
//        vcTitleLabel.textAlignment = NSTextAlignmentCenter;
//        vcTitleLabel.textColor = [UIColor whiteColor];
//        vcTitleLabel.text = @"我的";
//        vcTitleLabel.font = GKBlodFont(17);
    }
    return self;
}
@end
