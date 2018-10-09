//
//  GKNavigationController.m
//  GKBusCharging
//
//  Created by mrwang90hou on 2019/9/26.
//  Copyright © 2019年 mrwang90hou. All rights reserved.
//

#import "GKNavigationController.h"

// Controllers

// Models

// Views

// Vendors
#import "GQGesVCTransition.h"
// Categories
#import "UIBarButtonItem+DCBarButtonItem.h"
// Others

@interface GKNavigationController ()



@end

@implementation GKNavigationController

#pragma mark - load初始化一次
+ (void)load
{
    [self setUpBase];
}

#pragma mark - LifeCyle
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUp];
    
    [GQGesVCTransition validateGesBackWithType:GQGesVCTransitionTypePanWithPercentRight withRequestFailToLoopScrollView:YES]; //手势返回
}

#pragma mark - 初始化
+ (void)setUpBase
{
    UINavigationBar *bar = [UINavigationBar appearance];
//    bar.barTintColor = DCBGColor;
    bar.barTintColor = GFPink2Cokor;
    [bar setTintColor:[UIColor darkGrayColor]];
    bar.translucent = YES; 
    [bar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    [bar setBackgroundColor:[UIColor whiteColor]];
    NSMutableDictionary *attributes = [NSMutableDictionary dictionary];
    // 设置导航栏字体颜色
    UIColor * naiColor = [UIColor blackColor];
    attributes[NSForegroundColorAttributeName] = naiColor;
    attributes[NSFontAttributeName] = PFR18Font;
    bar.titleTextAttributes = attributes;
    
    //创建一个高20的假状态栏
    UIView *statusBarView = [[UIView alloc] initWithFrame:CGRectMake(0, -K_HEIGHT_NAVBAR, ScreenW, K_HEIGHT_NAVBAR)];
    //设置成绿色
    statusBarView.backgroundColor=[UIColor whiteColor];
    // 添加到 navigationBar 上
    [bar addSubview:statusBarView];
}

- (void)setUp{
//    self.navigationBar.backgroundColor = [UIColor grayColor];
    
//    self.view
}

#pragma mark - 返回
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated{
    
    if (self.childViewControllers.count >= 1) {
        //返回按钮自定义
        UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
        negativeSpacer.width = -15;
        
        UIButton *button = [[UIButton alloc] init];
        [button setImage:[UIImage imageNamed:@"btn_back_black_normal"] forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:@"btn_back_black_pressed"] forState:UIControlStateHighlighted];
        button.frame = CGRectMake(0, 0, 33, 33);
        
        if (@available(ios 11.0,*)) {
            button.contentEdgeInsets = UIEdgeInsetsMake(0, -15,0, 0);
            button.imageEdgeInsets = UIEdgeInsetsMake(0, -10,0, 0);
        }
        
        [button addTarget:self action:@selector(backButtonTapClick) forControlEvents:UIControlEventTouchUpInside];
        UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithCustomView:button];
        
        viewController.navigationItem.leftBarButtonItems = @[negativeSpacer, backButton];
        
        viewController.hidesBottomBarWhenPushed = YES;
        
        // 就有滑动返回功能
        self.interactivePopGestureRecognizer.delegate = nil;
    }
    //跳转
    [super pushViewController:viewController animated:animated];
}

#pragma mark - 点击
- (void)backButtonTapClick {
    [self popViewControllerAnimated:YES];
}


@end
