//
//  GKFeedBackRecordViewController.m
//  GKBusCharging
//
//  Created by 王宁 on 2018/10/08.
//  Copyright © 2018年 goockr. All rights reserved.
//


#import "GKFeedBackRecordViewController.h"
#import "GKFeedBackInfoViewController.h"
#import "GKFeedBackInfo2ViewController.h"

//#import "DCTabBarController.h"
////#import "DCRegisteredViewController.h"
// Models

// Views

// Vendors

// Categories

// Others
//#import "AFNetPackage.h"

#define HeaderImageHeight ScreenW/2

#define kLineSpacing DCMargin/2

@interface GKFeedBackRecordViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    NSIndexPath * _indexPath;
}
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic,strong)  NSMutableArray *dataSoucre;

@property (nonatomic,strong) UIView *noDatasView;

//@property (nonatomic,strong)  MQHudTool *hud;

@end

@implementation GKFeedBackRecordViewController
#pragma mark - lazy load
-(UITableView *)tableView{
//    if (!_tableView) {
//        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    //UITableViewStyleGrouped
//        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
//        [_tableView registerNib:[UINib nibWithNibName:@"GKBusInfoCell" bundle:nil] forCellReuseIdentifier:GKBusInfoCellID];
//        _tableView.backgroundColor = [UIColor colorWithRed:244/255.0 green:244/255.0 blue:244/255.0 alpha:1];
        _tableView.allowsSelection = YES;
//        _tableView.delegate = self;
//        _tableView.dataSource = self;
//    }
    return _tableView;
}

- (NSMutableArray *)dataSoucre
{
    if (_dataSoucre==nil) {
        _dataSoucre=[NSMutableArray array];
    }
    [_dataSoucre addObject:@"反馈记录"];
    return _dataSoucre;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"反馈记录";
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
    [messageLabel setText:@"暂无反馈记录"];
    messageLabel.textAlignment = NSTextAlignmentCenter;
    self.noDatasView = noDatasView;
//    blank_page_no_order
//    暂无订单详情
    [_dataSoucre addObject:@"www"];
    [_dataSoucre addObject:@"www"];
    [_dataSoucre addObject:@"www"];
    [_dataSoucre addObject:@"www"];
    [_dataSoucre addObject:@"www"];
//    [SVProgressHUD showInfoWithStatus:[NSString stringWithFormat:@"_dataSoucre.count = %lu",(unsigned long)[_dataSoucre count]]];
//    if (_dataSoucre == nil) {
//        [_tableView setHidden:true];
//        [_noDatasView setHidden:false];
//    }else{
        [_noDatasView setHidden:true];
//    }
}
#pragma mark -页面逻辑方法

- (void)getData{
    [self requestData];
}
//获取故障历史信息、报障历史列表
-(void)requestData{
    NSString *cookid = [DCObjManager dc_readUserDataForKey:@"key"];
    if (cookid) {
        
        NSDictionary *dict=@{
                          @"id":@"212423414"
                          };
        [GCHttpDataTool getFaultListWithDict:dict success:^(id responseObject) {
            [SVProgressHUD dismiss];
//            [SVProgressHUD showSuccessWithStatus:@"获取故障历史信息、报障历史列表成功！"];
            
        } failure:^(MQError *error) {
            [SVProgressHUD showErrorWithStatus:error.msg];
        }];
    }else{
        return;
    }
}
#pragma mark -用户交互方法



#pragma mark - UICollectionViewDelegate,UICollectionViewDataSource

#pragma mark collectionView代理方法

#pragma mark -tableView数据源
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 5;
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *ID = @"wine";
//    GKTFCell
    // 1.先去缓存池中查找可循环利用的cell
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    // 2.如果缓存池中没有可循环利用的cell
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }
    // 3.设置数据
//    cell.textLabel.text = [NSString stringWithFormat:@"%zd行的数据", indexPath.row];
    cell.textLabel.text = @"充电的时候出现了故障~";
    [cell.textLabel setFont:GKFontAndFontName(@"Regular",14)];
//    UITableViewCell *cell = [[UITableViewCell alloc]init];
    cell.detailTextLabel.text = @"2018/08/23 10:32:00";
    [cell.detailTextLabel setTextColor:TEXTGRAYCOLOR];
    [cell.detailTextLabel setFont:GKFont(12)];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    //    GKFeedBackInfoViewController *vc = [GKFeedBackInfoViewController new];
    GKFeedBackInfo2ViewController *vc = [GKFeedBackInfo2ViewController new];
    [self.navigationController pushViewController:vc animated:YES];
    
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
//    return KScreenScaleValue(55);
    return 55;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
//    return KScreenScaleValue(22);
    return 11;
}
@end
