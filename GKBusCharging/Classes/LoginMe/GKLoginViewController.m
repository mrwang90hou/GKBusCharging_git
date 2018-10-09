//
//  GKLoginViewController.m
//  GKBusCharging
//
//  Created by 王宁 on 2018/9/29.
//  Copyright © 2018年 goockr. All rights reserved.
//


#import "GKLoginViewController.h"

// Controllers
#import "GKNavigationController.h"
#import "GKHomeViewController.h"
////#import "DCRegisteredViewController.h"

#import "GKServiceTermsViewController.h"
// Models

// Views
//#import "GKAccountPsdByPhoneView.h" //账号密码登录
////#import "DCVerificationView.h" //验证码登录
#import "GKSignInCodeView.h"
// Vendors

// Categories

// Others

@interface GKLoginViewController ()

/* 上一次选中的按钮 */
@property (strong , nonatomic)UIButton *selectBtn;
/* indicatorView */
@property (strong , nonatomic)UIView *indicatorView;
/* titleView */
@property (strong , nonatomic)UIView *titleView;
/* contentView */
@property (strong , nonatomic)UIScrollView *contentView;

///* 验证码 */
//@property (strong , nonatomic)DCVerificationView *verificationView;
///* 账号密码登录 */
//@property (strong , nonatomic)GKAccountPsdByPhoneView *accountPsdView;


@property (nonatomic,strong) UIView *loginByPhoneView;

@property (nonatomic, strong) HMSegmentedControl *segmentedControl;

@property (nonatomic,strong) GKSignInCodeView *signInCodeView;

@property (nonatomic,strong) UIView *bgView;

@end

@implementation GKLoginViewController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar setHidden:true];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.navigationController.navigationBar setHidden:false];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    [self sertUpBase];
    
//    [self setUpTiTleView];
    
//    [self setUpAcceptNote];
}

#pragma mark - 接受跟换控制
- (void)setUpAcceptNote
{
    [[NSNotificationCenter defaultCenter]addObserverForName:LOGINSELECTCENTERINDEX object:nil queue:[NSOperationQueue mainQueue] usingBlock:^(NSNotification * _Nonnull note) {
        // 正常登录成功，跳转至主界面
        //        [SVProgressHUD showSuccessWithStatus:@"跳转至主页面！"];
        //        GKNavigationController *navigationController = [[GKNavigationController alloc]initWithRootViewController:[[GKHomeViewController alloc]init]];
        //        [UIApplication sharedApplication].keyWindow.rootViewController = navigationController;
    }];
}

#pragma mark - base
- (void)sertUpBase {
    self.view.backgroundColor = [UIColor whiteColor];
    self.automaticallyAdjustsScrollViewInsets = false;
}

#pragma mark - 标题登录
- (void)setUpTiTleView
{
    _titleView = [UIView new];
    _titleView.frame = CGRectMake(0, 0, ScreenW, 35);
    
    NSArray *titleArray = @[@"账号密码登录",@"短信验证登录"];
    CGFloat buttonW = (_titleView.dc_width - 30) / 2;
    CGFloat buttonH = _titleView.dc_height - 3;
    CGFloat buttonX = 15;
    CGFloat buttonY = 0;
    for (NSInteger i = 0; i < titleArray.count; i++) {
        
        UIButton *button = [UIButton  buttonWithType:UIButtonTypeCustom];
        [button setTitle:titleArray[i] forState:UIControlStateNormal];
        button.titleLabel.font = PFR16Font;
        button.tag = i;
        [button setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
        button.frame = CGRectMake((i * buttonW) + buttonX, buttonY, buttonW, buttonH);
        [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        [_titleView addSubview:button];
    }
    
    UIButton *firstButton = _titleView.subviews[0];
    [self buttonClick:firstButton];
    
    _indicatorView = [UIView new];
    _indicatorView.backgroundColor = [firstButton titleColorForState:UIControlStateSelected];
    [firstButton.titleLabel sizeToFit];
    _indicatorView.dc_height = 2;
    _indicatorView.dc_width = firstButton.titleLabel.dc_width;
    _indicatorView.dc_centerX = firstButton.dc_centerX;
    _indicatorView.dc_y = _titleView.dc_bottom - _indicatorView.dc_height;
    [_titleView addSubview:_indicatorView];
    
    self.contentView.contentSize = CGSizeMake(ScreenW * titleArray.count, 0);
}


#pragma mark - 按钮点击
- (void)buttonClick:(UIButton *)button
{
    button.selected = !button.selected;
    [_selectBtn setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    [button setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    
    _selectBtn = button;
    
    WEAKSELF
    [UIView animateWithDuration:0.25 animations:^{
        weakSelf.indicatorView.dc_width = button.titleLabel.dc_width;
        weakSelf.indicatorView.dc_centerX = button.dc_centerX;
    }];
    
    CGPoint offset = _contentView.contentOffset;
    offset.x = _contentView.dc_width * button.tag;
    [_contentView setContentOffset:offset animated:YES];
}

#pragma mark - 内容

#pragma mark - 退出当前界面
- (IBAction)dismissViewController {
    [SVProgressHUD showInfoWithStatus:@"点击关闭退出按钮！"];
    
    [self.view endEditing:YES];
    [self dismissViewControllerAnimated:YES completion:nil];
}


- (IBAction)weChatLoginAction:(id)sender {
    
    [SVProgressHUD showErrorWithStatus:@"暂未开通！"];
}

- (IBAction)aliPayLoginAction:(id)sender {
    
    [SVProgressHUD showErrorWithStatus:@"暂未开通！"];
}


- (IBAction)loginByPhone:(UIButton *)sender {
    
//    self.loginByPhoneView.hidden = true;
    [self setUILoginByPhoneView];
    
    
}

-(void)setUILoginByPhoneView{
    
    
    // 大背景
    UIView *bgView = [[UIView alloc] init];
    [[[[UIApplication sharedApplication] delegate] window] addSubview:bgView];
    bgView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.4];
    [bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsMake(0, 0, 0, 0));
    }];
    self.bgView = bgView;
    //整体的布局view
    GKSignInCodeView *totalView = [GKSignInCodeView new];
    [bgView addSubview:totalView];
    [totalView setBackgroundColor:[UIColor whiteColor]];
    [totalView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(bgView);
        make.centerY.mas_equalTo(bgView).mas_offset(0);
        make.left.mas_equalTo(bgView.mas_left).with.offset(ScreenW/10);
        make.right.mas_equalTo(bgView.mas_right).with.offset(-ScreenW/10);
        make.height.mas_equalTo(totalView.mas_width);
        //make.width.mas_equalTo(200);
    }];
    [totalView.cancelButton addTarget:self action:@selector(close) forControlEvents:UIControlEventTouchUpInside];
    totalView.layer.masksToBounds = YES;
    totalView.layer.cornerRadius = 8;
    self.signInCodeView = totalView;
    
}

-(void)close{
    [self.bgView removeFromSuperview];
}

- (IBAction)serviceContractAction:(id)sender {
//    [SVProgressHUD showInfoWithStatus:@"服务协议！"];
    [self.navigationController pushViewController:[GKServiceTermsViewController new] animated:YES];
}


-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    NSInteger index = scrollView.contentOffset.x / scrollView.dc_width;
    UIButton *button = _titleView.subviews[index];
    
    [self buttonClick:button];
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}

@end
