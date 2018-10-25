//
//  GKEvaluateViewController.m
//  GKBusCharging
//
//  Created by L on 2018/10/25.
//  Copyright © 2018年 goockr. All rights reserved.
//

#import "GKEvaluateViewController.h"
#import "GKPriceEvaluationView.h"
#import "GKStarAndLabellingEvaluationView.h"
#import "GKStarAndLabellingEvaluationView2.h"
#import "GKOrderDetailsViewController.h"
@interface GKEvaluateViewController()


@property (nonatomic,strong) GKPriceEvaluationView *priceEvaluationView;
@property (nonatomic,strong) GKStarAndLabellingEvaluationView2 *starAndLabellingEvaluationView2;
@end

@implementation GKEvaluateViewController
-(void)viewDidLoad{
    [super viewDidLoad];
    [self.view setBackgroundColor:TABLEVIEW_BG];
    self.title = @"评价";
    [self setUI];
    [self addObserver];
    UIBarButtonItem *btn = [[UIBarButtonItem alloc]initWithTitle:@"TEST" style:UIBarButtonItemStyleDone target:self action:@selector(show)];
    [self.navigationItem setRightBarButtonItem:btn];
    
}

-(void)setUI{
    _priceEvaluationView = [GKPriceEvaluationView dc_viewFromXib];
    [self.view addSubview:_priceEvaluationView];
    _priceEvaluationView.frame = CGRectMake(0, K_HEIGHT_NAVBAR, ScreenW, (ScreenH-K_HEIGHT_NAVBAR)/2);
    [_priceEvaluationView.cheackDetailsBtn addTarget:self action:@selector(cheackDetailsBtnAction) forControlEvents:UIControlEventTouchUpInside];
    _starAndLabellingEvaluationView2 = [GKStarAndLabellingEvaluationView2 dc_viewFromXib];
    [self.view addSubview:_starAndLabellingEvaluationView2];
    [_starAndLabellingEvaluationView2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.priceEvaluationView.headerView.mas_bottom).offset(1);
        make.left.right.equalTo(self.view);
        make.height.mas_offset((ScreenH-K_HEIGHT_NAVBAR)/2-self.priceEvaluationView.headerView.frame.size.height);
    }];
    [_starAndLabellingEvaluationView2 setHidden:true];
    [_starAndLabellingEvaluationView2.commitBtn addTarget:self action:@selector(commitBtnAction) forControlEvents:UIControlEventTouchUpInside];
    //归还指南
}

-(void)updateUI{
    //移除第二页的评价窗口
    [self.starAndLabellingEvaluationView2 removeFromSuperview];
    //第一页面评价窗口状态发生改变
    self.priceEvaluationView.starView.actualScore = 4;
//    self.priceEvaluationView.starView.isVariable = NO;
    [self.priceEvaluationView.starView removeGestureRecognizer];
    [self.priceEvaluationView.completedEvaluationLabel setHidden:false];
}

- (void) addObserver
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(starIsChangedAction) name:@"starIsChanged" object:nil];
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark -页面逻辑方法
#pragma mark -点击事件的方法
// 点击【查看明细】
-(void)cheackDetailsBtnAction{
    [self.navigationController pushViewController:[GKOrderDetailsViewController new] animated:YES];
}
//点击【星星✨】
- (void)starIsChangedAction{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        CGFloat actualScore = self.priceEvaluationView.actualScore;
        [self.starAndLabellingEvaluationView2 setHidden:false];
        self.starAndLabellingEvaluationView2.actualScore = actualScore;
        self.starAndLabellingEvaluationView2.starView.actualScore = actualScore;
    });
}
//点击提交【匿名评价】
-(void)commitBtnAction{
    [SVProgressHUD showWithStatus:@"正在提交中，请稍后..."];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [SVProgressHUD dismiss];
        SIAlertView *alertView = [[SIAlertView alloc] initWithTitle:@"     " andMessage:@"提交失败，请重新提交"];
        [alertView addButtonWithTitle:@"返回"
                                 type:SIAlertViewButtonTypeDefault
                              handler:^(SIAlertView *alertView) {
                                  [alertView dismissAnimated:NO];
                              }];
        [alertView addButtonWithTitle:@"重新提交"
                                 type:SIAlertViewButtonTypeDestructive
                              handler:^(SIAlertView *alertView) {
                                  [alertView dismissAnimated:NO];
                                  [self againCommitFeedback];
                              }];
        [alertView show];
    });
}
//点击【再次提交】
-(void)againCommitFeedback{
    [SVProgressHUD showWithStatus:@"正在提交中，请稍后..."];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [SVProgressHUD dismiss];
        [SVProgressHUD showSuccessWithStatus:@"提交成功！"];
        [self updateUI];
    });
}

-(void)show{
    [_starAndLabellingEvaluationView2 setHidden:false];
}






@end

