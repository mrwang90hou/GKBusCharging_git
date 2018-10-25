//
//  GKRechargeCardViewController.m
//  GKBusCharging
//
//  Created by 王宁 on 2018/10/18.
//  Copyright © 2018年 goockr. All rights reserved.
//

#import "GKRechargeCardViewController.h"
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

#import "GKStartChargingViewController.h"
//#import "DCTabBarController.h"
////#import "DCRegisteredViewController.h"
// Models

// Views
//#import "DCAccountPsdView.h" //账号密码登录
//#import "DCVerificationView.h" //验证码登录
#import "GKPersonalHeaderView.h"
#import "GKCustomFlowLayout.h"
#import "GKRechargeCardCell.h"

// Vendors

// Categories

#import "GKUpDownButton.h"
#import "DCZuoWenRightButton.h"
// Others
//#import "AFNetPackage.h"

#define HeaderImageHeight ScreenW/2

#define kLineSpacing DCMargin/2

@interface GKRechargeCardViewController ()<UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>
//{
//    UICollectionView *collectionView;
//}

@property (nonatomic,strong) NSMutableArray *titleListArray;

@property (nonatomic,strong) NSMutableArray *amountListMuArray;

@property (retain, strong) GKPersonalHeaderView *headerView;

@property (retain, strong) UILabel *headTitleLabel;

@property (nonatomic,strong) UICollectionView *collectionView;

@property (nonatomic ,strong) UIButton *endingBtn;
@end

@implementation GKRechargeCardViewController
#pragma mark - LazyLoad

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    //    [self getUI];
    //    [self updateUI];
    [self updatas];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"充电卡";
    [self getUI];
    [self getData];
    [self addObserver];
    self.view.backgroundColor = TABLEVIEW_BG;
    
    
    //设置你想选中的某一行,我这里是第一行
//    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
//    //执行此方法,表明表视图要选中这一行
//    [self.collectionView selectItemAtIndexPath:indexPath animated:YES scrollPosition:UICollectionViewScrollPositionNone];
//    //调用此方法,显示我们自定义的选中颜色
//    [self collectionView:self.collectionView didSelectItemAtIndexPath:indexPath];
    
    
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
//        [self requestData];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//            [self requestData2];
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
    
    UIView * headerTitleView = [[UIView alloc]init];
    [self.view addSubview:headerTitleView];
    [headerTitleView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.view).with.offset(K_HEIGHT_NAVBAR);
        make.left.right.equalTo(self.view);
        make.height.mas_equalTo(K_HEIGHT_NAVBAR/2);
    }];
    [headerTitleView setBackgroundColor:TABLEVIEW_BG];
    
    UILabel *titleLabel = [[UILabel alloc]init];
    [headerTitleView addSubview:titleLabel];
    [titleLabel setTextColor:TEXTMAINCOLOR];
    [titleLabel setText:@"充值月卡"];
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(headerTitleView);
        make.left.mas_equalTo(20);
        make.size.mas_equalTo(CGSizeMake(120, 22));
    }];
    
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
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, K_HEIGHT_NAVBAR*3/2+DCMargin, ScreenW, ScreenH-(K_HEIGHT_NAVBAR+(ScreenH-K_HEIGHT_NAVBAR)/4+DCMargin)) collectionViewLayout:layout];
    [self.view addSubview:collectionView];
    collectionView.backgroundColor = RGB(248, 248, 248);
    //3.注册collectionViewCell
    //注意，此处的ReuseIdentifier 必须和 cellForItemAtIndexPath 方法中 一致 均为 cellId
    [collectionView registerClass:[GKRechargeCardCell class] forCellWithReuseIdentifier:@"cellId"];
    //4.设置代理
    collectionView.delegate = self;
    collectionView.dataSource = self;
    self.collectionView = collectionView;
    UIButton *endingBtn = [[UIButton alloc]init];
    [self.view addSubview:endingBtn];
    [endingBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.view).offset(-8);
        make.centerX.equalTo(self.view);
        make.size.mas_equalTo(CGSizeMake(307, 44));
    }];
    [endingBtn addTarget:self action:@selector(endingBtnAction) forControlEvents:UIControlEventTouchUpInside];
    [endingBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];//0xFCE9B
    [endingBtn setTitle:@"立即购买" forState:UIControlStateNormal];
    [endingBtn setBackgroundImage:SETIMAGE(@"btn_5_disabled") forState:UIControlStateDisabled];
    [endingBtn setBackgroundImage:SETIMAGE(@"btn_5_normal") forState:UIControlStateNormal];
    endingBtn.enabled = NO;
    self.endingBtn = endingBtn;
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
    NSString *plistPath = [[NSBundle mainBundle]pathForResource:@"RechargeCardPriceMenu" ofType:@"plist"];
    
    // [NSBundle mainBundle] 关联的就是项目的主资源包
    //    NSBundle *bundle = [NSBundle mainBundle];
    // 利用mainBundle 获得plist文件在主资源包中的全路径
    //    NSString *file = [bundle pathForResource:@"shops" ofType:@"plist"];
    // 凡是参数名为File，传递的都是文件的全路径
    NSArray *datasArray = [NSArray arrayWithContentsOfFile:plistPath];
    
    NSMutableArray *titleListMuArray = [NSMutableArray new];
    NSMutableArray *amountListMuArray = [NSMutableArray new];
    
    
    for (NSMutableDictionary *dic in datasArray) {
        [titleListMuArray addObject:dic[@"titleName"]];
        [amountListMuArray addObject:dic[@"priceName"]];
    }
    self.titleListArray = [titleListMuArray copy];
    self.amountListMuArray = [amountListMuArray copy];
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
    return [self.titleListArray count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    GKRechargeCardCell *cell = (GKRechargeCardCell *)[collectionView dequeueReusableCellWithReuseIdentifier:@"cellId" forIndexPath:indexPath];
    cell.titleLabel.text = [self.titleListArray objectAtIndex:indexPath.row];
    //    NSLog(@"cell.titleLabel.text = %@",[self.titleListArray objectAtIndex:indexPath.row]);
//    [cell.gridImageView setImage:[UIImage imageNamed:[self.amountListMuArray objectAtIndex:indexPath.row]]];
    cell.backgroundColor = [UIColor clearColor];
    cell.infoLabel.text = [self.amountListMuArray objectAtIndex:indexPath.row];
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
    [collectionView deselectItemAtIndexPath:indexPath animated:YES];
//    [SVProgressHUD showInfoWithStatus:[NSString stringWithFormat:@"点击了第%ld个",(long)indexPath.row]];
    [self reloadDatasAndCollection:indexPath];
//    [self reloadDatasAndTable:indexPath];
}
//刷新 tabView 的选择状态
-(void)reloadDatasAndCollection:(NSIndexPath *)indexPath{
    for (int i = 0; i<3; i++) {
        NSIndexPath *indexPath2 = [NSIndexPath indexPathForRow:i inSection:0];
        GKRechargeCardCell *cell = (GKRechargeCardCell *)[self.collectionView cellForItemAtIndexPath:indexPath2];
        if (i == indexPath.row) {
            [cell.uiButton setImage:[UIImage imageNamed:@"recharge_amount_bg_selected"] forState:UIControlStateNormal];
            [cell.titleLabel setTextColor:[UIColor whiteColor]];
            [cell.infoLabel setTextColor:[UIColor whiteColor]];
        }else{
            [cell.uiButton setImage:[UIImage imageNamed:@"recharge_amount_bg_normal"] forState:UIControlStateNormal];
            [cell.titleLabel setTextColor:TEXTMAINCOLOR];
            [cell.infoLabel setTextColor:TEXTMAINCOLOR];
        }
//        cell.selectedBackgroundView = [[UIView alloc]initWithFrame:cell.bounds];
//        cell.selectedBackgroundView.backgroundColor = TABLEVIEW_BG;
    }
    self.endingBtn.enabled = YES;
}

#pragma mark - collectionViewCell点击高亮
//- (void)collectionView:(UICollectionView *)collectionView didHighlightItemAtIndexPath:(NSIndexPath *)indexPath{
//
//    UICollectionViewCell *cell = [collectionView cellForItemAtIndexPath:indexPath];
//    cell.backgroundColor = RGB(238, 238, 238);
//
//}
//- (void)collectionView:(UICollectionView *)collectionView didUnhighlightItemAtIndexPath:(NSIndexPath *)indexPath{
//
//    UICollectionViewCell *cell = [collectionView cellForItemAtIndexPath:indexPath];
//    cell.backgroundColor = [UIColor whiteColor];
//}
//- (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath{
//
//    return YES;
//}

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
-(void)endingBtnAction{
    [SVProgressHUD showWithStatus:@"立即购买！"];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [SVProgressHUD dismiss];
        [SVProgressHUD showSuccessWithStatus:@"购买成功！"];
    });
}
@end
