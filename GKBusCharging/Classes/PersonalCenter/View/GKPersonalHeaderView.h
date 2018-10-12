//
//  GKPersonalHeaderView.h
//  GKBusCharging
//
//  Created by L on 2018/9/28.
//  Copyright © 2018年 goockr. All rights reserved.
//
#import <UIKit/UIKit.h>
#import "DCZuoWenRightButton.h"

@interface GKPersonalHeaderView : UIView
//@property (nonatomic,strong) UIButton *phoneBtn;
@property (nonatomic,strong) DCZuoWenRightButton *phoneBtn;
@property (nonatomic,strong) UIButton * iconImageViewBtn;
@property (retain,strong) UILabel * headTitleLabel;
@end
