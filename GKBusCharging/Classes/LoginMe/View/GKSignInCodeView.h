//
//  GKSignInCodeView.h
//  Record
//
//  Created by L on 2018/7/5.
//  Copyright © 2018年 L. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GKSignInCodeView : UIView
@property (nonatomic,strong)UIButton * codeBtn;
@property (nonatomic,strong)GKButton * nextBtn;
@property (nonatomic,strong)CAGradientLayer * clickLayer;
@property (nonatomic,strong)UITextField * phoneTF;
@property (nonatomic,strong)UITextField * codeTF;
@property (nonatomic,strong)UIButton * forgotBtn;
@property (nonatomic,strong)UITextField * pwdTF;

@property (nonatomic,strong)UIView * pwdView;

@property (nonatomic,strong)UIView * codeView;


@property (nonatomic,strong) UIButton *cancelButton;

@end
