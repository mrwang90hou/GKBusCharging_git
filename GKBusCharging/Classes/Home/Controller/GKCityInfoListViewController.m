//
//  GKCityInfoListViewController.m
//  GKBusCharging
//
//  Created by 王宁 on 2018/11/2.
//  Copyright © 2018年 goockr. All rights reserved.
//


#import "GKCityInfoListViewController.h"

// Controllers
#import "GKNavigationController.h"
#import "DCGMScanViewController.h"
#import "JFCityViewController.h"
#import "SDCycleScrollView.h"
#import "GKBusMoreInfoViewController.h"

//#import "DCTabBarController.h"
////#import "DCRegisteredViewController.h"
// Models
#import "GKBusListModel.h"
// Views
#import "GKPersonalHeaderView.h"
#import "GKCustomFlowLayout.h"
#import "GKCityInfoCell.h"

// Vendors

// Categories

#import "GKUpDownButton.h"
#import "DCZuoWenRightButton.h"
// Others
//#import "AFNetPackage.h"

#define HeaderImageHeight ScreenW/2

#define kLineSpacing DCMargin/2

static NSString *GKCityInfoCellID = @"GKCityInfoCell";

@interface GKCityInfoListViewController ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *evaluations;

@property (nonatomic,strong) GKTextField *searchTF;


@property (nonatomic,strong) UIButton *cityNameBtn;

@property (nonatomic,strong) NSArray *cityListModelData;
@end

@implementation GKCityInfoListViewController
#pragma mark - LazyLoad

//-(NSMutableArray *)busListModelData{
//    if (!_busListModelData) {
//        _busListModelData = [NSMutableArray array];
//    }
//    return _busListModelData;
//}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"切换城市";
    [self getData];
    [self setupUI];
    [self setUpNavBarView];
}

-(void)getData{
    [self requestData:nil];
}

//获取城市列表
-(void)requestData:(NSDictionary *)dict{
     //获取城市列表
     NSString *cookid = [DCObjManager dc_readUserDataForKey:@"key"];
     if (cookid) {
         //        NSDictionary *dict=@{
         //                         @"condition":@"贵阳"
         //                         };
         [GCHttpDataTool getCityListWithDict:dict success:^(id responseObject) {
             NSMutableArray *cityListData = responseObject[@"list"];
             NSMutableArray *cityListModelData = [NSMutableArray array];
             for (NSDictionary *dic in cityListData) {
                 GKCityListModel *model = [GKCityListModel new];
                 model.iid = dic[@"id"];
                 model.isNewRecord = [dic[@"isNewRecord"] intValue];
                 model.cityName = dic[@"cityName"];
                 model.cityCode = dic[@"cityCode"];
                 model.latitude = dic[@"latitude"];
                 model.longitude = dic[@"longitude"];
                 [cityListModelData addObject:model];
             }
             self.cityListModelData = [cityListModelData mutableCopy];
             [self.tableView reloadData];
         } failure:^(MQError *error) {
             [SVProgressHUD showErrorWithStatus:error.msg];
         }];
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
    
    //搜索栏
    UIView *topSearchView = [[UIView alloc] init];
    topSearchView.backgroundColor = RGB(248, 248, 248);
    topSearchView.layer.cornerRadius = 16;
    [topSearchView.layer masksToBounds];
    [topView addSubview:topSearchView];
    
    [topSearchView mas_makeConstraints:^(MASConstraintMaker *make) {
        [make.left.mas_equalTo(self.view)setOffset:10];
        [make.right.mas_equalTo(self.view)setOffset:-10];
        make.height.mas_equalTo(@38);
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
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return section == 0 ? 1 : self.cityListModelData.count;
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 70;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *rncell = [[UITableViewCell alloc]init];
    if (indexPath.section == 0) {
        GKCityInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:GKCityInfoCellID forIndexPath:indexPath];
        cell.model = self.cityListModelData[indexPath.row];
        [cell.cityNameLabel setTextColor:BUTTONMAINCOLOR];
//        cell.ifSetNewFrame = 0;
        rncell = cell;
    }else{
        GKCityInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:GKCityInfoCellID forIndexPath:indexPath];
        cell.model = self.cityListModelData[indexPath.row];
        [cell.cityNameLabel setTextColor:[UIColor blackColor]];
//        cell.ifSetNewFrame = 1;
        rncell = cell;
    }
    rncell.selectionStyle = NSDateFormatterNoStyle;
    return rncell;
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    GKCityInfoCell *cell = (GKCityInfoCell *)[tableView cellForRowAtIndexPath:indexPath];
//    GKCityInfoCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
    if (self.choseCityBlock) {
        self.choseCityBlock(cell.cityNameLabel.text);
    }
//    NSLog(@"cell.cityNameLabel.text = %@",cell.cityNameLabel.text);
//    [self dismissViewControllerAnimated:YES completion:nil];
    [self.navigationController popToViewController:[self.navigationController.viewControllers objectAtIndex:0] animated:YES];
}

- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{

    UIView *uiView = [[UIView alloc]init];
    [uiView setBackgroundColor:TABLEVIEW_BG];
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(10, 5, 120, 22)];
    //    label.dc_centerY = uiView.bounds.origin.y;
    if (section == 0) {
        [label setText:@"定位城市"];
    }else{
        [label setText:@"热门城市"];
    }
    [label setFont:GKFont(12)];
    [label setTextColor:RGBall(153)];
    [uiView addSubview:label];
    return uiView;
}


#pragma mark - lazy load
-(UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, DCNaviH+K_HEIGHT_NAVBAR, ScreenW, ScreenH-DCNaviH-K_HEIGHT_NAVBAR) style:UITableViewStylePlain];//UITableViewStyleGrouped
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [_tableView registerNib:[UINib nibWithNibName:@"GKCityInfoCell" bundle:nil] forCellReuseIdentifier:GKCityInfoCellID];
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
// 输入的回车键键
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [self actionCommodityStyleSearch];
    [textField endEditing:YES];
    return YES;
}
#pragma mark -执行不同的搜索事件

/**
 *  执行【城市】搜索
 */
- (void)actionCommodityStyleSearch {
    NSString *searchString = [_searchTF text];
    if (![searchString isEqualToString:@""]) {
        NSDictionary *dict=@{@"condition":searchString};
        [self requestData:dict];
    }else
    {
        [self requestData:nil];
    }
}
- (void)choseCityBlock:(JFCityViewControllerBlock)block {
    self.choseCityBlock = block;
}


@end
