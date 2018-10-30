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
#import "JFCityViewController.h"
#import "SDCycleScrollView.h"
#import "GKPersonalCenterViewController.h"
#import "GKBusInfoListViewController.h"

#import "GKOrderManagementViewController.h"
#import "GKOrderDetailsViewController.h"

#import "GKStartChargingViewController.h"

#import "GKLoginViewController.h"

#import "GKUseGuideViewController.h"
#import "GKReturnGuideViewController.h"
#import "GKEvaluateViewController.h"
//#import "DCTabBarController.h"
//#import "DCRegisteredViewController.h"
// Models

// Views
 //#import "DCAccountPsdView.h" //账号密码登录
//#import "DCVerificationView.h" //验证码登录
#import "GKUpDownButton.h"
#import "DCZuoWenRightButton.h"
#import "GKBusInfoCell.h"
#import "GKPriceEvaluationView.h"
#import "GKStarAndLabellingEvaluationView.h"
// Vendors

// Categories

// Others
//#import "AFNetPackage.h"



#define HeaderImageHeight ScreenW/2



@interface GKHomeViewController()<SDCycleScrollViewDelegate>


/* 上一次选中的按钮 */
@property (strong , nonatomic)UIButton *selectBtn;
/* indicatorView */
@property (strong , nonatomic)UIView *indicatorView;
/* titleView */
@property (strong , nonatomic)UIView *titleView;
/* contentView */
@property (strong , nonatomic)UIScrollView *contentView;

///* 验证码 */
//@property (strong , nonatomic)DCVerificationView *verificationView;
///* 账号密码登录 */
//@property (strong , nonatomic)DCAccountPsdView *accountPsdView;

@property (nonatomic, strong) SDCycleScrollView *advertiseView;

@property (nonatomic,strong) NSString *cityName;

@property (nonatomic,strong) UIButton *cityNameBtn;

@property (nonatomic,strong) UIButton *busListBtn;

//@property (nonatomic,strong) GKUpDownButton *plusButton;

@property (nonatomic,strong) UIButton *plusButton;

@property (nonatomic, strong) NSMutableArray *images;
/* 弹窗评价窗口1 , 2 */
@property (strong , nonatomic)GKPriceEvaluationView *priceEvaluationView;
@property (strong , nonatomic)GKStarAndLabellingEvaluationView *starAndLabellingEvaluationView;

@property (nonatomic,strong) UIView *infoView;
/*
 */
@property (nonatomic,assign)int seconds;
@property (nonatomic,assign)int minutes;
@property (nonatomic,assign)int hours;
@property (nonatomic,assign) int loadRecordTime;
@property (nonatomic,strong )NSTimer *timer;


@property (nonatomic,strong) UILabel *countDownTimeLabel;

@property (nonatomic,strong) UIView *bgView;

@property (nonatomic,strong) UIView *bgHeaderView;

@property (nonatomic,strong) UIView *loginNotiView;
@property (nonatomic,strong) UIButton *loginBtn;


/*缓存*/
@property (nonatomic,assign) NSString *devid;
@property (nonatomic,assign) NSString *cabid;

@property (nonatomic,strong) NSMutableDictionary *totalData;

@end

@implementation GKHomeViewController

-(NSMutableDictionary *)totalData{
    if(!_totalData){
        _totalData = [[NSMutableDictionary alloc]init];
    }
    return _totalData;
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
//    [self updataUI];
//    [self addObserver];
    
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(qrCodeSuccessAction) name:@"QRCodeSuccess" object:nil];
}

- (void)viewDidLoad {
    self.cityName = @"佛山市";
    [super viewDidLoad];
    [self.view setBackgroundColor:RGBall(248)];
    //初始页面加载时获取当前租借状态
    [self getDatasViewDidLoading];
    [self setUpNavBarView];
    [self setUI];
    [self setUpTabBarView];
    [self getData];
    [self loadSubjectImage];
    [self addObserver];
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
    [topView setBackgroundColor:[UIColor whiteColor]];
    [self.view addSubview:topView];
    [topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view);
        make.top.mas_equalTo(self.view).with.offset(K_HEIGHT_NAVBAR);
        make.height.mas_equalTo(DCNaviH);
        make.width.equalTo(self.view);
    }];
    
    //设置定位按钮
    DCZuoWenRightButton *cityNameBtn = [DCZuoWenRightButton buttonWithType:UIButtonTypeCustom];
//    UIButton *saveBtn = [UIButton buttonWithType:UIButtonTypeCustom]
    [cityNameBtn setImage:SETIMAGE(@"iocn_place_pull_down") forState:0];
    // 设置图标
    [cityNameBtn setTitle:self.cityName forState:UIControlStateNormal];
    cityNameBtn.titleLabel.font = PFR15Font;
    [cityNameBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [cityNameBtn addTarget:self action:@selector(pickCity) forControlEvents:UIControlEventTouchUpInside];
    [topView addSubview:cityNameBtn];
    [cityNameBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(topView.mas_left).offset(4);
        make.centerY.equalTo(topView);
        make.height.equalTo(topView);
        make.width.equalTo(@60);
    }];
    self.cityNameBtn = cityNameBtn;
    
    
    UIButton *busListBtn = [[UIButton alloc]init];
    [busListBtn setImage:[UIImage imageNamed:@"btn_bus_list"] forState:UIControlStateNormal];
    [topView addSubview:busListBtn];
    [busListBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(topView.mas_right).offset(-4);
        make.centerY.equalTo(topView);
        make.height.equalTo(@33);
        make.width.equalTo(@30);
    }];
    self.busListBtn = busListBtn;
    [self.busListBtn addTarget:self action:@selector(turnToBusInfoList) forControlEvents:UIControlEventTouchUpInside];
    
    //搜索栏
    UIView *topSearchView = [[UIView alloc] init];
    topSearchView.backgroundColor = RGB(248, 248, 248);
    topSearchView.layer.cornerRadius = 16;
    [topSearchView.layer masksToBounds];
    [topView addSubview:topSearchView];
    
    [topSearchView mas_makeConstraints:^(MASConstraintMaker *make) {
        [make.left.mas_equalTo(self.cityNameBtn.mas_right)setOffset:5];
        [make.right.mas_equalTo(self.busListBtn.mas_left)setOffset:-3];
        make.height.mas_equalTo(@33);
        make.centerY.mas_equalTo(topView);
    }];
    
    UIButton *searchButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [searchButton setTitle:@"查询公交线路" forState:0];
    [searchButton setTitleColor:[UIColor lightGrayColor] forState:0];
    searchButton.titleLabel.font = PFR13Font;
    [searchButton setImage:[UIImage imageNamed:@"icon_search"] forState:0];
    [searchButton adjustsImageWhenHighlighted];
    searchButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    searchButton.titleEdgeInsets = UIEdgeInsetsMake(0, 2 * DCMargin, 0, 0);
    searchButton.imageEdgeInsets = UIEdgeInsetsMake(0, DCMargin, 0, 0);
//    [searchButton addTarget:self action:@selector(searchButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [topSearchView addSubview:searchButton];
    [searchButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(topSearchView);
        make.top.mas_equalTo(topSearchView);
        make.height.mas_equalTo(topSearchView);
        [make.right.mas_equalTo(topSearchView)setOffset:-2*DCMargin];
    }];
    [searchButton addTarget:self action:@selector(turnToBusInfoList) forControlEvents:UIControlEventTouchUpInside];
    
}

- (void)setUpTabBarView{
    UIView *tabBarView = [[UIView alloc]init];
    [tabBarView setBackgroundColor:RGBall(248)];
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
//    GKUpDownButton *plusButton = [[GKUpDownButton alloc] init];
    UIButton *plusButton = [[UIButton alloc] init];
    [plusButton setImage:SETIMAGE(@"nav_btn_scavenging_charging_normal") forState:UIControlStateNormal];
    [plusButton setImage:SETIMAGE(@"nav_btn_scavenging_charging_normal_2") forState:UIControlStateSelected];
    [plusButton setImage:SETIMAGE(@"nav_btn_scavenging_charging_normal_2") forState:UIControlStateHighlighted];
    // 设置图标
//    [plusButton setTitle:@"扫码充电" forState:UIControlStateNormal];
//    [plusButton setTitleColor:TEXTCOLOR_LIGHT forState:0];
//    [plusButton setTitleEdgeInsets:UIEdgeInsetsMake(80, AUTO(40),0, AUTO(40))];
//    [plusButton setTitleEdgeInsets:UIEdgeInsetsMake(80, AUTO(40),0, AUTO(40))];
//    plusButton.titleLabel.font = FONT(AUTO(13));
    [plusButton addTarget:self action:@selector(scanQRCode) forControlEvents:UIControlEventTouchUpInside];
//    plusButton.userInteractionEnabled = YES;
    [self.view addSubview:plusButton];
    [plusButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(imageView);
//        make.top.mas_equalTo(imageView).with.offset(-K_HEIGHT_TABBAR/3*2);
//        make.top.mas_equalTo(imageView).with.offset(-K_HEIGHT_TABBAR/2);
//        make.height.mas_equalTo(K_HEIGHT_TABBAR/2*3);
//        make.width.mas_equalTo(K_HEIGHT_TABBAR/2*3);
        make.centerY.mas_equalTo(imageView.mas_top);
        make.size.mas_equalTo(CGSizeMake(120, 120));
    }];
    self.plusButton = plusButton;
    /*新增 button中的 label*/
    UILabel *textLabel = [[UILabel alloc]init];
    [plusButton addSubview:textLabel];
    [textLabel setText:@"扫码充电"];
    [textLabel setFont:GKFont(14)];
    [textLabel setTextColor:RGBall(255)];
    [textLabel setUserInteractionEnabled:NO];
    [textLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(plusButton);
        make.bottom.mas_equalTo(plusButton.mas_top).offset(90);
        make.size.mas_equalTo(CGSizeMake(60, 22));
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
    [serviceBtn addTarget:self action:@selector(clickContactPhone) forControlEvents:UIControlEventTouchUpInside];
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
    self.title = @"充哈哈";
//    self.view.backgroundColor = [UIColor lightGrayColor];
    //广告视图
    UIView *adView = [[UIView alloc]init];
    [adView setBackgroundColor:[UIColor whiteColor]];
    [self.view addSubview:adView];
    [adView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view);
        make.top.mas_equalTo(self.view).with.offset(K_HEIGHT_NAVBAR+DCNaviH);
        make.height.mas_equalTo(ScreenW/2);
        make.width.equalTo(self.view);
    }];
    [adView addSubview:self.advertiseView];
    
    //分割 view
    UIView *uiView = [[UIView alloc]init];
//    [uiView setBackgroundColor:RGB(244, 244, 244)];
    [uiView setBackgroundColor:RGB(255, 255, 255)];
    [self.view addSubview:uiView];
    [uiView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view);
        make.top.mas_equalTo(adView.mas_bottom).offset(0);
        make.height.mas_equalTo(DCNaviH/3);
        make.width.equalTo(self.view);
    }];
    [uiView setHidden:true];
    //信息视图
    UIView *infoBgView = [[UIView alloc]init];
    [infoBgView setBackgroundColor:RGBall(248)];
    [self.view addSubview:infoBgView];
    [infoBgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view);
//        make.top.mas_equalTo(self.view).with.offset(K_HEIGHT_NAVBAR+DCNaviH+ScreenW/2+DCNaviH/2);
//        make.top.mas_equalTo(adView).offset(DCNaviH/3);
        make.top.mas_equalTo(uiView.mas_bottom).offset(0);
        make.height.mas_equalTo(ScreenH - (K_HEIGHT_NAVBAR+DCNaviH+ScreenW/2+DCNaviH/2) - K_HEIGHT_TABBAR);
        make.width.equalTo(self.view);
    }];
    /*提示登录的信息视图*/
    UIView *loginNotiView = [[UIView alloc]init];
    loginNotiView.backgroundColor = [UIColor whiteColor];
    //设置圆角边框
    loginNotiView.layer.cornerRadius = 8;
    loginNotiView.layer.masksToBounds = YES;
    //设置边框及边框颜色
//    loginNotiView.layer.borderWidth = 1;
//    loginNotiView.layer.borderColor =[[UIColor grayColor] CGColor];
    [self.view addSubview:loginNotiView];
    [loginNotiView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view);
        make.top.equalTo(infoBgView);
        make.left.equalTo(self.view).offset(10);
        make.right.equalTo(self.view).offset(-10);
        make.height.mas_equalTo((ScreenH - (K_HEIGHT_NAVBAR+DCNaviH+ScreenW/2+DCNaviH/2) - K_HEIGHT_TABBAR)/3);
//        make.width.equalTo(self.view);
    }];
    //登录按钮
    UIButton *loginBtn = [[UIButton alloc]init];
    [loginNotiView addSubview:loginBtn];
    [loginBtn setBackgroundImage:SETIMAGE(@"btn_6_normal") forState:UIControlStateNormal];
    [loginBtn setTitle:@"立即登录" forState: UIControlStateNormal];
    [loginBtn setTitleColor:BUTTONMAINCOLOR forState:UIControlStateNormal];
//    loginBtn.titleLabel.font = GKMediumFont(16);
    [loginBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(loginNotiView);
        make.right.mas_equalTo(loginNotiView.mas_right).offset(-15);
        make.size.mas_equalTo(CGSizeMake(110, 44));
    }];
    [loginBtn addTarget:self action:@selector(checkLoginStatus) forControlEvents:UIControlEventTouchUpInside];
    
    UILabel *loginTitleLabel = [[UILabel alloc]init];
    [loginNotiView addSubview:loginTitleLabel];
    [loginTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(loginNotiView.mas_left).offset(15);
        make.centerY.mas_equalTo(loginNotiView.mas_centerY).offset(-15);
        make.size.mas_equalTo(CGSizeMake(120, 30));
    }];
    [loginTitleLabel setText:@"登录提醒"];
    loginTitleLabel.textAlignment = NSTextAlignmentLeft;
    [loginTitleLabel setFont:[UIFont fontWithName:PFR size:18]];
    [loginTitleLabel setTextColor:TEXTMAINCOLOR];
    
    UILabel *loginDetailLabel = [[UILabel alloc]init];
    [loginNotiView addSubview:loginDetailLabel];
    [loginDetailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(loginTitleLabel);
        make.centerY.mas_equalTo(loginNotiView.mas_centerY).offset(15);
        make.size.mas_equalTo(CGSizeMake(220, 22));
    }];
    [loginDetailLabel setText:@"需要登录后才能正常使用。"];
    loginDetailLabel.textAlignment = NSTextAlignmentLeft;
    [loginDetailLabel setFont:[UIFont fontWithName:PFR size:15]];
    [loginDetailLabel setTextColor:RGBall(153)];
    
    
    //判断是否登录状态
    if (![[DCObjManager dc_readUserDataForKey:@"isLogin"] isEqualToString:@"1"]) {
        [loginNotiView setHidden:NO];
    } else {
        [loginNotiView setHidden:YES];
    }
    self.loginNotiView = loginNotiView;
    /**
        *隐藏加载视图内容
        */
    UIView *infoView = [[UIView alloc]init];
    [infoView setBackgroundColor:[UIColor whiteColor]];
    [self.view addSubview:infoView];
    [infoView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view);
        //        make.top.mas_equalTo(self.view).with.offset(K_HEIGHT_NAVBAR+DCNaviH+ScreenW/2+DCNaviH/2);
        //        make.top.mas_equalTo(adView).offset(DCNaviH/3);
        make.top.mas_equalTo(uiView.mas_bottom).offset(0);
        make.height.mas_equalTo(ScreenH - (K_HEIGHT_NAVBAR+DCNaviH+ScreenW/2+DCNaviH/2) - K_HEIGHT_TABBAR);
        make.width.equalTo(self.view);
    }];
    self.infoView = infoView;
    [self.infoView setHidden:true];
//    if ([[DCObjManager dc_readUserDataForKey:@"isWorking"] intValue] == 1) {
//        self.infoView.hidden = false;
//    }else{
//        self.infoView.hidden = true;
//    }
    //顶部 TopView
    UIView *topView = [[UIView alloc]init];
    [topView setBackgroundColor:[UIColor whiteColor]];
    [infoView addSubview:topView];
    [topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(infoView);
        make.width.equalTo(infoView);
        make.height.equalTo(@(DCNaviH));
    }];
    UILabel *myLabel = [[UILabel alloc]init];
    [myLabel setText:@"我的充电"];
    [myLabel setTextColor:RGB(88, 79, 96)];
    myLabel.font = PFR15Font;
    [topView addSubview:myLabel];
    [myLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(topView).offset(5);
        make.centerY.equalTo(topView);
//        make.bottom.mas_equalTo(topView.mas_bottom).offset(-10);
//        make.top.mas_equalTo(topView.mas_top).offset(10);
        make.height.equalTo(@22);
        make.width.equalTo(@60);
    }];
    //订单详情
//    UIButton *orderInfoBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    DCZuoWenRightButton *orderInfoBtn = [DCZuoWenRightButton buttonWithType:UIButtonTypeCustom];
    [orderInfoBtn setImage:SETIMAGE(@"home_icon_page_more") forState:0];
    //设置图标
    [orderInfoBtn setTitle:@"订单详情" forState:UIControlStateNormal];
    [orderInfoBtn setTitleColor:RGB(88, 79, 96) forState:UIControlStateNormal];
    orderInfoBtn.titleLabel.font = PFR15Font;
    [orderInfoBtn addTarget:self action:@selector(orderInfoBtnAction) forControlEvents:UIControlEventTouchUpInside];
    [topView addSubview:orderInfoBtn];
    [orderInfoBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(topView.mas_right).offset(-5);
//        make.centerY.equalTo(topView);
        make.centerY.equalTo(myLabel);
//        make.bottom.mas_equalTo(topView.mas_bottom).offset(-15);
//        make.top.mas_equalTo(topView.mas_top).offset(10);
        make.height.equalTo(@22);
        make.width.equalTo(@90);
    }];
    //背景花纹图
    UIImageView *bgImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"home_page_Charging_bg"]];
    [infoView addSubview:bgImageView];
    [bgImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(infoView);
        make.centerY.mas_equalTo(infoView.dc_centerY + DCNaviH/2);
        make.top.mas_equalTo(infoView).offset(DCNaviH);
    }];
    
    UILabel *countDownTimeLabel = [[UILabel alloc]init];
//    [countDTownTimeLabel setText:@"00:56:01"];
    countDownTimeLabel.textAlignment = NSTextAlignmentCenter;
    countDownTimeLabel.font = [UIFont systemFontOfSize:44.0];
    [infoView addSubview:countDownTimeLabel];
    [countDownTimeLabel setTextColor:RGB(88,79,96)];
    [countDownTimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(bgImageView);
        make.centerY.mas_equalTo(bgImageView).offset(-K_HEIGHT_TABBAR/3*2);
        make.size.mas_equalTo(CGSizeMake(250, 55));
    }];
    self.countDownTimeLabel = countDownTimeLabel;
    
    UILabel *hintLabel = [[UILabel alloc]init];
    [hintLabel setText:@"充电中"];
    hintLabel.font = PFR20Font;
    [hintLabel setTextColor:RGB(88,79,96)];
    [infoView addSubview:hintLabel];
    hintLabel.textAlignment = NSTextAlignmentCenter;
    [hintLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(countDownTimeLabel.mas_top).offset(-15);
        make.centerX.equalTo(countDownTimeLabel);
        make.size.mas_equalTo(CGSizeMake(90, 25));
    }];
    
    UIButton *endChargingBtn = [[UIButton alloc]init];
    [infoView addSubview:endChargingBtn];
    [endChargingBtn setBackgroundImage:[UIImage imageNamed:@"btn_1"] forState:UIControlStateNormal];
    [endChargingBtn setTitle:@"结束充电" forState:UIControlStateNormal];
    [endChargingBtn addTarget:self action:@selector(initAlertView) forControlEvents:UIControlEventTouchUpInside];
    [endChargingBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(countDownTimeLabel.mas_bottom).offset(15);
        make.centerX.equalTo(bgImageView);
        make.size.mas_equalTo(CGSizeMake(190, 47));
    }];
}

- (void)updataUI{
//    if ([[DCObjManager dc_readUserDataForKey:@"isWorking"] intValue] == 1) {
//        self.infoView.hidden = false;
//    }else{
    [self.infoView setHidden:true];
    [self.plusButton setSelected:false];
//    }
    if (![[DCObjManager dc_readUserDataForKey:@"isLogin"] isEqualToString:@"1"]) {
//        self.plusButton.selected = false;
        [self.plusButton setImage:SETIMAGE(@"nav_btn_scavenging_charging_normal_2") forState:UIControlStateNormal];
    }else{
//        self.plusButton.selected = true;
        [self.plusButton setImage:SETIMAGE(@"nav_btn_scavenging_charging_normal") forState:UIControlStateNormal];
    }
}



-(void)getDatasViewDidLoading{
    //登录成功
    if ([[DCObjManager dc_readUserDataForKey:@"isLogin"] isEqualToString:@"1"]) {
        [self requestData];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self requestData2];
        });
    } else {
        return;
    }
}
//查询用户状态
-(void)requestData{
    WEAKSELF
    NSString *cookid = [DCObjManager dc_readUserDataForKey:@"key"];
    if (cookid) {
        [GCHttpDataTool cxChargingLineStatusWithDict:nil success:^(id responseObject) {
            [SVProgressHUD dismiss];
            //            [SVProgressHUD showSuccessWithStatus:@"查询用户状态成功！"];
//            {
//                "type" : "-3",
//                "userid" : "ca9899ae7c5b4d1e94d1e48957fac063"
//            }
//            {
//                "userid" : "ca9899ae7c5b4d1e94d1e48957fac063",
//                "notice" : false,
//                "time" : 26058,
//                "cabid" : "4e3937313233341315323137",
//                "expirecount" : 1,
//                "devid" : "0201810061400016",
//                "type" : "-1"
//            }
            switch ([responseObject[@"type"] intValue]) {
                case 0: //允许租借状态
                    [self.infoView setHidden:true];
                    
                    break;
                case -1: //已租借充电线 不允许租借
                    
                    [self.infoView setHidden:false];
                    [self.plusButton setSelected:true];
                    self.devid = responseObject[@"devid"];
                    self.cabid = responseObject[@"cabid"];
                    if (![[self.totalData allKeys] containsObject:@"devid"] || ![[self.totalData allKeys] containsObject:@"devid"]) {
                        [self.totalData setValue:responseObject[@"devid"] forKey:@"devid"];
                        [self.totalData setValue:responseObject[@"cabid"] forKey:@"cabid"];
                    }
                    //获取当前加载时间
                    int totalTimeBySeconds = [responseObject[@"time"] intValue]/1000;
//                    totalTimeBySeconds = [htmlString intValue]/100;
                    self.hours =  totalTimeBySeconds/3600;
                    //format of minute
                    self.minutes = (totalTimeBySeconds%3600)/60;
                    //format of second
                    self.seconds =  totalTimeBySeconds%60-0.5;
                    //
                    //            self.minutes = 0;
                    //            self.hours = 0;
                    //            self.seconds = 0;
                    //类方法会自动释放。
                    //类方法会自动释放。
                    weakSelf.timer = [NSTimer scheduledTimerWithTimeInterval:1 target:weakSelf selector:@selector(startRecordTime) userInfo:nil repeats:YES];
                    //⏳倒计时处理 开始
                    
                    break;
                case -3: //余额不足
                    [self.infoView setHidden:true];
                    
                    
                    break;
                    
                default:
                    break;
            }
            
            
            
        } failure:^(MQError *error) {
            [SVProgressHUD showErrorWithStatus:error.msg];
        }];
        NSLog(@"《冲哈哈》获取用户cookid成功");
    }else{
        //        [SVProgressHUD showErrorWithStatus:@"cookid is null"];
        NSLog(@"❌❌获取用户cookid失败❌❌");
        return;
    }
}
//用户信息查询
-(void)requestData2{
    NSString *cookid = [DCObjManager dc_readUserDataForKey:@"key"];
    if (cookid) {
        [GCHttpDataTool getUserInfoWithDict:nil success:^(id responseObject) {
            [SVProgressHUD dismiss];
//            [SVProgressHUD showSuccessWithStatus:@"查询用户状态成功！"];
//            {
//                "result" : false,
//                "expireday" : "0",
//                "phone" : "18577986175",
//                "freestr" : "0",
//                "balance" : -18
//            }
//            {
//                "result" : true,
//                "expireday" : "0",
//                "phone" : "18577986175",
//                "freestr" : "0",
//                "balance" : -18
//            }
            
            
            
        } failure:^(MQError *error) {
            [SVProgressHUD showErrorWithStatus:error.msg];
        }];
        NSLog(@"《冲哈哈》获取用户cookid成功");
    }else{
        //        [SVProgressHUD showErrorWithStatus:@"cookid is null"];
        NSLog(@"❌❌获取用户cookid失败❌❌");
        return;
    }
}

- (void)getData{
    
}

//获取轮播图
-(void)loadSubjectImage{
//    NSString *url = [NSString stringWithFormat:@"%@%@",Base_Url,@"/controller/api/WeclomeImage.php"];
//    NSMutableDictionary *para = [NSMutableDictionary dictionary];
//    para[@"key"] = AppKey;
//    para[@"size"] = @"5";
//    [SVProgressHUD showWithStatus:@"正在获取图片"];
//    [AFNetPackage getJSONWithUrl:url parameters:para success:^(id responseObject) {
//        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:nil];
//        if ([dic[@"code"] integerValue] == 200) {
//            [SVProgressHUD dismiss];
//            NSArray *array = dic[@"data"];
//            for (NSDictionary *dic in array) {
//                [self.images addObject:[NSString stringWithFormat:@"%@%@%@",Base_Url,@"/",dic[@"image"]]];
//            }
//            self.advertiseView.imageURLStringsGroup = self.images;
//        }
//    } fail:^{
//        [SVProgressHUD dismiss];
//        for (NSInteger i = 1; i <= 3; ++i) {
//            UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"adView%ld",(long)i]];
//            [self.images addObject:image];
//        }
//        self.advertiseView.localizationImageNamesGroup = self.images;
//    }];
    
    for (NSInteger i = 1; i <= 1; ++i) {
//        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"chonhaha_banner%ld",(long)i]];
        UIImage *image = [UIImage imageNamed:@"banner_first_charge"];
        [self.images addObject:image];
    }
    self.advertiseView.localizationImageNamesGroup = self.images;
    
}

#pragma mark - UIScrollViewDelegate
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    CGPoint point = scrollView.contentOffset;
    if (scrollView.contentOffset.y > ScreenH-HeaderImageHeight-64-50) {
//        [self.view addSubview:self.topButton];
    }else{
//        [self.topButton removeFromSuperview];
    }
    if (point.y < 0) {
        CGRect rect = [self.view viewWithTag:101].frame;
        rect.origin.y = point.y;
        rect.size.height = -point.y;
        [self.view viewWithTag:101].frame = rect;
    }
}

#pragma mark - private method
- (void)pushToPersonalCenter{
    GKPersonalCenterViewController *personalVC = [GKPersonalCenterViewController new];
    [self.navigationController pushViewController:personalVC animated:YES];
}

- (void)scanQRCode{
    if ([self checkLoginStatus]) {
        return;
    }
    if ([self.plusButton isSelected]) {
        GKStartChargingViewController *vc = [[GKStartChargingViewController alloc]init];
        vc.hasBeenCharging = true;
        [self.navigationController pushViewController:vc animated:YES];
    }else{
        DCGMScanViewController *dcGMvC = [DCGMScanViewController new];
        //    UINavigationController *newNaVC = [[UINavigationController alloc]initWithRootViewController:dcGMvC];
        [self.navigationController pushViewController:dcGMvC animated:YES];
        //    [DCObjManager dc_saveUserData:@"1" forKey:@"isWorking"];
    }
    
    
}

-(void)pickCity{
    if ([self checkLoginStatus]) {
        return;
    }
    JFCityViewController *cityViewController = [[JFCityViewController alloc] init];
    cityViewController.title = @"城市";
    [self.navigationController pushViewController:cityViewController animated:YES];
    /*
     WEAKSELF
    //获取城市列表
    NSString *cookid = [DCObjManager dc_readUserDataForKey:@"key"];
    if (cookid) {
//        NSDictionary *dict=@{
//                         @"condition":@"贵阳"
//                         };
        [GCHttpDataTool getCityListWithDict:nil success:^(id responseObject) {
            [SVProgressHUD dismiss];
//            [SVProgressHUD showSuccessWithStatus:@"获取城市列表成功！"];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                JFCityViewController *cityViewController = [[JFCityViewController alloc] init];
                cityViewController.title = @"城市";
                [cityViewController choseCityBlock:^(NSString *cityName) {
                    weakSelf.cityName = cityName;
                    //        [ProjectUtil saveCityName:cityName];
                    //        [weakSelf updateLeftBarButtonItem];
                    //        [self preData];//获取数据
                    [weakSelf.cityNameBtn setTitle:self.cityName forState:UIControlStateNormal];
                }];
                //    GKNavigationController *navigationController = [[GKNavigationController alloc] initWithRootViewController:cityViewController];
                [self.navigationController pushViewController:cityViewController animated:YES];
                //    [self presentViewController:navigationController animated:YES completion:^{
                //        self.isPickedCity = YES;
                //    }];
            });
        } failure:^(MQError *error) {
            [SVProgressHUD showErrorWithStatus:error.msg];
        }];
    }else{
        return;
    }
     */
}

- (void)turnToBusInfoList{
    if ([self checkLoginStatus]) {
        return;
    }
    GKBusInfoListViewController *vc = [GKBusInfoListViewController new];
//    HotelEvaluateVC *vc = [HotelEvaluateVC new];
    vc.title = @"车辆信息";
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)orderInfoBtnAction{
    if ([self checkLoginStatus]) {
        return;
    }
    //跳转至订单管理页面
    [self.navigationController pushViewController:[GKOrderManagementViewController new] animated:YES];
}

-(void)clickContactPhone{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:TelePhoneNumber message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *cancle = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        return;
    }];
    UIAlertAction *tel = [UIAlertAction actionWithTitle:@"呼叫" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        NSMutableString * telUrl = [[NSMutableString alloc] initWithFormat:@"telprompt://%@",TelePhoneNumber];
        
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:telUrl]];
    }];
    //修改title字体及颜色
    NSMutableAttributedString *titleStr = [[NSMutableAttributedString alloc] initWithString:TelePhoneNumber];
    [titleStr addAttribute:NSForegroundColorAttributeName value:TEXTMAINCOLOR range:NSMakeRange(0, titleStr.length)];
    [titleStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:18] range:NSMakeRange(0, titleStr.length)];
    [alert setValue:titleStr forKey:@"attributedTitle"];
    // 修改message字体及颜色
//    NSMutableAttributedString *messageStr = [[NSMutableAttributedString alloc] initWithString:@"此处展示提示消息"];
//    NSMutableAttributedString *messageStr = [[NSMutableAttributedString alloc] initWithString:@""];
//    [messageStr addAttribute:NSForegroundColorAttributeName value:[UIColor purpleColor] range:NSMakeRange(0, messageStr.length)];
//    [messageStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:14] range:NSMakeRange(0, messageStr.length)];
//    [alert setValue:messageStr forKey:@"attributedMessage"];
    
//    [alert setValue:TEXTMAINCOLOR forKey:@"_titleTextColor"];
    [cancle setValue:BUTTONMAINCOLOR forKey:@"_titleTextColor"];
    [tel setValue:BUTTONMAINCOLOR forKey:@"_titleTextColor"];
    [alert addAction:tel];
    [alert addAction:cancle];
    [self presentViewController:alert animated:YES completion:^{
        
    }];
}

- (void)initAlertView{
    SIAlertView *alertView = [[SIAlertView alloc] initWithTitle:@"     " andMessage:@"是否归还充电宝?"];
    [alertView addButtonWithTitle:@"结束充电"
                             type:SIAlertViewButtonTypeDefault
                          handler:^(SIAlertView *alertView) {
                              [alertView dismissAnimated:NO];
                              [self endOfTheCharging];
                              
                          }];
    
    [alertView addButtonWithTitle:@"继续充电"
                             type:SIAlertViewButtonTypeDestructive
                          handler:^(SIAlertView *alertView) {
                              
                              [alertView dismissAnimated:NO];
                              
                          }];
    
    [alertView show];
}

- (void)endOfTheCharging{
    SIAlertView *alertView = [[SIAlertView alloc] initWithTitle:@"     " andMessage:@"检测到您还有正在充电的设备，\n是否立即结束充电?"];
    [alertView addButtonWithTitle:@"结束充电"
                             type:SIAlertViewButtonTypeDefault
                          handler:^(SIAlertView *alertView) {
                              [alertView dismissAnimated:NO];
                              [self endOfTheChargingSure];
                          }];
    
    [alertView addButtonWithTitle:@"继续充电"
                             type:SIAlertViewButtonTypeDestructive
                          handler:^(SIAlertView *alertView) {
                              
                              [alertView dismissAnimated:NO];
                              
                          }];
    
    [alertView show];
}


-(void)endOfTheChargingSure{
    
    [SVProgressHUD showWithStatus:@"正在结束充电中，请稍后...\n请勿退出或关闭"];
    NSString *cookid = [DCObjManager dc_readUserDataForKey:@"key"];
    if (cookid) {
        NSDictionary *dict=@{
                             @"devid":self.totalData[@"devid"],
                             @"cabid":self.totalData[@"cabid"],
                             };
        [GCHttpDataTool returnChargingLineWithDict:dict success:^(id responseObject) {
            [SVProgressHUD dismiss];
            [SVProgressHUD showSuccessWithStatus:@"结束成功！"];
            [self updataUI];
            [self setUpContentView];
        } failure:^(MQError *error) {
            [SVProgressHUD showErrorWithStatus:error.msg];
            [self againAndOfTheCharging];
        }];
        NSLog(@"《冲哈哈》获取用户cookid成功");
    }else{
        //        [SVProgressHUD showErrorWithStatus:@"cookid is null"];
        NSLog(@"❌❌获取用户cookid失败❌❌");
        return;
    }
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        [SVProgressHUD dismiss];
//        SIAlertView *alertView = [[SIAlertView alloc] initWithTitle:@"     " andMessage:@"网络出问题\n结束充电失败"];
//        [alertView addButtonWithTitle:@"返回"
//                                 type:SIAlertViewButtonTypeDefault
//                              handler:^(SIAlertView *alertView) {
//                                  [alertView dismissAnimated:NO];
//
//                              }];
//
//        [alertView addButtonWithTitle:@"再次停止"
//                                 type:SIAlertViewButtonTypeDestructive
//                              handler:^(SIAlertView *alertView) {
//                                  [alertView dismissAnimated:NO];
//                                  [self againAndOfTheCharging];
//                              }];
//        [alertView show];
//    });
}

-(void)againAndOfTheCharging{
    [SVProgressHUD showWithStatus:@"正在结束充电中，请稍后...\n请勿退出或关闭"];
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        [SVProgressHUD dismiss];
////        [DCObjManager dc_saveUserData:@"0" forKey:@"isWorking"];
//        [self updataUI];
//        [SVProgressHUD showSuccessWithStatus:@"结束成功！"];
//        //弹窗评价窗口
//        [self setUpContentView];
//    });
    
    NSString *cookid = [DCObjManager dc_readUserDataForKey:@"key"];
    if (cookid) {
        NSDictionary *dict=@{
                             @"devid":self.devid,
                             @"cabid":self.cabid,
                             };
        [GCHttpDataTool returnChargingLineWithDict:dict success:^(id responseObject) {
            [SVProgressHUD dismiss];
            [SVProgressHUD showSuccessWithStatus:@"结束成功！"];
            [self updataUI];
            [self setUpContentView];
        } failure:^(MQError *error) {
            [SVProgressHUD showErrorWithStatus:error.msg];
            [self againAndOfTheCharging];
        }];
        NSLog(@"《冲哈哈》获取用户cookid成功");
    }else{
        //        [SVProgressHUD showErrorWithStatus:@"cookid is null"];
        NSLog(@"❌❌获取用户cookid失败❌❌");
        return;
    }
    
    
    /*
    NSString *cookid = [DCObjManager dc_readUserDataForKey:@"key"];
    if (cookid) {
//        ordernum： 必填  订单号
//        comments： 必填  评论内容
//        score： 必填  分数 默认1-5
        NSDictionary *dict=@{
                             @"ordernum":@"1181012182203000001",
                             @"comments":@"这是【 评价订单】测试内容！",
                             @"score":@"2"
                             };
        [GCHttpDataTool orderEvaluateWithDict:dict success:^(id responseObject) {
            [SVProgressHUD dismiss];
            [SVProgressHUD showSuccessWithStatus:@"【 评价订单】成功！"];
        } failure:^(MQError *error) {
            [SVProgressHUD showErrorWithStatus:error.msg];
        }];
        NSLog(@"《冲哈哈》获取用户cookid成功");
    }else{
        //        [SVProgressHUD showErrorWithStatus:@"cookid is null"];
        NSLog(@"❌❌获取用户cookid失败❌❌");
        return;
    }
    */
}

#pragma mark - 内容
- (void)setUpContentView{
    //跳转至评价页面
    [self.navigationController pushViewController:[GKEvaluateViewController new] animated:YES];
}

- (void)setUpContentView2
{
    // 大背景
    UIView *bgView = [[UIView alloc] init];
    [[[[UIApplication sharedApplication] delegate] window] addSubview:bgView];
    bgView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.4];
    [bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsMake(0, 0, 0, 0));
    }];
    self.bgView = bgView;
    UIView *bgHeaderView = [[UIView alloc] init];
    [self.bgView addSubview:bgHeaderView];
//    bgHeaderView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.4];
    bgHeaderView.frame = CGRectMake(0,0, ScreenW, (ScreenH-K_HEIGHT_NAVBAR)/2+K_HEIGHT_NAVBAR);
    self.bgHeaderView = bgHeaderView;
    
    [self setKeyBoardListener];
    //整体的布局view
//    GKSignInCodeView *totalView = [GKSignInCodeView new];
//    [bgView addSubview:totalView];
//    [totalView setBackgroundColor:[UIColor whiteColor]];
//    [totalView mas_updateConstraints:^(MASConstraintMaker *make) {
//        make.centerX.mas_equalTo(bgView);
//        make.centerY.mas_equalTo(bgView).mas_offset(0);
//        make.left.mas_equalTo(bgView.mas_left).with.offset(ScreenW/10);
//        make.right.mas_equalTo(bgView.mas_right).with.offset(-ScreenW/10);
//        make.height.mas_equalTo(totalView.mas_width);
//        //make.width.mas_equalTo(200);
//    }];
//    [totalView.cancelButton addTarget:self action:@selector(close) forControlEvents:UIControlEventTouchUpInside];
//    totalView.layer.masksToBounds = YES;
//    totalView.layer.cornerRadius = 8;
//    self.signInCodeView = totalView;
//
    _priceEvaluationView = [GKPriceEvaluationView dc_viewFromXib];
    [self.bgView addSubview:_priceEvaluationView];
    _priceEvaluationView.frame = CGRectMake(0, (ScreenH-K_HEIGHT_NAVBAR)/2+K_HEIGHT_NAVBAR, ScreenW, (ScreenH-K_HEIGHT_NAVBAR)/2);
//    _priceEvaluationView.starIsChanged
    
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark -页面逻辑方法
- (void) addObserver
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(starIsChangedAction) name:@"starIsChanged" object:nil];
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(close) name:@"close" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(cheackDetailsAction) name:@"cheackDetails" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(qrCodeSuccessAction:) name:@"QRCodeSuccess" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(chargeSuccessAction:) name:@"租电成功" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loginSuccessAction:) name:LOGINSELECTCENTERINDEX object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updataUI) name:@"EndCharging" object:nil];
}

- (void)starIsChangedAction{
//    [_priceEvaluationView setHidden:true];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        [SVProgressHUD dismiss];
        CGFloat actualScore = self.priceEvaluationView.actualScore;
        [self.priceEvaluationView removeFromSuperview];
        self.starAndLabellingEvaluationView = [GKStarAndLabellingEvaluationView dc_viewFromXib];
        self.starAndLabellingEvaluationView.actualScore = actualScore;
//        [SVProgressHUD showInfoWithStatus:[NSString stringWithFormat:@"%f",actualScore]];
        [self.bgView addSubview:self.starAndLabellingEvaluationView];
        self.starAndLabellingEvaluationView.frame = CGRectMake(0, (ScreenH-K_HEIGHT_NAVBAR)/2+K_HEIGHT_NAVBAR+40, ScreenW, (ScreenH-K_HEIGHT_NAVBAR)/2-40);
        self.starAndLabellingEvaluationView.starView.actualScore = actualScore;
    });
}

-(void)cheackDetailsAction{
    [self close];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.navigationController pushViewController:[GKOrderDetailsViewController new] animated:YES];
    });
}

-(void)close{
    [self.bgView removeFromSuperview];
}
//点击空白处的点击事件
/**
 *  @author 洛忆, 18-10-12 18:09:58
 *
 *  给当前view添加手势识别
 */
- (void)setKeyBoardListener
{
    UITapGestureRecognizer *recognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(screenClick)];
    [self.bgHeaderView addGestureRecognizer:recognizer];
}

/**
 *  @author 洛忆, 18-10-12 18:09:32
 *
 *  点击屏幕预备 removeFromSuperview
 */
- (void)screenClick
{
    //    [SVProgressHUD showInfoWithStatus:@"您点击了 bgView!"];
    //    [self.view endEditing:YES];
    [self initAlertView2];
}

- (void)initAlertView2{
    SIAlertView *alertView = [[SIAlertView alloc] initWithTitle:@"     " andMessage:@"是否退出评价?"];
    [alertView addButtonWithTitle:@"结束评价"
                             type:SIAlertViewButtonTypeDefault
                          handler:^(SIAlertView *alertView) {
                              [alertView dismissAnimated:NO];
                              [self endOfTheEvaluate];
                              
                          }];
    
    [alertView addButtonWithTitle:@"继续评价"
                             type:SIAlertViewButtonTypeDestructive
                          handler:^(SIAlertView *alertView) {
                              
                              [alertView dismissAnimated:NO];
                              
                          }];
    [alertView show];
}

- (void)endOfTheEvaluate{
    [self close];
}

- (void)qrCodeSuccessAction:(NSNotification *)noti{
    if ([self checkLoginStatus]) {
        return;
    }
    NSMutableDictionary *totalData = [noti userInfo];
    self.totalData = totalData;
    [SVProgressHUD showWithStatus:@"正在跳转\n请稍后。。。"];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [SVProgressHUD dismiss];
        GKStartChargingViewController *vc = [[GKStartChargingViewController alloc]init];
        vc.hasBeenCharging = false;
        vc.totalData = totalData;
        [self.navigationController pushViewController:vc animated:YES];
    });
}

-(void)chargeSuccessAction:(NSNotification *)noti{
//    NSDictionary *totalData = [noti userInfo];
    //收到通知
    [self requestData];
    return;
}

-(void)loginSuccessAction:(NSNotification *)noti{
    //隐藏登录提示窗口
    [self.loginNotiView setHidden:true];
    //收到通知，查询用户状态
    [self requestData];
    return;
}


-(NSMutableArray *)images{
    if (!_images) {
        _images = [NSMutableArray array];
    }
    return _images;
}
//-(UIView *)bgView{
//    if (!_bgView) {
//        _bgView = [[UIView alloc]init];
//        [[[[UIApplication sharedApplication] delegate] window] addSubview:_bgView];
//        _bgView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.4];
//        [_bgView mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.edges.mas_equalTo(UIEdgeInsetsMake(0, 0, 0, 0));
//        }];
//    }
//    return _bgView;
//}
-(SDCycleScrollView *)advertiseView{
    if (!_advertiseView) {
        SDCycleScrollView *adview = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, ScreenW, HeaderImageHeight) delegate:self placeholderImage:[UIImage imageNamed:@"placeholder"]];
        adview.pageControlAliment = SDCycleScrollViewPageContolAlimentCenter;
        adview.currentPageDotColor = [UIColor whiteColor];
//        adview.originY = 170;
        adview.tag = 101;
//        adview.mode = UIViewContentModeScaleAspectFill;
        _advertiseView = adview;
    }
    return _advertiseView;
}

-(Boolean)checkLoginStatus{
    
    
    //    [self.navigationController pushViewController:[GKUseGuideViewController new] animated:YES];
    //    return true;
//    [self.navigationController pushViewController:[GKReturnGuideViewController new] animated:YES];
//    return true;

    //判断是否登录状态
    if (![[DCObjManager dc_readUserDataForKey:@"isLogin"] isEqualToString:@"1"]) {
        GKLoginViewController *VC=[[GKLoginViewController alloc]init];
        UINavigationController *nav=[[UINavigationController alloc]initWithRootViewController:VC];
        [self presentViewController:nav animated:YES completion:nil];
        return true;
    } else {
        return false;
    }
}


#pragma mark -时间记录器
//nwDispatchTimer;
-(void)startTimer{
    _seconds++;
    //没过１００毫秒，就让秒＋１，然后让毫秒在归零
    if(_seconds==60){
        _minutes++;
        _seconds = 0;
    }
    if (_minutes == 60) {
        _hours++;
        _minutes = 0;
    }
    if (_seconds%2 !=0) {
//        self.redDView.hidden = YES;
    }else{
//        self.redDView.hidden = NO;
    }
    //让不断变量的时间数据进行显示到label上面。
    self.countDownTimeLabel.text = [NSString stringWithFormat:@"%02d:%02d:%02d",_hours,_minutes,_seconds];
}

-(void)startRecordTime{
    _seconds++;
    //没过１００毫秒，就让秒＋１，然后让毫秒在归零
    if(_seconds==60){
        _minutes++;
        _seconds = 0;
    }
    if (_minutes == 60) {
        _hours++;
        _minutes = 0;
    }
    //让不断变量的时间数据进行显示到label上面。
    self.countDownTimeLabel.text = [NSString stringWithFormat:@"%02d:%02d:%02d",_hours,_minutes,_seconds];
    
}

@end
