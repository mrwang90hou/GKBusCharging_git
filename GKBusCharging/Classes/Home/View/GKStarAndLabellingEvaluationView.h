//
//  GKStarAndLabellingEvaluationView.h
//  STOExpressDelivery
//
//  Created by mrwang90hou on 2019/10/8.
//  Copyright © 2018年 goockr. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HYBStarEvaluationView.h"

@interface GKStarAndLabellingEvaluationView : UIView
@property (nonatomic,assign) Boolean starIsChanged;

@property (nonatomic, assign) Boolean isCommitOrNot;
@property (nonatomic,assign) CGFloat actualScore;

@property (nonatomic,strong) HYBStarEvaluationView *starView;;
@end
