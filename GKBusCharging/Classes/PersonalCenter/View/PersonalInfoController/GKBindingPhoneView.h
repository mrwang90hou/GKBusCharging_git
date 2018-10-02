//
//  GKBindingPhoneView.h
//  GKBusCharging
//
//  Created by L on 2018/7/4.
//  Copyright © 2018年 L. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GKBindingPhoneView : UIView
@property (nonatomic,strong)UIButton * codeBtn;
@property (nonatomic,strong)GKButton * nextBtn;
@property (nonatomic,strong)CAGradientLayer * clickLayer;
@property (nonatomic,strong)UITextField * phoneTF;
@property (nonatomic,strong)UITextField * codeTF;

@end
