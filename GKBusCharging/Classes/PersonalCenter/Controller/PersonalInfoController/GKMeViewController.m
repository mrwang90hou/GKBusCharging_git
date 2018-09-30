//
//  GKMeViewController.m
//  Record
//
//  Created by 王宁 on 2018/9/30.
//  Copyright © 2018年 goockr. All rights reserved.
//

#import "GKMeViewController.h"
#import "GKMeDetailController.h"
#import "GKLoginController.h"

#import "GKMeCell.h"
#import "GKMeHeaderView.h"
#import "GKDetailCell.h"

@interface GKMeViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,assign) BOOL isNeedNav;
@property (nonatomic,strong) UILabel *dataLabel;
@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,assign) NSInteger indexPath;
@property (nonatomic,strong) NSIndexPath *nsIndexPath;
@end

@implementation GKMeViewController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.isNeedNav = YES;
    [self.navigationController setNavigationBarHidden:YES animated:animated];
    [self.navigationController.navigationBar setBarStyle:UIBarStyleBlack];
    
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    if (self.isNeedNav == NO) {
        [self.navigationController setNavigationBarHidden:YES animated:animated];
        [SVProgressHUD showInfoWithStatus:@"setNavigationBarHidden:YES"];
    }else{
        [self.navigationController setNavigationBarHidden:NO animated:animated];
    }
//    self.hidesBottomBarWhenPushed = YES;
    [self.navigationController.navigationBar setBarStyle:UIBarStyleDefault];
}

- (UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"我的";
    self.view.backgroundColor = TABLEVIEW_BG;
    GKMeHeaderView * headerView = [[GKMeHeaderView alloc] initWithFrame:CGRectZero];
    [self.view addSubview:headerView];
    MJWeakSelf;
    [headerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.equalTo(weakSelf.view);
        make.height.mas_equalTo(212);
        make.width.mas_equalTo(SCREEN_WIDTH);
    }];
    [headerView.nameBtn addTarget:self action:@selector(loginBtnClick) forControlEvents:UIControlEventTouchUpInside];
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
    self.isNeedNav = YES;
    [self.navigationController pushViewController:[GKLoginController new] animated:YES]; 
}
- (void)getData{
    _dataLabel = [UILabel new];
    _dataLabel.text = @"2M";
}
#pragma mark -实现UITableViewDataSource
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *reuseIdentity = @"GKMeCell";
    GKMeCell * cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentity];
    if (cell == nil) {
        cell = [[GKMeCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentity];
    }
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            cell.desLabel.text = @"个人资料";
            cell.iconImageView.image = [UIImage imageNamed:@"icon_personal_data"];
        }else if (indexPath.row == 1){
            cell.desLabel.text = @"使用帮助";
            cell.iconImageView.image = [UIImage imageNamed:@"icon_use_help"];
        }else if (indexPath.row == 2){
            cell.desLabel.text = @"清理缓存";
            cell.iconImageView.image = [UIImage imageNamed:@"icon_delete"];
            //动态加载 UIlabel
            //加载缓存空间【获取当前缓存空间大小】
            [self getData];
            cell.endLabel.text = _dataLabel.text;
            
//            cell.endLabel.text = @"0M";
        }
    }else if (indexPath.section == 1) {
        if (indexPath.row == 0) {
            cell.desLabel.text = @"意见反馈";
            cell.iconImageView.image = [UIImage imageNamed:@"icon_feedback"];
        }else if (indexPath.row == 1){
            cell.desLabel.text = @"关于我们";
            cell.iconImageView.image = [UIImage imageNamed:@"icon_about_us"];
        }
    }
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return 3;
    }else{
        return 2;
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
                self.indexPath = indexPath.row;
                _nsIndexPath = indexPath;
                [self initAlertView];
            case 3:
                break;
            case 4:
                break;
            default:
                break;
        }
    }//第二栏
    else if (indexPath.section == 1){
        switch (indexPath.row) {
            case 0:
//                [self initAlertView];
                break;
            case 1:
                break;
            case 2:
                break;
            default:
                break;
        }
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
#pragma mark -清除缓存操作
/**
 *执行清除缓存操作
 */
-(void)clearCacheAction{
    //退出登录操作
//    [GKUserDao requestLogoutOn:self block:^(GFUserVo *mUserVo) {
//        // 清空缓存数据
//        mUserVo.isLogin = NO;
//        [GFUserDao saveUserInfo:mUserVo];
//        // 跳转回登录界面
//        GFLoginViewController *mLoginVC = [[GFLoginViewController alloc]init];
//        UINavigationController *navigationController = [[UINavigationController alloc]initWithRootViewController:[[GFLoginViewController alloc]init]];
//        [mLoginVC showNoticeHudWithTitle:NSNewLocalizedString(@"my_logout_success", nil) subtitle:NSNewLocalizedString(@"my_logout_success", nil) onView:navigationController.view inDuration:2];
//        [UIApplication sharedApplication].keyWindow.rootViewController = navigationController;
//    }];
    [SVProgressHUD showSuccessWithStatus:@"清除成功"];
    _dataLabel.text = @"0M";
    GKMeCell *cell = [self.tableView cellForRowAtIndexPath:self.nsIndexPath];
//    cell.desLabel.text = _dataLabel.text;
    cell.endLabel.text = _dataLabel.text;
    //刷新 dataLabel 中的数据
}
#pragma mark -弹出窗
-(void)initAlertView{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"是否有清除缓存?" preferredStyle:(UIAlertControllerStyleAlert)];
    UIAlertAction *logoutAction     = [UIAlertAction actionWithTitle:@"确认" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
        //清除缓存操作
        [self clearCacheAction];
    }];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:(UIAlertActionStyleCancel) handler:nil];
    [alert addAction:logoutAction];
    [alert addAction:cancelAction];
    [self presentViewController:alert animated:YES completion:nil];
}


@end
