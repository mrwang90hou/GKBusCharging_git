//
//  GKPriceEvaluationView.h
//  STOExpressDelivery
//
//  Created by mrwang90hou on 2019/10/8.
//  Copyright © 2018年 goockr. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HYBStarEvaluationView.h"

@interface GKPriceEvaluationView : UIView
@property (nonatomic,assign) Boolean starIsChanged;
@property (nonatomic,assign) CGFloat actualScore;
@property (nonatomic,strong) HYBStarEvaluationView *starView;
@property (weak, nonatomic) IBOutlet UIView *headerView;
@property (weak, nonatomic) IBOutlet UIButton *cheackDetailsBtn;
@property (nonatomic,strong) UILabel *completedEvaluationLabel;
@end
