//
//  GKPersonalCenterViewController.m
//  GKBusCharging
//
//  Created by L on 2018/9/28.
//  Copyright © 2018年 goockr. All rights reserved.
//

#import "GKPersonalCenterViewController.h"

// Controllers
#import "GKNavigationController.h"
#import "DCGMScanViewController.h"
#import "JFCityViewController.h"
#import "SDCycleScrollView.h"

//#import "DCTabBarController.h"
#import "DCRegisteredViewController.h"
// Models

// Views
#import "DCAccountPsdView.h" //账号密码登录
#import "DCVerificationView.h" //验证码登录
#import "GKPersonalHeaderView.h"
#import "GKCustomFlowLayout.h"
#import "GKPersonalCell.h"

// Vendors

// Categories

#import "GKUpDownButton.h"
#import "DCZuoWenRightButton.h"
#import "DCLIRLButton.h"
// Others
#import "AFNetPackage.h"

#define HeaderImageHeight ScreenW/2

#define kLineSpacing DCMargin/2

@interface GKPersonalCenterViewController ()<UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>
{
    UICollectionView *collectionView;
}


/* collectionView */
//@property (strong , nonatomic)UICollectionView *collectionView;

@property (nonatomic, strong) NSMutableArray *images;

//@property (strong, nonatomic) GKCustomFlowLayout *flowLayout;
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
    collectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:layout];
    [self.view addSubview:collectionView];
    collectionView.backgroundColor = [UIColor redColor];
    //3.注册collectionViewCell
    //注意，此处的ReuseIdentifier 必须和 cellForItemAtIndexPath 方法中 一致 均为 cellId
    [collectionView registerClass:[GKPersonalCell class] forCellWithReuseIdentifier:@"cellId"];

    //4.设置代理
    collectionView.delegate = self;
    collectionView.dataSource = self;

}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"个人中心";
    GKPersonalHeaderView * headerView = [[GKPersonalHeaderView alloc] initWithFrame:CGRectZero];
    [self.view addSubview:headerView];
    [headerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.view).with.offset(K_HEIGHT_NAVBAR);
        make.left.equalTo(self.view);
        make.height.mas_equalTo((ScreenH-K_HEIGHT_NAVBAR)/4);
        make.width.mas_equalTo(SCREEN_WIDTH);
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
//    collectionView.backgroundColor = RGB(248, 248, 248);
//    collectionView.backgroundColor = [UIColor lightGrayColor];
//    [collectionView setBackgroundColor:TABLEVIEW_BG];
//    [collectionView setBackgroundColor:[UIColor whiteColor]];
    
    collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, K_HEIGHT_NAVBAR+(ScreenH-K_HEIGHT_NAVBAR)/4+DCMargin, ScreenW, ScreenH-(K_HEIGHT_NAVBAR+(ScreenH-K_HEIGHT_NAVBAR)/4+DCMargin)) collectionViewLayout:layout];

    [self.view addSubview:collectionView];
    //3.注册collectionViewCell
    //注意，此处的ReuseIdentifier 必须和 cellForItemAtIndexPath 方法中 一致 均为 cellId
    [collectionView registerClass:[GKPersonalCell class] forCellWithReuseIdentifier:@"cellId"];
    //4.设置代理
    collectionView.delegate = self;
    collectionView.dataSource = self;
    
    
    
    
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
    return 6;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    GKPersonalCell *cell = (GKPersonalCell *)[collectionView dequeueReusableCellWithReuseIdentifier:@"cellId" forIndexPath:indexPath];
    
//    cell.titleLabel.text = [NSString stringWithFormat:@"{%ld,%ld}",(long)indexPath.section,(long)indexPath.row];
    cell.titleLabel.text = @"下载 APP";
    cell.backgroundColor = [UIColor whiteColor];
    
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
    GKPersonalCell *cell = (GKPersonalCell *)[collectionView cellForItemAtIndexPath:indexPath];
    
    NSString *msg = cell.titleLabel.text;
    NSLog(@"%@",msg);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
