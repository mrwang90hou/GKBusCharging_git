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
#import "GKBusMoreInfoViewController.h"

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

static NSString *GKBusInfoCellID = @"GKBusInfoCell";

@interface GKBusInfoListViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *evaluations;

@end

@implementation GKBusInfoListViewController
#pragma mark - LazyLoad

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"车辆信息";
    [self setupUI];
}
-(void)setupUI{
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
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
    return 73;
//    return 80;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    GKBusInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:GKBusInfoCellID forIndexPath:indexPath];
    cell.hidden = YES;
    return cell;
}
- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    GKBusMoreInfoViewController *vc = [[GKBusMoreInfoViewController alloc] init];
    vc.title = @"信息详情";
    [self.navigationController pushViewController:vc animated:YES];
}



#pragma mark - lazy load
-(UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];//UITableViewStyleGrouped
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [_tableView registerNib:[UINib nibWithNibName:@"GKBusInfoCell" bundle:nil] forCellReuseIdentifier:GKBusInfoCellID];
        _tableView.backgroundColor = [UIColor colorWithRed:244/255.0 green:244/255.0 blue:244/255.0 alpha:1];
        _tableView.allowsSelection = YES;
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

- (void)touch{
    NSLog(@"touch!!!");
}
//
//- (void)didReceiveMemoryWarning {
//    [super didReceiveMemoryWarning];
//    // Dispose of any resources that can be recreated.
//}

@end
