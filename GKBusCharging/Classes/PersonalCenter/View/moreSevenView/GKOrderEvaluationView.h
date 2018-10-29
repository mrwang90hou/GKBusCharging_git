//
//  GKOrderEvaluationView.h
//  STOExpressDelivery
//
//  Created by mrwang90hou on 2019/10/8.
//  Copyright © 2018年 goockr. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HYBStarEvaluationView.h"

@interface GKOrderEvaluationView : UIView

@property (weak, nonatomic) IBOutlet UIView *headerView;
@property (weak, nonatomic) IBOutlet UILabel *busNumberLabel;
@property (weak, nonatomic) IBOutlet UILabel *busCardNumberLabel;
@property (weak, nonatomic) IBOutlet UILabel *starScoreLabel;

@end
