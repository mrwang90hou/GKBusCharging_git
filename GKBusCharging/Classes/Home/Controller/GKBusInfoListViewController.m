//
//  GKBusInfoListViewController.m
//  GKBusCharging
//
//  Created by 王宁 on 2018/9/29.
//  Copyright © 2018年 goockr. All rights reserved.
//


#import "GKBusInfoListViewController.h"

// Controllers
#import "GKNavigationController.h"
#import "DCGMScanViewController.h"
#import "JFCityViewController.h"
#import "SDCycleScrollView.h"


//#import "DCTabBarController.h"
#import "DCRegisteredViewController.h"
// Models

// Views
#import "GKPersonalHeaderView.h"
#import "GKCustomFlowLayout.h"
#import "GKBusInfoCell.h"

// Vendors

// Categories

#import "GKUpDownButton.h"
#import "DCZuoWenRightButton.h"
#import "DCLIRLButton.h"
// Others
#import "AFNetPackage.h"

#define HeaderImageHeight ScreenW/2

#define kLineSpacing DCMargin/2

@interface GKBusInfoListViewController ()<UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>
{
    UILabel *titleHeaderLabel;
//    DCZuoWenRightButton *OrderingInfoBtn;
    UIButton *OrderingInfoBtn;
}

@property (nonatomic,strong) NSMutableArray *titleListArray;

@property (nonatomic,strong) NSMutableArray *imagesListArray;



//@property (strong, nonatomic) GKCustomFlowLayout *flowLayout;

@property(nonatomic,strong) UICollectionView *collectionView;
@end

@implementation GKBusInfoListViewController
#pragma mark - LazyLoad

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"意见反馈";
    [self getUI];
    [self getData];
}

- (void)getUI{
    titleHeaderLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 5, 100, 20)];
    OrderingInfoBtn = [[UIButton alloc]initWithFrame:CGRectMake(ScreenW - 100, 5, 100, 20)];
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.collectionView.backgroundColor = TABLEVIEW_BG;
    //设置collectionView滚动方向
    [layout setScrollDirection:UICollectionViewScrollDirectionVertical];
    //设置headerView的尺寸大小
    //    layout.headerReferenceSize = CGSizeMake(self.view.frame.size.width, 100);
    //该方法也可以设置itemSize
    //    layout.itemSize =CGSizeMake(110, 150);
    
    
    layout.sectionInset =UIEdgeInsetsMake(0, 0, 0, 0);
    layout.headerReferenceSize =CGSizeMake(ScreenW, 40*ScreenH/667);
    
    //2.初始化collectionView
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:layout];
    
    [self.view addSubview:collectionView];
    collectionView.backgroundColor = RGB(248, 248, 248);
    //3.注册collectionViewCell
    //注意，此处的ReuseIdentifier 必须和 cellForItemAtIndexPath 方法中 一致 均为 cellId
    [collectionView registerClass:[GKBusInfoCell class] forCellWithReuseIdentifier:@"cellId"];
    
    // 注册头视图
    [collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"header"];
    
    //4.设置代理
    collectionView.delegate = self;
    collectionView.dataSource = self;
    self.collectionView = collectionView;
}

- (void)getData{
    [self getDataFromPlist];
}

- (void)getDataFromPlist{
    NSString *plistPath = [[NSBundle mainBundle]pathForResource:@"FeedBackMenu" ofType:@"plist"];
    
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
    return 6;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    GKBusInfoCell *cell = (GKBusInfoCell *)[collectionView dequeueReusableCellWithReuseIdentifier:@"cellId" forIndexPath:indexPath];
//    cell.titleLabel.text = [self.titleListArray objectAtIndex:indexPath.row];
    
    //自动折行设置
//    cell.titleLabel.lineBreakMode = UILineBreakModeWordWrap;
//    cell.titleLabel.numberOfLines = 0;
    
    
//    NSLog(@"cell.titleLabel.text = %@",[self.titleListArray objectAtIndex:indexPath.row]);
//    [cell.gridImageView setImage:[UIImage imageNamed:[self.imagesListArray objectAtIndex:indexPath.row]]];
    cell.backgroundColor = [UIColor orangeColor];
    
    return cell;
}

//设置每个item的尺寸
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
//    return CGSizeMake(ScreenW/2 - 2, (ScreenH-K_HEIGHT_NAVBAR - DCMargin)/4*3/5);
    return CGSizeMake(ScreenW-8, (ScreenH-K_HEIGHT_NAVBAR - DCMargin)/4*3/5);
    
}

//设置每个item的UIEdgeInsets
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(4, 4, 4, 4);
}

//设置每个item水平间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 1;
}

//设置每个item垂直间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 4;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    return CGSizeMake(ScreenW,40*ScreenH/667);
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{

#pragma mark ----- 重用的问题
    UICollectionReusableView *header = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"header" forIndexPath:indexPath];

    header.backgroundColor = RGB(236, 237, 241);
    if (indexPath.section == 0) {
        titleHeaderLabel.text = @"异常反馈";
        titleHeaderLabel.font = [UIFont systemFontOfSize:17.0f];
        titleHeaderLabel.textColor = RGB(88, 79, 96);
        [header addSubview:titleHeaderLabel];

        OrderingInfoBtn.titleLabel.text = @"订单详情";
        OrderingInfoBtn.titleLabel.font = [UIFont systemFontOfSize:13.0f];
        OrderingInfoBtn.titleLabel.textColor = RGB(88, 79, 96);
        [OrderingInfoBtn setImage:[UIImage imageNamed:@"home_icon_page_more"] forState:UIControlStateNormal];
        [OrderingInfoBtn addTarget:self action:@selector(touch) forControlEvents:UIControlEventTouchUpInside];
        [header addSubview:OrderingInfoBtn];

        [titleHeaderLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.top.mas_equalTo(self.navigationController.navigationBar.mas_bottom);
            make.centerY.equalTo(header);
            make.left.mas_equalTo(self.view).offset(4);
            make.width.equalTo(@100);
            make.height.equalTo(@20);
        }];
        [OrderingInfoBtn mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.top.equalTo(self->titleHeaderLabel);
            make.centerY.equalTo(header);
            make.right.mas_equalTo(self.view.mas_right).offset(-4);;
            make.width.equalTo(@100);
            make.height.equalTo(@20);
        }];

    }else{

//        labelTwo.text = @"疾病信息";
//        labelTwo.font = [UIFont systemFontOfSize:14.0f];
//        labelTwo.textColor = MainRGB;
//        [header addSubview:labelTwo];
    }
    return header;
}

//点击item方法
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
}


- (void)touch{
    NSLog(@"touch!!!");
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
