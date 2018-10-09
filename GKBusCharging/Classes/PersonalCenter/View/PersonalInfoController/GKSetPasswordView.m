//
//  GKSetPasswordView.m
//  GKBusCharging
//
//  Created by L on 2018/7/5.
//  Copyright © 2018年 L. All rights reserved.
//

#import "GKSetPasswordView.h"

@implementation GKSetPasswordView

- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self){
        self.backgroundColor = [UIColor whiteColor]; 
        MJWeakSelf;
        UIView * phoneView = [UIView new];
        [self addSubview:phoneView];
        [phoneView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(weakSelf).with.offset(15);
            make.left.right.equalTo(weakSelf);
            make.height.mas_equalTo(50);
        }];
        phoneView.backgroundColor = [UIColor whiteColor];
        
        UIImageView * phoneIconImageView = [UIImageView new];
        [phoneView addSubview:phoneIconImageView];
        [phoneIconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(phoneView).with.offset(FixWidthNumber(17.5));
            make.centerY.equalTo(phoneView);
            make.size.mas_equalTo(CGSizeMake(22, 22));
        }];
        phoneIconImageView.contentMode = UIViewContentModeScaleAspectFit;
        phoneIconImageView.image = [UIImage imageNamed:@"icon_password"];
        
        UIView * lineView = [UIView new];
        [phoneView addSubview:lineView];
        [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(phoneView).with.offset(15);
            make.right.equalTo(phoneView).with.offset(-15);
            make.bottom.mas_equalTo(phoneView).with.offset(-1);
            make.height.mas_equalTo(1);
        }];
        lineView.backgroundColor = UIColorFromHex(0xF0F0F0);
        
        UITextField * pwdTF = [UITextField new];
        [phoneView addSubview:pwdTF];
        [pwdTF mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(phoneIconImageView.mas_right).with.offset(12);
            make.right.mas_equalTo(phoneView).with.offset(-15);
            make.height.centerY.equalTo(phoneView);
        }];
        pwdTF.placeholder = @"请设置密码";
        pwdTF.clearButtonMode = UITextFieldViewModeWhileEditing;
        pwdTF.font = GKMediumFont(16);
        pwdTF.secureTextEntry = YES;
        self.pwdTF = pwdTF;
        
        UIView * againView = [UIView new];
        [self addSubview:againView];
        [againView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(phoneView.mas_bottom);
            make.left.right.equalTo(weakSelf);
            make.height.mas_equalTo(50);
        }];
        againView.backgroundColor = [UIColor whiteColor];
        
        UIImageView * againIconImageView = [UIImageView new];
        [againView addSubview:againIconImageView];
        [againIconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(againView).with.offset(FixWidthNumber(17.5));
            make.centerY.equalTo(againView);
            make.size.mas_equalTo(CGSizeMake(22, 22));
        }];
        againIconImageView.contentMode = UIViewContentModeScaleAspectFit;
        againIconImageView.image = [UIImage imageNamed:@"icon_password"];
        
        UIView * againLineView = [UIView new];
        [againView addSubview:againLineView];
        [againLineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(againView).with.offset(15);
            make.right.equalTo(againView).with.offset(-15);
            make.bottom.mas_equalTo(againView).with.offset(-1);
            make.height.mas_equalTo(1);
        }];
        againLineView.backgroundColor = UIColorFromHex(0xF0F0F0);
        
        UITextField * againPwdTF = [UITextField new];
        [againView addSubview:againPwdTF];
        [againPwdTF mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(againIconImageView.mas_right).with.offset(12);
            make.right.mas_equalTo(againView).with.offset(-15);
            make.height.centerY.equalTo(againView);
        }];
        againPwdTF.placeholder = @"再次确认密码";
        againPwdTF.clearButtonMode = UITextFieldViewModeWhileEditing;
        againPwdTF.font = GKMediumFont(16);
        againPwdTF.secureTextEntry = YES;
        self.againPwdTF = againPwdTF;
        
        UILabel * tipLabel = [UILabel new];
        [self addSubview:tipLabel];
        [tipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(againView.mas_bottom).with.offset(10);
            make.left.mas_equalTo(weakSelf).with.offset(20);
            make.right.mas_equalTo(weakSelf).with.offset(-20);
            make.height.mas_equalTo(20);
        }];
        tipLabel.text = @"两次密码不一致";
        tipLabel.font = GKMediumFont(12);
        tipLabel.textColor = UIColorFromHex(0xFF0000);
        tipLabel.hidden = YES;
        self.tipLabel = tipLabel;
        
        GKButton * signUpBtn = [GKButton new];
        [self addSubview:signUpBtn];
        [signUpBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(tipLabel.mas_bottom).with.offset(17);
            make.left.right.equalTo(tipLabel);
            make.height.mas_equalTo(44);
        }];
        [signUpBtn setupCircleButton];
        [signUpBtn setTitle:@"注册" forState:UIControlStateNormal];
        [signUpBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        signUpBtn.titleLabel.font = GKMediumFont(16);
        self.signUpBtn = signUpBtn;
        
    }
    return self;
}


@end
