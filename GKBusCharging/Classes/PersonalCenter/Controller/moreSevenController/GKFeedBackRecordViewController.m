//
//  GKFeedBackRecordViewController.m
//  GKBusCharging
//
//  Created by 王宁 on 2018/10/08.
//  Copyright © 2018年 goockr. All rights reserved.
//


#import "GKFeedBackRecordViewController.h"


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
        _tableView.allowsSelection = NO;
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
    return _dataSoucre;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"反馈记录";
    [self getUI];
    [self getData];
}

- (void)getUI{
    
}
#pragma mark -页面逻辑方法

- (void)getData{
    
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
//    PermissionsDeviceCell *cell=[PermissionsDeviceCell cellWithTableView:tableView];
//    UITableViewCell *cell=[UITableViewCell cellWithTableView:tableView];
//    UITableViewCell *cell=[UITableViewCell alloc]initWithCoder:<#(nonnull NSCoder *)#>;
    
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
//    UITableViewCell *cell = [[UITableViewCell alloc]init];
    cell.detailTextLabel.text = @"2018/08/23 10:32:00";
    [cell.detailTextLabel setTextColor:TEXTGRAYCOLOR];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
//    cell.
    return cell;
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    GKBaseSetViewController *vc = [GKBaseSetViewController new];
    vc.title = @"反馈详情";
    [self.navigationController pushViewController:vc animated:YES];
    
}
//- (nullable NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
//    return @"向左滑动删除";
//}

-(void)tableView:(UITableView *)tableView willDisplayHeaderView:(UIView *)view forSection:(NSInteger)section

{
//    UITableViewHeaderFooterView *header = (UITableViewHeaderFooterView *)view;
//    header.textLabel.textColor = [UIColor grayColor];
//    header.textLabel.font = [UIFont boldSystemFontOfSize:12];
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

/**
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

-(BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

 *  左滑cell时出现什么按钮
- (NSArray *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSArray * array;
    
    //    if ([self.editButtonItem.title isEqualToString:@"编辑"]) {
    //        return self.tableView.indexPathsForSelectedRows;;
    //    }
    //
    UITableViewRowAction *action = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDefault title:@"删除" handler:^(UITableViewRowAction *action, NSIndexPath *indexPath) {
        _indexPath = indexPath;
        [self makeSure];
    }];
    
    array = @[action];
    
    return array;
}

//删除的二次确认
-(void)makeSure
{
    SIAlertView *alertView = [[SIAlertView alloc] initWithTitle:@"提示" andMessage:@"确认删除？"];
    
    [alertView addButtonWithTitle:@"取消"
                             type:SIAlertViewButtonTypeDefault
                          handler:^(SIAlertView *alertView) {
                              
                              [alertView dismissAnimated:NO];
                              
                          }];
    
    [alertView addButtonWithTitle:@"确定"
                             type:SIAlertViewButtonTypeDefault
                          handler:^(SIAlertView *alertView) {
                              
                              [alertView dismissAnimated:NO];
                              [self deleteDeviceWithIndexPath];
                              
                          }];
    
    [alertView show];
}

-(void)deleteDeviceWithIndexPath
{
    [self.hud addNormHudWithSupView:self.view title:@"正在删除..."];
    
    GCDevice * device = self.dataSoucre[_indexPath.row];
    
    NSDictionary * dic = @{@"mobile":[GCUser getInstance].mobile,@"token":[GCUser getInstance].token,@"devcode":device.deviceId};
    [GCHttpDataTool delDeviceRefWithDict:dic success:^(id responseObject) {
        
        [self.hud hide];
        NSLog(@" 删除结果 == %@",responseObject);
        if (responseObject[@"result"] && [responseObject[@"result"] intValue] == 0) {
            
            [[GCUser getInstance].deviceList removeObject:device];
            
            if ([GCUser getInstance].device.deviceId == device.deviceId) {
                if ([GCUser getInstance].deviceList.count > 0) {
                    [GCUser getInstance].device = [GCUser getInstance].deviceList[0];
                }else
                {
                    [GCUser getInstance].device = nil;
                }
            }
            
            [self getData];
            
            [self.tableView reloadData];
            
            [[NSNotificationCenter defaultCenter] postNotificationName:KNotiSelectDeviceChange object:nil];
        }
        
    } failure:^(MQError *error) {
        [self.hud hudUpdataTitile:@"删除失败" hideTime:1.2];
    }];
}

-(MQHudTool *)hud
{
    if (_hud==nil) {
        _hud=[[MQHudTool alloc] init];
    }
    
    return _hud;
}



-(UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return   UITableViewCellEditingStyleDelete;
}

 */
@end
