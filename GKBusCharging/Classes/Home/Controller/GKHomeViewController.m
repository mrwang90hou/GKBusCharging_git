//
//  GKHomeViewController.m
//  GKBusCharging
//
//  Created by L on 2018/9/26.
//  Copyright © 2018年 goockr. All rights reserved.
//

#import "GKHomeViewController.h"

// Controllers
#import "GKNavigationController.h"
#import "DCGMScanViewController.h"

//#import "DCTabBarController.h"
#import "DCRegisteredViewController.h"
// Models

// Views
#import "DCAccountPsdView.h" //账号密码登录
#import "DCVerificationView.h" //验证码登录
#import "GKUpDownButton.h"
// Vendors

// Categories

// Others

@interface GKHomeViewController()


/* 上一次选中的按钮 */
@property (strong , nonatomic)UIButton *selectBtn;
/* indicatorView */
@property (strong , nonatomic)UIView *indicatorView;
/* titleView */
@property (strong , nonatomic)UIView *titleView;
/* contentView */
@property (strong , nonatomic)UIScrollView *contentView;

/* 验证码 */
@property (strong , nonatomic)DCVerificationView *verificationView;
/* 账号密码登录 */
@property (strong , nonatomic)DCAccountPsdView *accountPsdView;
@end

@implementation GKHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setUpNavBarView];
    
    [self setUI];
    
    [self setUpTabBarView];
    
    [self getData];
    
}

#pragma mark - 按钮点击
- (void)buttonClick:(UIButton *)button
{
    button.selected = !button.selected;
    [_selectBtn setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    [button setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    
    _selectBtn = button;
    
    WEAKSELF
    [UIView animateWithDuration:0.25 animations:^{
        weakSelf.indicatorView.dc_width = button.titleLabel.dc_width;
        weakSelf.indicatorView.dc_centerX = button.dc_centerX;
    }];
    
    CGPoint offset = _contentView.contentOffset;
    offset.x = _contentView.dc_width * button.tag;
    [_contentView setContentOffset:offset animated:YES];
}

- (void)setUpNavBarView{
    
    UIView *topView = [[UIView alloc]init];
    [topView setBackgroundColor:[UIColor redColor]];
    [self.view addSubview:topView];
    
    [topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view);
        make.top.mas_equalTo(self.view).with.offset(K_HEIGHT_NAVBAR);
        //        make.top.equalTo(self.navigationController.navigationBar);
        //        make.size.mas_equalTo(CGSizeMake(ScreenW, self.navigationController.navigationBar.frame.size.height/3*2));
        //        make.size.mas_equalTo(CGSizeMake(ScreenW,ScreenW));
        make.height.mas_equalTo(DCNaviH);
        make.width.equalTo(self.view);
        //        make.top.equalTo(self.view);
    }];
    
}

- (void)setUpTabBarView{
    UIView *tabBarView = [[UIView alloc]init];
    [tabBarView setBackgroundColor:[UIColor clearColor]];
    [self.view addSubview:tabBarView];
    
    [tabBarView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view);
        make.bottom.equalTo(self.view);
        make.height.mas_equalTo(K_HEIGHT_TABBAR);
        make.width.equalTo(self.view);
    }];
    
    UIImageView *imageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"nav_bar_bg"]];
    [tabBarView addSubview:imageView];
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.mas_equalTo(tabBarView);
        make.size.mas_equalTo(tabBarView);
    }];
    //扫码按钮
    GKUpDownButton *plusButton = [[GKUpDownButton alloc] init];
    [plusButton setImage:SETIMAGE(@"nav_btn_scavenging_charging_normal") forState:0];
    [plusButton setImage:SETIMAGE(@"nav_btn_scavenging_charging_normal_2") forState:UIControlStateHighlighted];
    // 设置图标
    [plusButton setTitle:@"扫码充电" forState:UIControlStateNormal];
    [plusButton setTitleColor:TEXTCOLOR_LIGHT forState:0];
    [plusButton setTitleEdgeInsets:UIEdgeInsetsMake(80, AUTO(40),0, AUTO(40))];
    plusButton.titleLabel.font = FONT(AUTO(13));
    [plusButton addTarget:self action:@selector(scanQRCode) forControlEvents:UIControlEventTouchUpInside];
//    plusButton.userInteractionEnabled = YES;
    [self.view addSubview:plusButton];
    [plusButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(imageView);
        make.top.mas_equalTo(imageView).with.offset(-K_HEIGHT_TABBAR/2);
        make.height.mas_equalTo(K_HEIGHT_TABBAR/2*3);
        make.width.mas_equalTo(K_HEIGHT_TABBAR/2*3);
    }];
    //个人中心
    GKUpDownButton * personCenterBtn = [[GKUpDownButton alloc] init];
    [personCenterBtn setImage:SETIMAGE(@"nav_btn_personal_center_normal") forState:0];
    [personCenterBtn setImage:SETIMAGE(@"nav_btn_personal_center_pressed") forState:UIControlStateHighlighted];
    // 设置图标
    [personCenterBtn setTitle:@"个人中心" forState:UIControlStateNormal];
    [personCenterBtn setTitleColor:TEXTCOLOR_LIGHT forState:0];
//    [personCenterBtn setTitleEdgeInsets:UIEdgeInsetsMake(80, AUTO(40),0, AUTO(40))];
    personCenterBtn.titleLabel.font = FONT(AUTO(13));
    [personCenterBtn addTarget:self action:@selector(pushToPersonalCenter) forControlEvents:UIControlEventTouchUpInside];
//    personCenterBtn.userInteractionEnabled = YES;
    [self.view addSubview:personCenterBtn];
    [personCenterBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(imageView.center).offset(-ScreenW/4-K_HEIGHT_TABBAR/2);
        make.top.equalTo(imageView);
        make.height.mas_equalTo(K_HEIGHT_TABBAR/2*3);
        make.width.mas_equalTo(K_HEIGHT_TABBAR/2*3);
    }];
    //联系客服
    GKUpDownButton *serviceBtn = [[GKUpDownButton alloc] init];
    [serviceBtn setImage:SETIMAGE(@"nav_btn_contact_service_normal") forState:0];
    [serviceBtn setImage:SETIMAGE(@"nav_btn_contact_service_pressed") forState:UIControlStateHighlighted];
    // 设置图标
    [serviceBtn setTitle:@"联系客服" forState:UIControlStateNormal];
    [serviceBtn setTitleColor:TEXTCOLOR_LIGHT forState:0];
//    [serviceBtn setTitleEdgeInsets:UIEdgeInsetsMake(80, AUTO(40),0, AUTO(40))];
    serviceBtn.titleLabel.font = FONT(AUTO(13));
    [serviceBtn addTarget:self action:@selector(popWindowAtBottom) forControlEvents:UIControlEventTouchUpInside];
//    serviceBtn.userInteractionEnabled = YES;
    [self.view addSubview:serviceBtn];
    [serviceBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(imageView.center).offset(ScreenW/4+K_HEIGHT_TABBAR/2);
        make.top.equalTo(imageView);
        make.height.mas_equalTo(K_HEIGHT_TABBAR/2*3);
        make.width.mas_equalTo(K_HEIGHT_TABBAR/2*3);
    }];
}

- (void)setUI{
    self.title = @"冲哈哈😆";
//    self.view.backgroundColor = [UIColor lightGrayColor];
    //广告视图
    UIView *adView = [[UIView alloc]init];
    [adView setBackgroundColor:[UIColor orangeColor]];
    [self.view addSubview:adView];
    [adView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view);
        make.top.mas_equalTo(self.view).with.offset(K_HEIGHT_NAVBAR+DCNaviH);
        make.height.mas_equalTo(ScreenW/2);
        make.width.equalTo(self.view);
    }];
    
    //信息视图
    UIView *infoView = [[UIView alloc]init];
    [infoView setBackgroundColor:[UIColor yellowColor]];
    [self.view addSubview:infoView];
    [infoView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view);
        make.top.mas_equalTo(self.view).with.offset(K_HEIGHT_NAVBAR+DCNaviH+ScreenW/2+DCNaviH/2);
        make.height.mas_equalTo(ScreenH - (K_HEIGHT_NAVBAR+DCNaviH+ScreenW/2+DCNaviH/2) - K_HEIGHT_TABBAR);
        make.width.equalTo(self.view);
    }];
    
}

- (void)getData{
    
}
- (void)pushToPersonalCenter{
    [SVProgressHUD showInfoWithStatus:@"Push!"];
    GKBaseSetViewController *vc = [GKBaseSetViewController new];
    vc.title = @"new";
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)scanQRCode{
    DCGMScanViewController *dcGMvC = [DCGMScanViewController new];
    [self.navigationController pushViewController:dcGMvC animated:YES];
}
-(void)popWindowAtBottom{
    /*      选择操作
     */
    UIAlertController *alertVc = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *cancle = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction *_Nonnull action) {
        
    }];
    
    UIAlertAction *telephone = [UIAlertAction actionWithTitle:@"0757-86678686" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        
    }];
    
    UIAlertAction *call = [UIAlertAction actionWithTitle:@"呼叫" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        
    }];
    [alertVc addAction:cancle];
    [alertVc addAction:telephone];
    [alertVc addAction:call];
    [self presentViewController:alertVc animated:YES completion:nil];
}


@end
