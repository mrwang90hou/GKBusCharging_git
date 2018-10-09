//
//  GKBindingPhoneView.h
//  GKBusCharging
//
//  Created by 王宁 on 2018/10/1.
//  Copyright © 2018年 goockr. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GKBindingPhoneView : UIView
@property (nonatomic,strong)UIButton * codeBtn;
@property (nonatomic,strong)GKButton * nextBtn;
@property (nonatomic,strong)CAGradientLayer * clickLayer;
@property (nonatomic,strong)UITextField * phoneTF;
@property (nonatomic,strong)UITextField * codeTF;

@end
