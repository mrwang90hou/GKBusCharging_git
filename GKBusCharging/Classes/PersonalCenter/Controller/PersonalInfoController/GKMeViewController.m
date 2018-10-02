//
//  GKMeViewController.m
//  GKBusCharging
//
//  Created by 王宁 on 2018/9/30.
//  Copyright © 2018年 goockr. All rights reserved.
//

#import "GKMeViewController.h"
#import "GKMeDetailController.h"
#import "GKLoginController.h"
#import "GKChangeNameController.h"

#import "AppDelegate.h"

#import "GKMeCell.h"
#import "GKMeHeaderView.h"
#import "GKDetailCell.h"

//@interface GKMeViewController ()<UITableViewDelegate,UITableViewDataSource>
@interface GKMeViewController ()<UITableViewDataSource>
//@property (nonatomic,assign) BOOL isNeedNav;
//@property (nonatomic,strong) UILabel *dataLabel;
@property (nonatomic,strong) NSMutableArray *statusArray;
@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,assign) NSInteger indexPath;
@property (nonatomic,strong) NSIndexPath *nsIndexPath;
@property (nonatomic,strong) GKMeHeaderView *headerView;

@end

@implementation GKMeViewController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
//    [self getUI];
//    self.isNeedNav = YES;
//    [self.navigationController setNavigationBarHidden:YES animated:animated];
//    [self.navigationController.navigationBar setBarStyle:UIBarStyleBlack];
    
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
//    if (self.isNeedNav == NO) {
//        [self.navigationController setNavigationBarHidden:YES animated:animated];
//        [SVProgressHUD showInfoWithStatus:@"setNavigationBarHidden:YES"];
//    }else{
//        [self.navigationController setNavigationBarHidden:NO animated:animated];
//    }
    
//    self.hidesBottomBarWhenPushed = YES;
//    [self.navigationController.navigationBar setBarStyle:UIBarStyleDefault];
    [[NSNotificationCenter defaultCenter] postNotificationName:KNotiUserNameChange object:nil];
}

- (UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"个人中心";
    self.view.backgroundColor = TABLEVIEW_BG;
    [self getData];
    [self getUI];
    [self addObserver];
}


- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark -页面逻辑方法
- (void) addObserver
{
    //
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateUIReload2) name:KNotiUserNameChange object:nil];
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateUIReload2) name:KNotiPhoneNumberChange object:nil];
    //
    //    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(receiveNotiDeivceDisconnect) name:KNotiDeviceDisconnectFormServe object:nil];
    //    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(trunToQRCode) name:@"trunToQRCode" object:nil];
}
-(void)updateUIReload2{
//    [SVProgressHUD showInfoWithStatus:@"updateUIReload2"];
    if ([DCObjManager dc_readUserDataForKey:@"UserName"] != nil) {
        [self.headerView.nameLabel setText:[DCObjManager dc_readUserDataForKey:@"UserName"]];
    }else{
        [self.headerView.nameLabel setText:@"昵称"];
    }
    [SVProgressHUD showInfoWithStatus:[DCObjManager dc_readUserDataForKey:@"UserName"]];
}


-(void)getUI{
    GKMeHeaderView * headerView = [[GKMeHeaderView alloc] initWithFrame:CGRectZero];
    [self.view addSubview:headerView];
    MJWeakSelf;
    [headerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.equalTo(weakSelf.view);
        make.height.mas_equalTo(ScreenH/5*2);
        make.width.mas_equalTo(SCREEN_WIDTH);
    }];
    [headerView.changeNameBtn addTarget:self action:@selector(changeUserName) forControlEvents:UIControlEventTouchUpInside];
    self.headerView = headerView;
    
    //    UITableView * tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    [self.view addSubview:_tableView];
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(headerView.mas_bottom);
        make.left.right.bottom.equalTo(weakSelf.view);
    }];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.scrollEnabled = NO;
}

#pragma mark -立即登录按钮
- (void)loginBtnClick{
//    self.isNeedNav = NO;
//    self.isNeedNav = YES;
    [self.navigationController pushViewController:[GKLoginController new] animated:YES];
}
- (void)getData{
    _statusArray = [[NSMutableArray alloc]init];
    NSArray *arr = @[@0,@1,@0];
//    _statusArray = [NSMutableArray arrayWithCapacity:arr];
    
//    _statusArray = [arr mutableCopy];

    for (int i = 0; i<arr.count; i++) {
        if ([arr[i] intValue] == 1) {
            [_statusArray addObject:@"已绑定"];
        }else{
            [_statusArray addObject:@"立即绑定"];
        }
//        NSLog(@"_statusArray = %@",[_statusArray objectAtIndex:i]);
    }
}
#pragma mark -实现UITableViewDataSource
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *reuseIdentity = @"GKMeCell";
    GKMeCell * cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentity];
    if (cell == nil) {//UITableViewCellStyleSubtitle     UITableViewCellStyleValue2
        cell = [[GKMeCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:reuseIdentity];
    }
    
    cell.endLabel.text = [_statusArray objectAtIndex:indexPath.row];
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            cell.desLabel.text = @"手机";
            cell.endLabel.text = [_statusArray objectAtIndex:0];
            cell.accessoryType = [[_statusArray objectAtIndex:0] length]==4 ? UITableViewCellAccessoryDisclosureIndicator:UITableViewCellAccessoryNone;
        }else if (indexPath.row == 1){
            cell.desLabel.text = @"微信";
            cell.endLabel.text =  [_statusArray objectAtIndex:1];
            cell.accessoryType = [[_statusArray objectAtIndex:0] length]==4 ? UITableViewCellAccessoryDisclosureIndicator:UITableViewCellAccessoryNone;
        }else if (indexPath.row == 2){
            cell.desLabel.text = @"支付宝";
            cell.endLabel.text =  [_statusArray objectAtIndex:2];
            cell.accessoryType = [[_statusArray objectAtIndex:0] length]==4 ? UITableViewCellAccessoryDisclosureIndicator:UITableViewCellAccessoryNone;
        }
        
        cell.textLabel.text = cell.desLabel.text;
        cell.detailTextLabel.text = [_statusArray objectAtIndex: indexPath.row];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.accessoryType = [[_statusArray objectAtIndex:indexPath.row] length]==4 ? UITableViewCellAccessoryDisclosureIndicator:UITableViewCellAccessoryNone;
        cell.userInteractionEnabled = [[_statusArray objectAtIndex:indexPath.row] length]==4 ? YES:NO;
//        cell.accessoryType = UITableViewCellAccessoryNone;
//        cell.detailTextLabel.text = @"wangning";
//        cell.textLabel.text = @"textLabel";
//        cell.l
//        NSLog(@"[_statusArray objectAtIndex:0] containsObject:@‘已’] = %d\n[_statusArray objectAtIndex:0] count]= %lu",[[_statusArray objectAtIndex:0] containsObject:@"已"],(unsigned long)[[_statusArray objectAtIndex:0] count]);
    }else{
        UITableViewCell * cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"LYChatGroupSettingDefault"];
        cell.backgroundColor = [UIColor clearColor];
        tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        GKButton * logoutBtn = [GKButton new];
        [cell.contentView addSubview:logoutBtn];
        [logoutBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.equalTo(cell.contentView);
            make.centerX.equalTo(cell.contentView.mas_centerX);
            make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH - 40, 44));
        }];
        [logoutBtn setupCircleButton];
        logoutBtn.titleLabel.font = GKMediumFont(16);
        [logoutBtn setTitle:@"退出登录" forState:UIControlStateNormal];
        [logoutBtn addTarget:self action:@selector(logoutBtnClick) forControlEvents:UIControlEventTouchUpInside];
        return cell;
    }
    
    return cell;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return 3;
    }else{
        return 1;
    }
}

//【可选的方法】表视图中的节数
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

#pragma mark -实现UITableViewDelegate
//在索引路径中选择每行的事件
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
//    if (indexPath.section == 0 && indexPath.row == 0) {
//        [self.navigationController pushViewController:[GKMeDetailController new] animated:YES];
//    }
    if (indexPath.section == 0) {
        switch (indexPath.row) {
            case 0:
                [self.navigationController pushViewController:[GKMeDetailController new] animated:YES];
                break;
            case 1:
                
                break;
            case 2://弹窗
//                self.indexPath = indexPath.row;
                [self initAlertView];
            case 3:
                break;
            case 4:
                break;
            default:
                break;
        }
        _nsIndexPath = indexPath;
    }
}
//索引路径的行高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 54;
}
//部分中的头视图
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *headerView = [[UIView alloc]init];
    return headerView;
}
//尾部试图
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView *footerView = [[UIView alloc]init];
    return footerView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 15;
}

#pragma mark -弹出窗
-(void)initAlertView{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"是否跳转进行绑定?" preferredStyle:(UIAlertControllerStyleAlert)];
    UIAlertAction *logoutAction     = [UIAlertAction actionWithTitle:@"确认" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
        //清除缓存操作
        [self clearCacheAction];
    }];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:(UIAlertActionStyleCancel) handler:nil];
    [alert addAction:logoutAction];
    [alert addAction:cancelAction];
    [self presentViewController:alert animated:YES completion:nil];
}
#pragma mark -绑定操作
/**
 *执行清除缓存操作
 */
-(void)clearCacheAction{
    [SVProgressHUD showSuccessWithStatus:@"正在绑定。。。"];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [SVProgressHUD dismiss];
        [SVProgressHUD showSuccessWithStatus:@"绑定成功"];
        GKMeCell *cell = [self.tableView cellForRowAtIndexPath:self.nsIndexPath];
//        cell.textLabel.text = @"绑定成功";
        [self.statusArray replaceObjectAtIndex:self.nsIndexPath.row withObject:@"已绑定"];
        cell.accessoryType = UITableViewCellAccessoryNone;
        cell.userInteractionEnabled = NO;
    });
}
#pragma mark -(注销)退出登录操作
- (void)logoutBtnClick{
    UIAlertController *alert    = [UIAlertController alertControllerWithTitle:@"确认退出?" message:@"退出登录将无法查看个人信息,重新登录后即可查看" preferredStyle:(UIAlertControllerStyleAlert)];
    UIAlertAction *logoutAction     = [UIAlertAction actionWithTitle:@"确认" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
        //执行注销
        [self logoutSure];
        //返回根视图
//        [self.navigationController popToRootViewControllerAnimated:YES];
    }];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:(UIAlertActionStyleCancel) handler:nil];
    [alert addAction:logoutAction];
    [alert addAction:cancelAction];
    [self presentViewController:alert animated:YES completion:nil];
}

-(void) logoutSure{
    
        [SVProgressHUD showWithStatus:@"正在注销..."];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [SVProgressHUD dismiss];
            [DCObjManager dc_saveUserData:@"0" forKey:@"isLogin"];
            [SVProgressHUD showSuccessWithStatus:@"注销成功！"];
            AppDelegate *app=(AppDelegate *)[UIApplication sharedApplication].delegate;
            [app autoLogin];
        });
}
-(void)changeUserName{
    [self.navigationController pushViewController:[GKChangeNameController new] animated:YES];
}

@end
