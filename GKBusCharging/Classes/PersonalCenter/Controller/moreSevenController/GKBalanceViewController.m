//
//  GKBalanceViewController.m
//  GKBusCharging
//
//  Created by 王宁 on 2018/10/4.
//  Copyright © 2018年 goockr. All rights reserved.
//

#import "GKBalanceViewController.h"
#import "DCGMScanViewController.h"
#import "GKRechargeViewController.h"
#import "GKRechargeCardViewController.h"
#import "GKTransactionDetailsViewController.h"
@interface GKBalanceViewController ()
@property (nonatomic,strong) UIButton *transactionDetailsBtn;

@end

@implementation GKBalanceViewController

//needNavBarShow;

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    //    [self.navigationController.navigationBar setBarStyle:UIBarStyleDefault];
    //    self.navigationController.delegate = self;
    //    self.navController = self.navigationController;
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    //    [self.navigationController.navigationBar setBarStyle:UIBarStyleDefault];
    //    self.navigationController.delegate = nil;
}

- (UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleDefault;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = TABLEVIEW_BG;
    self.title = @"余额";
    [self setUI];
}

-(void)setUI{
//    UIImageView *favourableActivityBGView = [[UIImageView alloc]initWithFrame:CGRectMake(5, K_HEIGHT_NAVBAR+5, ScreenW-10, 56)];
    UIImageView *favourableActivityBGView = [[UIImageView alloc]init];
    [self.view addSubview:favourableActivityBGView];
    [favourableActivityBGView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left).offset(5);
//        make.centerX.equalTo(self.view);
        make.right.mas_equalTo(self.view.mas_right).offset(-5);
        make.height.mas_equalTo(56);
//        make.width.mas_equalTo(ScreenW-10);
//        make.width.equalTo(self.view);
        make.top.mas_equalTo(K_HEIGHT_NAVBAR + 5);
    }];
    [favourableActivityBGView setImage:[UIImage imageNamed:@"icon_activity_bg"]];
    
    UILabel *titleLabel = [[UILabel alloc]init];
    [titleLabel setText:@"优惠活动："];
    [titleLabel setFont:[UIFont fontWithName:PFR size:12]];
    [titleLabel setTextColor:BASECOLOR];
    titleLabel.textAlignment = NSTextAlignmentLeft;
    [favourableActivityBGView addSubview:titleLabel];
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(favourableActivityBGView);
        make.left.mas_equalTo(favourableActivityBGView.mas_left).offset(15);
        make.size.mas_equalTo(CGSizeMake(60, 18));
    }];
    
    UILabel *contentLabel = [[UILabel alloc]init];
    [contentLabel setText:@"新用户首次充值立即获得5小时免费充电。"];
    [contentLabel setFont:[UIFont fontWithName:PFR size:12]];
    contentLabel.textAlignment = NSTextAlignmentLeft;
    [favourableActivityBGView addSubview:contentLabel];
    [contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(favourableActivityBGView);
        make.left.mas_equalTo(titleLabel.mas_right).offset(1);
        make.size.mas_equalTo(CGSizeMake(250, 18));
    }];
    self.activityContentLabel = contentLabel;
    
    /*充电时长的卡片*/
    //充电时长的卡片【卡片后期需要做成View，随客户的动态减少、增加而变换】
    UIImageView *hoursCardView = [[UIImageView alloc]init];
    [self.view addSubview:hoursCardView];
    [hoursCardView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(favourableActivityBGView.mas_bottom).offset(5);
        make.left.right.equalTo(favourableActivityBGView);
        //        make.height.mas_equalTo(ScreenH/6);
        //        make.height.mas_equalTo(120);
        make.height.mas_equalTo(K_IPHONE_5?105:120);
    }];
    [hoursCardView setImage:[UIImage imageNamed:@"gift_time_bg"]];
    
    //扫码充电btn
    UIButton *qrCodeBtn = [[UIButton alloc]init];
    [self.view addSubview:qrCodeBtn];
    [qrCodeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(hoursCardView);
//        make.centerX.mas_equalTo(ScreenW/4*3);
//        make.centerX.mas_equalTo(hoursCardView.mas_centerX).offset(55);
        make.right.mas_equalTo(hoursCardView.mas_right).offset(-30);
        make.size.mas_equalTo(CGSizeMake(110, 44));
    }];
    [qrCodeBtn setBackgroundImage:[UIImage imageNamed:@"btn_7"] forState:UIControlStateNormal];
    [qrCodeBtn setTitle:@"扫码充电" forState:UIControlStateNormal];
    [qrCodeBtn setTitleColor:BASECOLOR forState:UIControlStateNormal];
    [qrCodeBtn addTarget:self action:@selector(qrCodeBtnClick) forControlEvents:UIControlEventTouchUpInside];
    self.qrCodeBtn = qrCodeBtn;
    
    
    /*
    @"4小时"
    @"赠送充电时长"
    @"使用规则：不足1小时按1小时计算"
    */
    UILabel *freeHoursTitleLabel = [[UILabel alloc]init];
    [hoursCardView addSubview:freeHoursTitleLabel];
    [freeHoursTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(hoursCardView);
        make.left.mas_equalTo(hoursCardView.mas_left).offset(30);
        make.size.mas_equalTo(CGSizeMake(110, 22));
    }];
    [freeHoursTitleLabel setText:@"赠送充电时长"];
    freeHoursTitleLabel.textAlignment = NSTextAlignmentLeft;
    [freeHoursTitleLabel setFont:[UIFont fontWithName:PFR size:15]];
    [freeHoursTitleLabel setTextColor:[UIColor whiteColor]];
    
    
    UILabel *freeHoursLabel = [[UILabel alloc]init];
    [hoursCardView addSubview:freeHoursLabel];
    [freeHoursLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(hoursCardView.mas_centerY).offset(-30);
//        make.centerY.mas_equalTo(hoursCardView.dc_height/4);
//        make.bottom.mas_equalTo(freeHoursTitleLabel.mas_top).offset(-12);
        
        make.left.mas_equalTo(freeHoursTitleLabel);
        make.size.mas_equalTo(CGSizeMake(80, 30));
    }];
    [freeHoursLabel setText:@"4小时"];
    freeHoursLabel.textAlignment = NSTextAlignmentLeft;
    [freeHoursLabel setFont:[UIFont fontWithName:PFR size:18]];
    [freeHoursLabel setTextColor:[UIColor whiteColor]];
    self.freeHoursLabel = freeHoursLabel;
    
    
    UILabel *freeHoursUseRuleLabel = [[UILabel alloc]init];
    [hoursCardView addSubview:freeHoursUseRuleLabel];
    [freeHoursUseRuleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(hoursCardView.mas_centerY).offset(30);
        make.left.mas_equalTo(freeHoursTitleLabel);
        make.size.mas_equalTo(CGSizeMake(200, 16));
    }];
    [freeHoursUseRuleLabel setText:@"使用规则：不足1小时按1小时计算"];
    [freeHoursUseRuleLabel setFont:[UIFont fontWithName:PFR size:12]];
    [freeHoursUseRuleLabel setTextColor:[UIColor whiteColor]];
    
    /*余额的卡片*/
    UIImageView *balanceCardView = [[UIImageView alloc]init];
    [self.view addSubview:balanceCardView];
    [balanceCardView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(hoursCardView.mas_bottom).offset(5);
        make.left.right.equalTo(favourableActivityBGView);
        make.height.mas_equalTo(hoursCardView);
    }];
    [balanceCardView setImage:[UIImage imageNamed:@"balance_bg"]];
    
    //充值btn
    UIButton *rechargeBtn = [[UIButton alloc]init];
    [self.view addSubview:rechargeBtn];
    [rechargeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(balanceCardView);
//        make.centerX.mas_equalTo(ScreenW/4*3);
        make.right.mas_equalTo(hoursCardView.mas_right).offset(-30);
        make.size.mas_equalTo(CGSizeMake(110, 44));
    }];
    [rechargeBtn setBackgroundImage:[UIImage imageNamed:@"btn_3"] forState:UIControlStateNormal];
    [rechargeBtn setTitle:@"充值" forState:UIControlStateNormal];
    [rechargeBtn addTarget:self action:@selector(rechargeBtnClick) forControlEvents:UIControlEventTouchUpInside];
//    [rechargeBtn setTintColor:[UIColor whiteColor]];
    rechargeBtn.titleLabel.textColor = [UIColor whiteColor];
    self.rechargeBtn = rechargeBtn;


    UILabel *balanceTitleLabel = [[UILabel alloc]init];
    [balanceCardView addSubview:balanceTitleLabel];
    [balanceTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(balanceCardView.mas_left).offset(30);
        make.centerY.mas_equalTo(balanceCardView.mas_centerY).offset(-15);
        make.size.mas_equalTo(CGSizeMake(80, 30));
    }];
    [balanceTitleLabel setText:@"余额"];
    balanceTitleLabel.textAlignment = NSTextAlignmentLeft;
    [balanceTitleLabel setFont:[UIFont fontWithName:PFR size:18]];
    [balanceTitleLabel setTextColor:TEXTMAINCOLOR];


    UILabel *balanceLabel = [[UILabel alloc]init];
    [balanceCardView addSubview:balanceLabel];
    [balanceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(balanceTitleLabel);
        make.centerY.mas_equalTo(balanceCardView.mas_centerY).offset(15);
        make.size.mas_equalTo(CGSizeMake(80, 22));
    }];
    [balanceLabel setText:@"￥99元"];
    balanceLabel.textAlignment = NSTextAlignmentLeft;
    [balanceLabel setFont:[UIFont fontWithName:PFR size:15]];
    [balanceLabel setTextColor:RGBall(153)];
    self.balanceLabel = balanceLabel;

    /*充电卡的卡片*/
    UIImageView *rechargeCardView = [[UIImageView alloc]init];
    [self.view addSubview:rechargeCardView];
    [rechargeCardView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(balanceCardView.mas_bottom).offset(5);
        make.left.right.equalTo(favourableActivityBGView);
        make.height.equalTo(balanceCardView);
    }];
    [rechargeCardView setImage:[UIImage imageNamed:@"charging_card_bg"]];
//    [rechargeCardView setImage:[UIImage imageNamed:@"balance_bg"]];
    
    //充值btn
    UIButton *rechargeCardBtn = [[UIButton alloc]init];
    [self.view addSubview:rechargeCardBtn];
    [rechargeCardBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(rechargeCardView);
        //        make.centerX.mas_equalTo(ScreenW/4*3);
        make.right.mas_equalTo(rechargeCardView.mas_right).offset(-30);
        make.size.mas_equalTo(CGSizeMake(110, 44));
    }];
    [rechargeCardBtn setBackgroundImage:[UIImage imageNamed:@"btn_3"] forState:UIControlStateNormal];
    [rechargeCardBtn setTitle:@"购买" forState:UIControlStateNormal];
    [rechargeCardBtn addTarget:self action:@selector(buyRechargeCardBtnClick) forControlEvents:UIControlEventTouchUpInside];
    //    [rechargeBtn setTintColor:[UIColor whiteColor]];
    rechargeCardBtn.titleLabel.textColor = [UIColor whiteColor];
    self.rechargeCardBtn = rechargeCardBtn;
    
    
    UILabel *rechargeCardTitleLabel = [[UILabel alloc]init];
    [rechargeCardView addSubview:rechargeCardTitleLabel];
    [rechargeCardTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(rechargeCardView.mas_left).offset(30);
        make.centerY.mas_equalTo(rechargeCardView.mas_centerY).offset(-15);
        make.size.mas_equalTo(CGSizeMake(80, 30));
    }];
    [rechargeCardTitleLabel setText:@"充电卡"];
    rechargeCardTitleLabel.textAlignment = NSTextAlignmentLeft;
    [rechargeCardTitleLabel setFont:[UIFont fontWithName:PFR size:18]];
    [rechargeCardTitleLabel setTextColor:TEXTMAINCOLOR];
    
    
    UILabel *rechargeCardLabel = [[UILabel alloc]init];
    [rechargeCardView addSubview:rechargeCardLabel];
    [rechargeCardLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(rechargeCardTitleLabel);
        make.centerY.mas_equalTo(rechargeCardView.mas_centerY).offset(15);
        make.size.mas_equalTo(CGSizeMake(240, 22));
    }];
    [rechargeCardLabel setText:@"免费充电有效期6天"];
    rechargeCardLabel.textAlignment = NSTextAlignmentLeft;
    [rechargeCardLabel setFont:[UIFont fontWithName:PFR size:15]];
    [rechargeCardLabel setTextColor:RGBall(153)];
    self.rechargeCardLabel = rechargeCardLabel;

    
    UIButton * getCashBtn = [UIButton new];
    [self.view addSubview:getCashBtn];
    [getCashBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self.view.mas_bottom).with.offset(-20);
        make.left.mas_equalTo(self.view).with.offset(20);
        make.right.mas_equalTo(self.view).with.offset(-20);
        make.height.mas_equalTo(44);
    }];
    [getCashBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [getCashBtn setTitle:@"提现" forState:UIControlStateNormal];
    getCashBtn.titleLabel.font = GKMediumFont(16);
    [getCashBtn setBackgroundImage:[UIImage imageNamed:@"btn_5_disabled"] forState:UIControlStateNormal];
    [getCashBtn addTarget:self action:@selector(getCashBtnClick) forControlEvents:UIControlEventTouchUpInside];
    self.getCashBtn = getCashBtn;
    //查看交易明细
    UIButton *transactionDetailsBtn = [[UIButton alloc]init];
    [transactionDetailsBtn setTitle:@"查看交易明细" forState:UIControlStateNormal];
    [transactionDetailsBtn setTitleColor:TEXTMAINCOLOR forState:UIControlStateNormal];
    transactionDetailsBtn.titleLabel.font = GKFont(14);
    [transactionDetailsBtn addTarget:self action:@selector(transactionDetailsBtnAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:transactionDetailsBtn];
    [transactionDetailsBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(getCashBtn.mas_top).with.offset(-33);
        make.centerX.equalTo(self.view);
        make.height.mas_equalTo(20);
    }];
    self.transactionDetailsBtn = transactionDetailsBtn;
}
//扫码充电
- (void)qrCodeBtnClick{
    //    [SVProgressHUD showSuccessWithStatus:@"扫码充电！"];
//    DCGMScanViewController * vc = [DCGMScanViewController new];
//    [self.navigationController popToViewController:vc animated:YES];
//    self.modalPresentationStyle = UIModalPresentationPageSheet;
//    [self presentViewController:vc animated:YES completion:NULL];
    
    DCGMScanViewController * modal = [[DCGMScanViewController alloc] init];
    //把当前控制器作为背景
//    self.definesPresentationContext = YES;
    //设置模态视图弹出样式
//    modal.modalPresentationStyle = UIModalPresentationOverFullScreen;
//    [self presentViewController:modal animated:YES completion:nil];
    [self.navigationController pushViewController:modal animated:YES];
}
//充值
- (void)rechargeBtnClick{
    [SVProgressHUD showSuccessWithStatus:@"充值！"];
    [self.navigationController pushViewController:[GKRechargeViewController new] animated:YES];
}
//购买
- (void)buyRechargeCardBtnClick{
    [SVProgressHUD showSuccessWithStatus:@"购买充电卡！"];
    [self.navigationController pushViewController:[GKRechargeCardViewController new] animated:YES];
}

//查看交易明细
-(void)transactionDetailsBtnAction{
//    [SVProgressHUD  showInfoWithStatus:@"查看交易明细"];
    [self.navigationController pushViewController:[GKTransactionDetailsViewController new] animated:YES];
}
/* 提现 */
- (void)getCashBtnClick{
    [SVProgressHUD showWithStatus:@"正在提现..."];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [SVProgressHUD dismiss];
        [SVProgressHUD showSuccessWithStatus:@"提现成功！"];
    });
}
@end
