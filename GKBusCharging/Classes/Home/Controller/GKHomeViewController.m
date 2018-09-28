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


//#import "DCTabBarController.h"
#import "DCRegisteredViewController.h"
// Models

// Views
#import "DCAccountPsdView.h" //账号密码登录
#import "DCVerificationView.h" //验证码登录
#import "GKUpDownButton.h"
#import "DCZuoWenRightButton.h"
#import "DCLIRLButton.h"
// Vendors

// Categories

// Others
#import "AFNetPackage.h"



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

/* 验证码 */
@property (strong , nonatomic)DCVerificationView *verificationView;
/* 账号密码登录 */
@property (strong , nonatomic)DCAccountPsdView *accountPsdView;

@property (nonatomic, strong) SDCycleScrollView *advertiseView;

@property (nonatomic,strong) NSString *cityName;

@property (nonatomic,strong) UIButton *cityNameBtn;

@property (nonatomic,strong) UIButton *busListBtn;

@property (nonatomic, strong) NSMutableArray *images;

@end

@implementation GKHomeViewController

- (void)viewDidLoad {
    self.cityName = @"佛山市";
    [super viewDidLoad];
    
    [self setUpNavBarView];
    
    [self setUI];
    
    [self setUpTabBarView];
    
    [self getData];
    
    [self loadSubjectImage];
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
    DCZuoWenRightButton *cityNameBtn = [DCZuoWenRightButton buttonWithType:UIButtonTypeRoundedRect];
    [cityNameBtn setImage:SETIMAGE(@"iocn_place_pull_down") forState:0];
    // 设置图标
    [cityNameBtn setTitle:self.cityName forState:UIControlStateNormal];
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
    [self.busListBtn addTarget:self action:@selector(turnToBusList) forControlEvents:UIControlEventTouchUpInside];
    
    //搜索栏
    UIView *topSearchView = [[UIView alloc] init];
    topSearchView.backgroundColor = RGB(248, 248, 248);
    topSearchView.layer.cornerRadius = 16;
    [topSearchView.layer masksToBounds];
    [topView addSubview:topSearchView];
    
    [topSearchView mas_makeConstraints:^(MASConstraintMaker *make) {
        [make.left.mas_equalTo(self.cityNameBtn.mas_right)setOffset:3];
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
    [searchButton addTarget:self action:@selector(turnToBusList) forControlEvents:UIControlEventTouchUpInside];
    
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
    self.title = @"冲哈哈😆";
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
    [uiView setBackgroundColor:RGB(244, 244, 244)];
    [self.view addSubview:uiView];
    [uiView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view);
        make.top.mas_equalTo(adView.mas_bottom).offset(0);
        make.height.mas_equalTo(DCNaviH/3);
        make.width.equalTo(self.view);
    }];
    //信息视图
    UIView *infoView = [[UIView alloc]init];
    [infoView setBackgroundColor:[UIColor yellowColor]];
    [self.view addSubview:infoView];
    [infoView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view);
//        make.top.mas_equalTo(self.view).with.offset(K_HEIGHT_NAVBAR+DCNaviH+ScreenW/2+DCNaviH/2);
//        make.top.mas_equalTo(adView).offset(DCNaviH/3);
        make.top.mas_equalTo(uiView.mas_bottom).offset(0);
        make.height.mas_equalTo(ScreenH - (K_HEIGHT_NAVBAR+DCNaviH+ScreenW/2+DCNaviH/2) - K_HEIGHT_TABBAR);
        make.width.equalTo(self.view);
    }];
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
    DCZuoWenRightButton *orderInfoBtn = [DCZuoWenRightButton new];
    [orderInfoBtn setImage:SETIMAGE(@"home_icon_page_more") forState:0];
    //设置图标
    [orderInfoBtn setTitle:@"订单详情" forState:UIControlStateNormal];
    [orderInfoBtn setTitleColor:RGB(88, 79, 96) forState:UIControlStateNormal];
    orderInfoBtn.titleLabel.font = PFR15Font;
    
    
//    [orderInfoBtn setTitleEdgeInsets:UIEdgeInsetsMake(0, orderInfoBtn.imageView.dc_width, 0, orderInfoBtn.imageView.dc_width)];
//    [orderInfoBtn setImageEdgeInsets:UIEdgeInsetsMake(0, orderInfoBtn.titleLabel.bounds.size.width, 0, -orderInfoBtn.titleLabel.bounds.size.width)];

//    CGFloat imageWidth = orderInfoBtn.imageView.bounds.size.width;
//    CGFloat labelWidth = orderInfoBtn.titleLabel.bounds.size.width;
//    orderInfoBtn.imageEdgeInsets = UIEdgeInsetsMake(0, labelWidth, 0, -labelWidth);
//    orderInfoBtn.titleEdgeInsets = UIEdgeInsetsMake(0, -imageWidth, 0, imageWidth);
    
    
    // button标题的偏移量
//    orderInfoBtn.titleEdgeInsets = UIEdgeInsetsMake(0, -orderInfoBtn.imageView.bounds.size.width+2, 0, orderInfoBtn.imageView.bounds.size.width);
    // button图片的偏移量
//    orderInfoBtn.imageEdgeInsets = UIEdgeInsetsMake(0, orderInfoBtn.titleLabel.bounds.size.width, 0, -orderInfoBtn.titleLabel.bounds.size.width);
    
    
    
//    orderInfoBtn.imageEdgeInsets = UIEdgeInsetsMake(0, labelWidth, 0, -labelWidth);
//    orderInfoBtn.titleEdgeInsets = UIEdgeInsetsMake(0, -imageWidth, 0, imageWidth);

//    orderInfoBtn.showsTouchWhenHighlighted = YES;
//    orderInfoBtn.contentEdgeInsets = UIEdgeInsetsMake(0, -5, 0, 0);
//    // 重点位置开始
//    orderInfoBtn.imageEdgeInsets = UIEdgeInsetsMake(0, orderInfoBtn.titleLabel.dc_width + 2.5, 0, -orderInfoBtn.titleLabel.dc_width - 2.5);
//    orderInfoBtn.titleEdgeInsets = UIEdgeInsetsMake(0, -orderInfoBtn.currentImage.size.width, 0, orderInfoBtn.currentImage.size.width);
//    // 重点位置结束
//    orderInfoBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [orderInfoBtn addTarget:self action:@selector(turnToBusList) forControlEvents:UIControlEventTouchUpInside];
    [topView addSubview:orderInfoBtn];
    [orderInfoBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(topView.mas_right).offset(-5);
//        make.centerY.equalTo(topView);
//        make.centerY.equalTo(myLabel);
        make.bottom.mas_equalTo(topView.mas_bottom).offset(-15);
//        make.top.mas_equalTo(topView.mas_top).offset(10);
        make.height.equalTo(@22);
        make.width.equalTo(@90);
    }];
    
    
    
    
    
    
    //背景花纹图
    UIImageView *bgImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"home_page_Charging_bg"]];
    [infoView addSubview:bgImageView];
    [bgImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(infoView);
        make.centerY.mas_equalTo(infoView.dc_centerY+DCNaviH/2);
        make.top.mas_equalTo(infoView).offset(DCNaviH);
    }];
    
}

- (void)getData{
    
}

//获取轮播图
-(void)loadSubjectImage{
    NSString *url = [NSString stringWithFormat:@"%@%@",Base_Url,@"/controller/api/WeclomeImage.php"];
    NSMutableDictionary *para = [NSMutableDictionary dictionary];
    para[@"key"] = AppKey;
    para[@"size"] = @"5";
    [SVProgressHUD showWithStatus:@"正在获取图片"];
    [AFNetPackage getJSONWithUrl:url parameters:para success:^(id responseObject) {
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:nil];
        if ([dic[@"code"] integerValue] == 200) {
            [SVProgressHUD dismiss];
            NSArray *array = dic[@"data"];
            for (NSDictionary *dic in array) {
                [self.images addObject:[NSString stringWithFormat:@"%@%@%@",Base_Url,@"/",dic[@"image"]]];
            }
            self.advertiseView.imageURLStringsGroup = self.images;
        }
    } fail:^{
        [SVProgressHUD dismiss];
        for (NSInteger i = 1; i <= 3; ++i) {
            UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"adView%ld",(long)i]];
            [self.images addObject:image];
        }
        self.advertiseView.localizationImageNamesGroup = self.images;
    }];
    
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
    DCGMScanViewController *dcGMvC = [DCGMScanViewController new];
    [self.navigationController pushViewController:dcGMvC animated:YES];
}


-(void)pickCity{
    WEAKSELF
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
}

- (void)turnToBusList{
    GKBaseSetViewController *vc = [GKBaseSetViewController new];
    vc.title = @"new";
    [self.navigationController pushViewController:vc animated:YES];
}

-(void)clickContactPhone{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"拨打客服电话" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    UIAlertAction *tel = [UIAlertAction actionWithTitle:TelePhoneNumber style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        NSMutableString * telUrl = [[NSMutableString alloc] initWithFormat:@"telprompt://%@",TelePhoneNumber];
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:telUrl]];
    }];
    
    [alert addAction:tel];
    [alert addAction:cancel];
    [self presentViewController:alert animated:YES completion:^{
        
    }];
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





-(NSMutableArray *)images{
    if (!_images) {
        _images = [NSMutableArray array];
    }
    return _images;
}

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
@end
