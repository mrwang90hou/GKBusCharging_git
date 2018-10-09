//
//  GKSetPasswordView.h
//  GKBusCharging
//
//  Created by L on 2018/7/5.
//  Copyright © 2018年 L. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GKSetPasswordView : UIView
@property (nonatomic,strong) UITextField *pwdTF;
@property (nonatomic,strong) UITextField *againPwdTF;
@property (nonatomic,strong) UILabel *tipLabel;
@property (nonatomic,strong) GKButton *signUpBtn;

@end
