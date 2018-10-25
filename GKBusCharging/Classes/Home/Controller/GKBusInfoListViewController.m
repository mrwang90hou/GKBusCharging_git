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
////#import "DCRegisteredViewController.h"
// Models

// Views
#import "GKPersonalHeaderView.h"
#import "GKCustomFlowLayout.h"
#import "GKBusInfoCell.h"

// Vendors

// Categories

#import "GKUpDownButton.h"
#import "DCZuoWenRightButton.h"
// Others
//#import "AFNetPackage.h"

#define HeaderImageHeight ScreenW/2

#define kLineSpacing DCMargin/2

static NSString *GKBusInfoCellID = @"GKBusInfoCell";

@interface GKBusInfoListViewController ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *evaluations;

@property (nonatomic,strong) GKTextField *searchTF;

@property (nonatomic,strong) NSString *cityName;

@property (nonatomic,strong) UIButton *cityNameBtn;

@end

@implementation GKBusInfoListViewController
#pragma mark - LazyLoad

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"车辆信息";
    self.cityName = @"佛山市";
    [self setupUI];
    [self setUpNavBarView];
    [self getData];
}

-(void)getData{
    [self requestData];
}
//获取公交车列表
-(void)requestData{
    NSString *cookid = [DCObjManager dc_readUserDataForKey:@"key"];
    if (cookid) {
        
        NSDictionary *dict=@{
                             @"condition":@"B12",
                             @"citycode":@"11"
                             };
        dict = nil;
        if (dict != nil) {
            [GCHttpDataTool getBusListWithDict:dict success:^(id responseObject) {
                [SVProgressHUD dismiss];
//                [SVProgressHUD showSuccessWithStatus:@"获取公交车列表成功！"];
            } failure:^(MQError *error) {
                [SVProgressHUD showErrorWithStatus:error.msg];
            }];
        }else{
            [GCHttpDataTool getBusListWithDict:nil success:^(id responseObject) {
                [SVProgressHUD dismiss];
//                [SVProgressHUD showSuccessWithStatus:@"获取公交车列表成功！"];
            } failure:^(MQError *error) {
                [SVProgressHUD showErrorWithStatus:error.msg];
            }];
        }
    }else{
        return;
    }
}
-(void)setupUI{
    [self.view addSubview:self.tableView];
//    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.edges.equalTo(self.view);
//    }];
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(K_HEIGHT_NAVBAR + DCNaviH);
        make.left.right.equalTo(self.view);
        make.bottom.equalTo(self.view);
    }];
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
//    DCZuoWenRightButton *cityNameBtn = [DCZuoWenRightButton buttonWithType:UIButtonTypeRoundedRect];
    DCZuoWenRightButton *cityNameBtn = [DCZuoWenRightButton buttonWithType:UIButtonTypeCustom];
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
    
    
    //搜索栏
    UIView *topSearchView = [[UIView alloc] init];
    topSearchView.backgroundColor = RGB(248, 248, 248);
    topSearchView.layer.cornerRadius = 16;
    [topSearchView.layer masksToBounds];
    [topView addSubview:topSearchView];
    
    [topSearchView mas_makeConstraints:^(MASConstraintMaker *make) {
        [make.left.mas_equalTo(self.cityNameBtn.mas_right)setOffset:5];
        [make.right.mas_equalTo(self.view)setOffset:-3];
        make.height.mas_equalTo(@33);
        make.centerY.mas_equalTo(topView);
    }];
    
    //    UISearchBar
    GKTextField *searchTF = [[GKTextField alloc]init];
    [self.view addSubview:searchTF];
    [searchTF setReturnKeyType:UIReturnKeyGo];
    [searchTF mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(topSearchView);
        make.top.mas_equalTo(topSearchView);
        make.height.mas_equalTo(topSearchView);
        [make.right.mas_equalTo(topSearchView)setOffset:-2*DCMargin];
    }];
    //搜索🔍logo
    UIImageView *search_btn = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"icon_search"]];
    searchTF.clearButtonMode = UITextFieldViewModeWhileEditing;     // 清除按钮的状态=只有在文本字段中编辑文本时，才会显示覆盖视图。
    //searchTF.keyboardType = UIKeyboardTypeASCIICapable;        //限制英文输入
    searchTF.placeholder = @"查询公交线路";
//    [searchTF setValue:[UIFont boldSystemFontOfSize:13] forKeyPath:@"_Label.font"];
    [searchTF setValue:[UIFont boldSystemFontOfSize:13] forKeyPath:@"_placeholderLabel.font"];
    
    searchTF.backgroundColor = RGBall(248);
    [searchTF setTextAlignment:NSTextAlignmentLeft];
    searchTF.leftView = search_btn;
    searchTF.delegate = self;
    searchTF.leftViewMode = UITextFieldViewModeAlways;
//    [searchTF setLeftMargin:15];
    searchTF.layer.masksToBounds = YES;
    searchTF.layer.cornerRadius = 15;
    self.searchTF = searchTF;
    
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
    return 100;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    GKBusInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:GKBusInfoCellID forIndexPath:indexPath];
    cell.hidden = YES;
    return cell;
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
//    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
//    GKBusMoreInfoViewController *vc = [[GKBusMoreInfoViewController alloc] init];
//    vc.title = @"信息详情";
//    [self.navigationController pushViewController:vc animated:YES];
}



#pragma mark - lazy load
-(UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, DCNaviH+K_HEIGHT_NAVBAR, ScreenW, ScreenH-DCNaviH-K_HEIGHT_NAVBAR) style:UITableViewStylePlain];//UITableViewStyleGrouped
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [_tableView registerNib:[UINib nibWithNibName:@"GKBusInfoCell" bundle:nil] forCellReuseIdentifier:GKBusInfoCellID];
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

- (void)touch{
    NSLog(@"touch!!!");
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
    [self.navigationController pushViewController:cityViewController animated:YES];
    
}

// 输入的回车键键
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [self actionCommodityStyleSearch];
    [textField endEditing:YES];
    return YES;
}
#pragma mark -执行不同的搜索事件

/**
 *  执行【列车信息】搜索
 */
- (void)actionCommodityStyleSearch {
//    [self hideInput];
//    [_datas removeAllObjects];
    NSString *searchString = [_searchTF text];
    if (![searchString isEqualToString:@""]) {
//        _datas = [GFRangeStyleResultDao searchDataByName:searchString];
        //执行搜索操作
    }else
    {
        [SVProgressHUD showSuccessWithStatus:@"请先输入您所要查找的内容！"];
    }
}



@end
