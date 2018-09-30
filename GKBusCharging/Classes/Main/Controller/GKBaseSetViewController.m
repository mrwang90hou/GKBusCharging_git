
//
//  GKBaseSetViewController.m
//  GKBusCharging
//
//  Created by mrwang90hou on 2019/9/26.
//Copyright © 2019年 mrwang90hou. All rights reserved.
//

#import "GKBaseSetViewController.h"
#import "GKNavigationController.h"
#import "GKHomeViewController.h"
// Controllers
//#import "DCTabBarController.h"
// Models

// Views

// Vendors

// Categories

// Others

@interface GKBaseSetViewController ()

@end

@implementation GKBaseSetViewController

#pragma mark - LazyLoad

#pragma mark - LifeCyle
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
//    [self.navigationController setNavigationBarHidden:YES animated:animated];
    [self setUpAcceptNote];
}

#pragma mark - 接受跟换控制
- (void)setUpAcceptNote
{
    [[NSNotificationCenter defaultCenter]addObserverForName:LOGINSELECTCENTERINDEX object:nil queue:[NSOperationQueue mainQueue] usingBlock:^(NSNotification * _Nonnull note) {
        // 正常登录成功，跳转至主界面
//        [SVProgressHUD showSuccessWithStatus:@"跳转至主页面！"];
        GKNavigationController *navigationController = [[GKNavigationController alloc]initWithRootViewController:[[GKHomeViewController alloc]init]];
        [UIApplication sharedApplication].keyWindow.rootViewController = navigationController;
    }];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
//    [self.navigationController setNavigationBarHidden:NO animated:animated];
}

#pragma mark - LifeCyle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
//    self.automaticallyAdjustsScrollViewInsets = NO;
}

//- (void)dealloc
//{
//    [[NSNotificationCenter defaultCenter] removeObserver:self];
//}

@end
