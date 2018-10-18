//
//  GKBalanceViewController.h
//  GKBusCharging
//
//  Created by 王宁 on 2018/10/4.
//  Copyright © 2018年 goockr. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GKBalanceViewController : GKBaseSetViewController
/*
 扫码充电 btn
 */
@property (nonatomic,strong)UIButton * qrCodeBtn;
/*
 充值 btn
 */
@property (nonatomic,strong)UIButton * rechargeBtn;
/*
 购买 btn
 */
@property (nonatomic,strong)UIButton * rechargeCardBtn;
/*
 体现 btn
 */
@property (nonatomic,strong)UIButton * getCashBtn;
/*
 活动内容
 */
@property (nonatomic,strong)UILabel * activityContentLabel;
/*
 免费充电时长
 */
@property (nonatomic,strong)UILabel * freeHoursLabel;
/*
 余额
 */
@property (nonatomic,strong)UILabel * balanceLabel;
/*
 免费充电有效期【充电卡】detail
 */
@property (nonatomic,strong)UILabel * rechargeCardLabel;
@end
