//
//  GKOrderManagementViewController.m
//  GKBusCharging
//
//  Created by 王宁 on 2018/10/7.
//  Copyright © 2018年 goockr. All rights reserved.
//


#import "GKOrderManagementViewController.h"

// Controllers
#import "GKNavigationController.h"
#import "DCGMScanViewController.h"
#import "JFCityViewController.h"
#import "SDCycleScrollView.h"
#import "GKBusMoreInfoViewController.h"
#import "GKOrderRateViewController.h"

//#import "DCTabBarController.h"
////#import "DCRegisteredViewController.h"
// Models

// Views
#import "GKPersonalHeaderView.h"
#import "GKCustomFlowLayout.h"
#import "GKOrderCell.h"

// Vendors

// Categories

#import "GKUpDownButton.h"
#import "DCZuoWenRightButton.h"
#import "DCLIRLButton.h"
// Others
//#import "AFNetPackage.h"

#define HeaderImageHeight ScreenW/2

#define kLineSpacing DCMargin/2

static NSString *GKOrderCellID = @"GKOrderCell";

@interface GKOrderManagementViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *evaluations;

@property (nonatomic,strong)  NSMutableArray *dataSoucre;

@property (nonatomic,strong) UIView *noDatasView;


@end

@implementation GKOrderManagementViewController
#pragma mark - lazy load
-(UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];//UITableViewStyleGrouped
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [_tableView registerNib:[UINib nibWithNibName:@"GKOrderCell" bundle:nil] forCellReuseIdentifier:GKOrderCellID];
        _tableView.backgroundColor = [UIColor colorWithRed:244/255.0 green:244/255.0 blue:244/255.0 alpha:1];
        _tableView.allowsSelection = NO;
        _tableView.delegate = self;
        _tableView.dataSource = self;
    }
    return _tableView;
}

-(NSMutableArray *)evaluations{
    if (!_evaluations) {
        _evaluations = [NSMutableArray array];
    }
    return _evaluations;
}

- (NSMutableArray *)dataSoucre
{
    if (_dataSoucre==nil) {
        _dataSoucre=[NSMutableArray array];
    }
    [_dataSoucre addObject:@"订单管理"];
    return _dataSoucre;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"订单管理";
    [self getUI];
    [self getData];
}

- (void)getUI{
    
    [self.view setBackgroundColor:TABLEVIEW_BG];
    UIView *noDatasView = [[UIView alloc]init];
    [self.view addSubview:noDatasView];
    [noDatasView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.view).offset(-ScreenH/4);
        make.centerX.equalTo(self.view);
        make.size.mas_equalTo(CGSizeMake(150, 150));
    }];
    //    [noDatasView setBackgroundColor:Main_Color];
    
    
    UIImageView *noDatasImageView = [[UIImageView alloc]initWithImage:SETIMAGE(@"blank_page_no_order")];
    [noDatasView addSubview:noDatasImageView];
    [noDatasImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(noDatasView).offset(-20);
        make.centerX.equalTo(noDatasView);
        make.size.mas_equalTo(CGSizeMake(110, 83));
    }];
    
    UILabel *messageLabel = [[UILabel alloc]init];
    [noDatasView addSubview:messageLabel];
    [messageLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(noDatasImageView.mas_bottom).offset(10);
        make.centerX.equalTo(noDatasView);
        make.size.mas_equalTo(CGSizeMake(120, 20));
    }];
    [messageLabel setTextColor:TEXTGRAYCOLOR];
    [messageLabel setFont:GKFont(14)];
    [messageLabel setText:@"暂无订单详情"];
    messageLabel.textAlignment = NSTextAlignmentCenter;
    self.noDatasView = noDatasView;
    //    blank_page_no_order
    //    暂无订单详情
    [_dataSoucre addObject:@"订单管理"];
    if (_dataSoucre.count == 0) {
        [_tableView setHidden:true];
        [_noDatasView setHidden:false];
    }else{
        [_noDatasView setHidden:true];
    }
}


-(void)getData{
    
}


#pragma mark - UITableViewDataSourceDelegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.evaluations.count + 9;
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
//    return 73;
    return 180;
}

- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *uiView = [[UIView alloc]init];
    [uiView setBackgroundColor:TABLEVIEW_BG];
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(10, 5, 120, 22)];
//    label.dc_centerY = uiView.bounds.origin.y;
    [label setText:@"租电历史记录"];
    [label setFont:GKFont(14)];
    [label setTextColor:RGBall(153)];
//    [label mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(uiView);
//        make.centerY.equalTo(uiView);
////        make.size.mas_equalTo(CGSizeMake(120, 22));
//        make.size.height.equalTo(@(22));
//        make.size.width.equalTo(@(120));
//    }];
    [uiView addSubview:label];
    return uiView;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    GKOrderCell *cell = [tableView dequeueReusableCellWithIdentifier:GKOrderCellID forIndexPath:indexPath];
//    cell.hidden = YES;
//    cell.OfferBatteryLabel.text = @"王宁";
//    [cell detailsAction:@selector(detailsAction:)];
    cell.headView_detailsBtn.tag = indexPath.row;
    [cell.headView_detailsBtn addTarget:self action:@selector(detailsAction:) forControlEvents:UIControlEventTouchUpInside];
    return cell;
}

- (void)detailsAction:(UIButton *)btn{
//    [SVProgressHUD showInfoWithStatus:[NSString stringWithFormat:@"点击成功！%ld",btn.tag+1]];
    GKOrderRateViewController *vc = [[GKOrderRateViewController alloc] init];
    vc.title = [NSString stringWithFormat:@"订单评价[第%ld个]",btn.tag+1];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    
//    GKBusMoreInfoViewController *vc = [[GKBusMoreInfoViewController alloc] init];
//    vc.title = [NSString stringWithFormat:@"信息详情[第%ld个]",indexPath.row+1];
//    [self.navigationController pushViewController:vc animated:YES];
}

- (void)touch{
    NSLog(@"touch!!!");
}
//
//- (void)didReceiveMemoryWarning {
//    [super didReceiveMemoryWarning];
//    // Dispose of any resources that can be recreated.
//}

@end
