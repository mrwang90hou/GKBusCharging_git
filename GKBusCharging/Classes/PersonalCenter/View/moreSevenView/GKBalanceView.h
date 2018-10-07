//
//  GKBalanceView.h
//  GKBusCharging
//
//  Created by 王宁 on 2018/10/4.
//  Copyright © 2018年 goockr. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GKBalanceView : UIView
@property (nonatomic,strong)UIButton * qrCodeBtn;
@property (nonatomic,strong)UIButton * rechargeBtn;
@property (nonatomic,strong)GKButton * getCashBtn;



@property (nonatomic,strong)CAGradientLayer * clickLayer;
@property (nonatomic,strong)UITextField * phoneTF;
@property (nonatomic,strong)UITextField * codeTF;

@end
