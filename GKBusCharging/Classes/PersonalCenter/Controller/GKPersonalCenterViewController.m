//
//  GKPersonalCenterViewController.m
//  GKBusCharging
//
//  Created by 王宁 on 2018/9/28.
//  Copyright © 2018年 goockr. All rights reserved.
//

#import "GKPersonalCenterViewController.h"

//#import "AppDelegate.h"
// Controllers
#import "GKNavigationController.h"
#import "DCGMScanViewController.h"
#import "JFCityViewController.h"
#import "SDCycleScrollView.h"
#import "GKFeedBackViewController.h"
#import "GKMeViewController.h"
#import "GKBindingPhoneController.h"
#import "GKLoginViewController.h"
#import "GKBalanceViewController.h"
#import "GKAboutUsViewController.h"
#import "GKOrderManagementViewController.h"
#import "GKUseingHelpViewController.h"
#import "GKEvaluateViewController.h"
#import "GKStartChargingViewController.h"
//#import "DCTabBarController.h"
////#import "DCRegisteredViewController.h"
// Models

// Views
 //#import "DCAccountPsdView.h" //账号密码登录
//#import "DCVerificationView.h" //验证码登录
#import "GKPersonalHeaderView.h"
#import "GKCustomFlowLayout.h"
#import "GKPersonalCell.h"
#import "IFMShareView.h"
// Vendors

// Categories

#import "GKUpDownButton.h"
#import "DCZuoWenRightButton.h"
// Others
//#import "AFNetPackage.h"

#define HeaderImageHeight ScreenW/2

#define kLineSpacing DCMargin/2

@interface GKPersonalCenterViewController ()<UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>
//{
//    UICollectionView *collectionView;
//}



@property (nonatomic,strong) NSMutableArray *titleListArray;

@property (nonatomic,strong) NSMutableArray *imagesListArray;

@property (retain, strong) GKPersonalHeaderView *headerView;

@property (retain, strong) UILabel *headTitleLabel;

@property (nonatomic,strong) UICollectionView *collectionView;
/**
 分享 View
 */
@property(nonatomic, strong) NSMutableArray *shareArray;
@property(nonatomic, strong) NSMutableArray *functionArray;
/**
 应用更新
 */
@property (nonatomic,strong) NSString *trackViewUrl;
@end

@implementation GKPersonalCenterViewController
#pragma mark - LazyLoad

- (void)loadCollectionView
{
    
    /**
     创建layout
     */
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    /**
     创建collectionView
     */
    UICollectionView* collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 64, ScreenW, ScreenH-64) collectionViewLayout:layout];
    collectionView.delegate = self;
    collectionView.dataSource = self;
    collectionView.backgroundColor = [UIColor cyanColor];
    /**
     注册item和区头视图、区尾视图
     */
    [collectionView registerClass:[GKPersonalCell class] forCellWithReuseIdentifier:@"GKPersonalCell"];
//    [collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"MyCollectionViewHeaderView"];
//    [collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"MyCollectionViewFooterView"];
    [self.view addSubview:collectionView];
//    [collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
////        make.top.mas_equalTo(headerView.mas_bottom).with.offset(FixHeightNumber(10));
//        make.top.mas_equalTo(self.view).with.offset(K_HEIGHT_NAVBAR+(ScreenH-K_HEIGHT_NAVBAR)/4+DCMargin);
//        make.left.right.equalTo(self.view);
//        make.height.mas_equalTo(SCREEN_HEIGHT - K_HEIGHT_STATUSBAR - K_HEIGHT_NAVBAR);
//    }];
//    self.collectionView = collectionView;

//    self.flowLayout = [[GKCustomFlowLayout alloc] init];
////    _customLayout = [[UICollectionViewLayout alloc] init]; // 自定义的布局对象
//    _collectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:_flowLayout];
//    _collectionView.backgroundColor = [UIColor whiteColor];
//    _collectionView.dataSource = self;
//    _collectionView.delegate = self;
//    [self.view addSubview:_collectionView];
//
    // 注册cell、sectionHeader、sectionFooter
//    [_collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:GKPersonalCell];
//    [_collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:headerId];
//    [_collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:footerId];
}

- (void)loadCollectionView2{
    //1.初始化layout
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    //设置collectionView滚动方向
    //    [layout setScrollDirection:UICollectionViewScrollDirectionHorizontal];
    //设置headerView的尺寸大小
    layout.headerReferenceSize = CGSizeMake(self.view.frame.size.width, 100);
    //该方法也可以设置itemSize
    layout.itemSize =CGSizeMake(110, 150);
    //2.初始化collectionView
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:layout];
    [self.view addSubview:collectionView];
    collectionView.backgroundColor = [UIColor redColor];
    //3.注册collectionViewCell
    //注意，此处的ReuseIdentifier 必须和 cellForItemAtIndexPath 方法中 一致 均为 cellId
    [collectionView registerClass:[GKPersonalCell class] forCellWithReuseIdentifier:@"cellId"];

    //4.设置代理
    collectionView.delegate = self;
    collectionView.dataSource = self;

}

- (NSMutableArray *)shareArray{
    if (!_shareArray) {
        _shareArray = [NSMutableArray array];
        
        [_shareArray addObject:IFMPlatformNameWechat];
        [_shareArray addObject:IFMPlatformNameWechatFriend];
        [_shareArray addObject:IFMPlatformNameSina];
        [_shareArray addObject:IFMPlatformNameQQ];
        [_shareArray addObject:IFMPlatformNameQQSpace];
        
    }
    return _shareArray;
}

- (NSMutableArray *)functionArray{
    if (!_functionArray) {
        _functionArray = [NSMutableArray array];
        [_functionArray addObject:[[IFMShareItem alloc] initWithImage:[UIImage imageNamed:@"function_collection"] title:@"收藏" action:^(IFMShareItem *item) {
            ALERT_MSG(@"提示",@"点击了收藏",self);
        }]];
        [_functionArray addObject:[[IFMShareItem alloc] initWithImage:[UIImage imageNamed:@"function_copy"] title:@"复制" action:^(IFMShareItem *item) {
            ALERT_MSG(@"提示",@"点击了复制",self);
        }]];
        [_functionArray addObject:[[IFMShareItem alloc] initWithImage:[UIImage imageNamed:@"function_expose"] title:@"举报" action:^(IFMShareItem *item) {
            ALERT_MSG(@"提示",@"点击了举报",self);
        }]];
        [_functionArray addObject:[[IFMShareItem alloc] initWithImage:[UIImage imageNamed:@"function_font"] title:@"调整字体" action:^(IFMShareItem *item) {
            ALERT_MSG(@"提示",@"点击了调整字体",self);
        }]];
        [_functionArray addObject:[[IFMShareItem alloc] initWithImage:[UIImage imageNamed:@"function_link"] title:@"复制链接" action:^(IFMShareItem *item) {
            ALERT_MSG(@"提示",@"点击了复制链接",self);
        }]];
        [_functionArray addObject:[[IFMShareItem alloc] initWithImage:[UIImage imageNamed:@"function_refresh"] title:@"刷新" action:^(IFMShareItem *item) {
            ALERT_MSG(@"提示",@"点击了刷新",self);
        }]];
    }
    return _functionArray;
}


-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
//    [self getUI];
//    [self updateUI];
    [self updatas];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"个人中心";
    [self getUI];
    [self getData];
    [self addObserver];
//    self.view.backgroundColor = [UIColor redColor];
//    self.collectionView.backgroundColor = [UIColor whiteColor];
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark -页面逻辑方法
- (void) addObserver
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateUIReload) name:KNotiUserNameChange object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateUIReload) name:KNotiPhoneNumberChange object:nil];
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(receiveNotiDeivceDisconnect) name:KNotiDeviceDisconnectFormServe object:nil];
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(trunToQRCode) name:@"trunToQRCode" object:nil];
}

-(void)updatas{
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
    NSString *cookid = [DCObjManager dc_readUserDataForKey:@"key"];
    if (cookid) {
        //    NSLog(@"cookid = %@",cookid);
//        NSDictionary *dict=@{
//                             @"cookid":cookid
//                             };
        [GCHttpDataTool cxChargingLineStatusWithDict:nil success:^(id responseObject) {
            [SVProgressHUD dismiss];
//            [SVProgressHUD showSuccessWithStatus:@"查询用户状态成功！"];
//            [responseObject[@"type"] intValue];
//            [responseObject[@"userid"] string];
            
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
        //    NSLog(@"cookid = %@",cookid);
        //        NSDictionary *dict=@{
        //                             @"cookid":cookid
        //                             };
        [GCHttpDataTool getUserInfoWithDict:nil success:^(id responseObject) {
            [SVProgressHUD dismiss];
//            [SVProgressHUD showSuccessWithStatus:@"查询用户状态成功！"];
            //            [responseObject[@"type"] intValue];
            //            [responseObject[@"userid"] string];
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

- (void)getUI{
//    [SVProgressHUD showInfoWithStatus:@"getUI"];
//    NSLog(@"viewDidLoad");
    
    UIBarButtonItem *rightBtnItem = [[UIBarButtonItem alloc]initWithImage:SETIMAGE(@"share_btn") style:UIBarButtonItemStyleDone target:self action:@selector(shareBtnAction)];
    [self.navigationItem setRightBarButtonItem:rightBtnItem];
    
    GKPersonalHeaderView * headerView = [[GKPersonalHeaderView alloc] initWithFrame:CGRectZero];
    [self.view addSubview:headerView];
    [headerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.view).with.offset(K_HEIGHT_NAVBAR);
        make.left.equalTo(self.view);
        make.height.mas_equalTo((ScreenH-K_HEIGHT_NAVBAR)/4);
        make.width.mas_equalTo(SCREEN_WIDTH);
    }];
//    [headerView.phoneBtn setTitle:[DCObjManager dc_getObjectByFileName:@"手机号"] forState:UIControlStateNormal];
    [headerView.iconImageViewBtn addTarget:self action:@selector(turnToGKMeViewController) forControlEvents:UIControlEventTouchUpInside];
    [headerView.phoneBtn addTarget:self action:@selector(turnToGKBindingPhoneController) forControlEvents:UIControlEventTouchUpInside];
    self.headerView = headerView;
    self.headTitleLabel = headerView.headTitleLabel;
    
    //1.初始化layout
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.collectionView.backgroundColor = TABLEVIEW_BG;
    //设置collectionView滚动方向
    [layout setScrollDirection:UICollectionViewScrollDirectionVertical];
    //设置headerView的尺寸大小
    //    layout.headerReferenceSize = CGSizeMake(self.view.frame.size.width, 100);
    //该方法也可以设置itemSize
    //    layout.itemSize =CGSizeMake(110, 150);
    //2.初始化collectionView
    //    collectionView.backgroundColor = [UIColor lightGrayColor];
    //    [collectionView setBackgroundColor:TABLEVIEW_BG];
    //    [collectionView setBackgroundColor:[UIColor whiteColor]];
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, K_HEIGHT_NAVBAR+(ScreenH-K_HEIGHT_NAVBAR)/4+DCMargin, ScreenW, ScreenH-(K_HEIGHT_NAVBAR+(ScreenH-K_HEIGHT_NAVBAR)/4+DCMargin)) collectionViewLayout:layout];
    [self.view addSubview:collectionView];
    collectionView.backgroundColor = RGB(248, 248, 248);
    //3.注册collectionViewCell
    //注意，此处的ReuseIdentifier 必须和 cellForItemAtIndexPath 方法中 一致 均为 cellId
    [collectionView registerClass:[GKPersonalCell class] forCellWithReuseIdentifier:@"cellId"];
    //4.设置代理
    collectionView.delegate = self;
    collectionView.dataSource = self;
    self.collectionView = collectionView;
}

-(void)updateUIReload{
//    [SVProgressHUD showInfoWithStatus:@"updateUIReload"];
//    [self.headTitleLabel setText:[DCObjManager dc_readUserDataForKey:@"UserName"]];
    
//    NSLog(@"updateUIReload");
    if ([DCObjManager dc_readUserDataForKey:@"UserName"] != nil) {
        [self.headerView.headTitleLabel setText:[DCObjManager dc_readUserDataForKey:@"UserName"]];
//        [SVProgressHUD showInfoWithStatus:[DCObjManager dc_readUserDataForKey:@"UserName"]];
    }else{
        [self.headerView.headTitleLabel setText:@"昵称"];
    }
    if ([[DCObjManager dc_readUserDataForKey:@"myPhone"] length] == 11) {
        [self.headerView.phoneBtn setTitle:[DCObjManager dc_readUserDataForKey:@"myPhone"] forState:UIControlStateNormal];
    }else{
        [self.headerView.phoneBtn setTitle:@"绑定手机号码" forState:UIControlStateNormal];
    }
//    NSLog(@"updateUIReload222");
//    [SVProgressHUD showInfoWithStatus:[NSString stringWithFormat:@"self.headerView.headTitleLabel.text = %@",self.self.headTitleLabel.text]];
}

- (void)getData{
//    self.titleListArray = @[@"余额:",@"订单管理",@"使用帮助",@"关于我们",@"紧急报警",@"意见反馈"];
    [self getDataFromPlist];
}

- (void)getDataFromPlist{
    NSString *plistPath = [[NSBundle mainBundle]pathForResource:@"PersonalCenterMenu" ofType:@"plist"];
    
    // [NSBundle mainBundle] 关联的就是项目的主资源包
//    NSBundle *bundle = [NSBundle mainBundle];
    // 利用mainBundle 获得plist文件在主资源包中的全路径
//    NSString *file = [bundle pathForResource:@"shops" ofType:@"plist"];
    // 凡是参数名为File，传递的都是文件的全路径
    NSArray *datasArray = [NSArray arrayWithContentsOfFile:plistPath];
    
    NSMutableArray *titleListMuArray = [NSMutableArray new];
    NSMutableArray *imagesListMuArray = [NSMutableArray new];
    
    
    for (NSMutableDictionary *dic in datasArray) {
        [titleListMuArray addObject:dic[@"titleName"]];
        [imagesListMuArray addObject:dic[@"imageName"]];
//        NSLog(@"dic[@'titleName'] = %@,dic[@'imageName‘] = %@",dic[@"titleName"],dic[@"imageName"]);
    }
    self.titleListArray = [titleListMuArray copy];
    self.imagesListArray = [imagesListMuArray copy];
    
//    [self.collectionView reloadData];
}

#pragma mark - UICollectionViewDelegate,UICollectionViewDataSource
#pragma mark collectionView代理方法
//返回section个数
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

//每个section的item个数
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 7;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    GKPersonalCell *cell = (GKPersonalCell *)[collectionView dequeueReusableCellWithReuseIdentifier:@"cellId" forIndexPath:indexPath];
    cell.titleLabel.text = [self.titleListArray objectAtIndex:indexPath.row];
//    NSLog(@"cell.titleLabel.text = %@",[self.titleListArray objectAtIndex:indexPath.row]);
    [cell.gridImageView setImage:[UIImage imageNamed:[self.imagesListArray objectAtIndex:indexPath.row]]];
    cell.backgroundColor = [UIColor whiteColor];
    
    if (indexPath.row == 0) {
//        cell.infoLabel = [NSUserDefaults ];
        cell.infoLabel.text = @"120元";
        [cell.infoLabel setHidden:false];
    }else{
        cell.infoLabel.text = @"";
        [cell.infoLabel setHidden:true];
    }
    
    return cell;
}

//设置每个item的尺寸
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(ScreenW/2 - 2, (ScreenH-K_HEIGHT_NAVBAR - DCMargin)/4*3/5);
}

//设置每个item的UIEdgeInsets
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(1, 1, 1, 1);
}

//设置每个item水平间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 1;
}

//设置每个item垂直间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 1;
}

//点击item方法
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if ([self checkLoginStatus]) {
        return;
    }
    [collectionView deselectItemAtIndexPath:indexPath animated:YES];
//    GKBaseSetViewController *vc = [[GKBaseSetViewController alloc]init];
    GKBaseSetViewController *nextVC;
    switch (indexPath.row) {
        case 0://余额
            nextVC = [[GKBalanceViewController alloc] init];
            break;
        case 1://订单管理
            nextVC = [[GKOrderManagementViewController alloc] init];
            break;
        case 2://使用帮助
            nextVC = [[GKUseingHelpViewController alloc] init];
            break;
        case 3://关于我们
            nextVC = [[GKAboutUsViewController alloc] init];
            break;
        case 4://更新APP
            [self updateApp];
            break;
        case 5://紧急报警
//            GKEvaluateViewController *dcFVc = [[GKEvaluateViewController alloc] init];
//            nextVC = [[GKEvaluateViewController alloc] init];
//            [nextVC setUpFeatureAttribute:^(NSArray *__autoreleasing *imageArray, UIColor *__autoreleasing *selColor, BOOL *showSkip, BOOL *showPageCount) {
//                *imageArray = @[@"guide1",@"guide2",@"guide3",@"guide4"];
//                *showPageCount = YES;
//                *showSkip = YES;
//            }];
//            [SVProgressHUD showErrorWithStatus:@"暂未开通！"];
//            [SVProgressHUD showErrorWithStatus:@"暂用于GKStartChargingViewController测试页面！"];
//            return
            nextVC = [[GKStartChargingViewController alloc]init];
            break;
        case 6://意见反馈
            nextVC = [[GKFeedBackViewController alloc] init];
            break;
//        case 8:
//            //弹出框
//            [self initAlertView];
//            break;
        default:
            break;
    }
    if (indexPath.row != 8) {
//        [nextVC setHidesBottomBarWhenPushed:YES];
        [self.navigationController pushViewController:nextVC animated:YES];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark -自定义方法

-(void)turnToGKMeViewController{
    //判断是否登录状态
//    if (![[DCObjManager dc_readUserDataForKey:@"isLogin"] isEqualToString:@"1"]) {
//        GKLoginViewController *VC=[[GKLoginViewController alloc]init];
//        UINavigationController *nav=[[UINavigationController alloc]initWithRootViewController:VC];
//        [self presentViewController:nav animated:YES completion:nil];
//    } else {
//        GKMeViewController * vc = [[GKMeViewController alloc]init];
//        [self.navigationController pushViewController:vc animated:YES];
//    }
    if ([self checkLoginStatus]) {
        return;
    }
    GKMeViewController * vc = [[GKMeViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}

-(void)turnToGKBindingPhoneController{
    if ([self checkLoginStatus]) {
        return;
    }
    GKBindingPhoneController * vc = [[GKBindingPhoneController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}

-(void)shareBtnAction{
//    [SVProgressHUD showInfoWithStatus:@"shareBtnAction"];
    IFMShareView *shareView = [[IFMShareView alloc] initWithItems:self.shareArray itemSize:CGSizeMake(80,100) DisplayLine:YES];
    shareView = [self addShareContent:shareView];
    shareView.itemSpace = 10;
    [shareView showFromControlle:self];
}
//添加分享的内容
- (IFMShareView *)addShareContent:(IFMShareView *)shareView{
    [shareView addText:@"分享测试"];
    [shareView addURL:[NSURL URLWithString:@"http://www.baidu.com"]];
    [shareView addImage:[UIImage imageNamed:@"icon_share_qq_space"]];
    
    return shareView;
}

-(Boolean)checkLoginStatus{
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


#pragma mark -更新 APP 的方法
////1. 在application中调用
//-(void)checkVersionUpdata{
//    NSString *urlStr    = @"http://itunes.apple.com/lookup?id=1438435188";//id替换即可
//    NSURL *url          = [NSURL URLWithString:urlStr];
//    NSURLRequest *req   = [NSURLRequest requestWithURL:url];
//    [NSURLConnection connectionWithRequest:req delegate:self];
//}
////2. 网络连接
//-(void)connection:(NSURLConnection *)connection didReceiveData:(nonnull NSData *)data
//{
//    NSError *error;
//    id jsonObject           = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
//    [XKCEHint disMissLoading];
//    NSDictionary *appInfo   = (NSDictionary*)jsonObject;
//    NSArray *infoContent    = [appInfo objectForKey:@"results"];
//    NSString * version      = [[infoContent objectAtIndex:0]objectForKey:@"version"];//线上最新版本
//    // 获取当前版本
//    NSString *currentVersion    = [self version];//当前用户版本
//    BOOL result          = [currentVersion compare:version] == NSOrderedAscending;
//    if (result) {//需要更新
//        [XKCEGlobleData sharedData].version = @"1";
//        NSLog(@"不是最新版本需要更新");
//        NSString *updateStr = [NSString stringWithFormat:@"发现新版本V%@\n为保证软件的正常运行\n请及时更新到最新版本",version];
//        [self creatAlterView:updateStr];
//    } else {//已经是最新版；
//        NSLog(@"最新版本不需要更新");
//    }
//}
//3. 弹框提示
//-(void)creatAlterView:(NSString *)msg{
//    UIAlertController *alertText = [UIAlertController alertControllerWithTitle:@"更新提醒" message:msg preferredStyle:UIAlertControllerStyleAlert];
//    //增加按钮
//    [alertText addAction:[UIAlertAction actionWithTitle:@"我再想想" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
//    }]];
//    [alertText addAction:[UIAlertAction actionWithTitle:@"立即更新" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
//        NSString *str = @"itms-apps://itunes.apple.com/cn/app/id1329918420?mt=8"; //更换id即可
//        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
//    }]];
////    [self.window.rootViewController presentViewController:alertText animated:YES completion:nil];
//}
////版本
//-(NSString *)version
//{
//    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
//    NSString *app_Version       = [infoDictionary objectForKey:@"CFBundleShortVersionString"];
//    return app_Version;
//}
- (void)updateApp
{
    // kAPP_URL : @"http://itunes.apple.com/lookup?id=";
    //    kAppID : 在iTunes connect上申请的APP ID;
//    NSString *urlStr = @"http://itunes.apple.com/lookup?id=1438435188";//id替换即可
    NSString *kAPP_URL = @"http://itunes.apple.com/lookup?id=";
    NSString *kAppID = @"1438435188";
    NSString *urlStr = [NSString stringWithFormat:@"%@%@", kAPP_URL, kAppID];
    NSURL *url = [NSURL URLWithString:urlStr];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    //网络请求
    NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    NSURLSessionTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        NSError *err;
        //NSLog(@"%@", [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding]);
        NSDictionary *appInfoDict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&err];
        
        if (err) {
            NSLog(@"%@", err.description);
            return;
        }
        
        NSArray *resultArray = [appInfoDict objectForKey:@"results"];
        if (![resultArray count]) {
            NSLog(@"error : resultArray == nil");
            return;
        }
        
        NSDictionary *infoDict = [resultArray objectAtIndex:0];
//        NSLog(@"获取服务器上应用的基本信息\n infoDict = %@",infoDict);
        //获取服务器上应用的最新版本号
        NSString *updateVersion = infoDict[@"version"];
        NSString *trackName = infoDict[@"trackName"];
        
        //_trackViewUrl : 更新的时候用到的地址
        self.trackViewUrl = infoDict[@"trackViewUrl"];
        
        //获取当前设备中应用的版本号
        NSDictionary *infoDic = [[NSBundle mainBundle] infoDictionary];
        NSString *currentVersion = [infoDic objectForKey:@"CFBundleShortVersionString"];
//        NSLog(@"当前版本信息\ninfoDic = %@",infoDic);
//        NSLog(@"┗( ´・∧・｀)┛currentVersion = %@，┗( ´・∧・｀)┛updateVersion = %@",currentVersion,updateVersion);
        //判断两个版本是否相同
        if ([[currentVersion stringByReplacingOccurrencesOfString:@"." withString:@""] intValue] < [[updateVersion stringByReplacingOccurrencesOfString:@"." withString:@""] intValue]) {
//        if ([currentVersion doubleValue]*100 < [updateVersion doubleValue]*100) {
            NSString *titleStr = [NSString stringWithFormat:@"检查更新：%@", trackName];
            NSString *messageStr = [NSString stringWithFormat:@"检测到有新版本（V%@）\n是否进行下载?", updateVersion];
//            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:titleStr message:messageStr delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"升级", nil];
            // 1.NSThread
//            [self performSelectorOnMainThread:@selector(initAlertView:vlue02:) withObject:nil waitUntilDone:NO];
//            [self initAlertView:titleStr vlue02:messageStr];
            // 3.GCD转主线程进行该操作
            dispatch_async(dispatch_get_main_queue(), ^{
                if (titleStr != nil && messageStr != nil) {
                    [self initAlertView:titleStr vlue02:messageStr];
                }
            });
//            alert.tag = [kAppID intValue];
//            [alert show];
            
        } else {  //版本号和app store上的一致
//            NSString *titleStr = [NSString stringWithFormat:@"检查更新：%@", trackName];
//            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:titleStr message:@"暂无新版本" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
//            [self initAlertView2];
//            alert.tag = [kAppID intValue] + 1;
//            [alert show];
            [SVProgressHUD showInfoWithStatus:@"已是最新版本！"];
        }
    }];
    [task resume];
}

- (void)initAlertView:(NSString *)str vlue02:(NSString *)str2{
    SIAlertView *alertView = [[SIAlertView alloc] initWithTitle:@"" andMessage:str2];
    [alertView addButtonWithTitle:@"稍后"
                             type:SIAlertViewButtonTypeDefault
                          handler:^(SIAlertView *alertView) {
                              [alertView dismissAnimated:NO];
                              
                          }];
    
    [alertView addButtonWithTitle:@"立即下载"
                             type:SIAlertViewButtonTypeDestructive
                          handler:^(SIAlertView *alertView) {
                              
                              [self againAndOfTheCharging];
                              [alertView dismissAnimated:NO];
                              
                          }];
    
    [alertView show];
}

-(void)againAndOfTheCharging{
    //点击”升级“按钮，就从打开app store上应用的详情页面
//    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:self.trackViewUrl]];
    if (@available(iOS 10.0, *)) {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:self.trackViewUrl] options:@{} completionHandler:^(BOOL success) {
            NSLog(@"给个好评");
        }];
    } else {
        // Fallback on earlier versions
    }
}

@end
