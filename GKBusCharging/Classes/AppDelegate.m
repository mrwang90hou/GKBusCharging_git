//
//  AppDelegate.m
//  GKBusCharging
//
//  Created by mrwang90hou on 2018/9/26.
//  Copyright © 2018年 goockr. All rights reserved.
//

#import "AppDelegate.h"
#import "GKHomeViewController.h"
#import "GKNavigationController.h"
//#import "CYLTabBarControllerConfig.h"
//#import "GKWatchPhotoViewController.h"
#import <UMCommon/UMCommon.h>
#import <UMAnalytics/MobClick.h>


#import "GKLoginViewController.h"
#import "GKHomeViewController.h"








@interface AppDelegate ()

@property (nonatomic,strong) SIAlertView *alertView;

@end

@implementation AppDelegate

+ (AppDelegate *)sharedAppDelegate
{
    return (AppDelegate *)[[UIApplication sharedApplication] delegate];
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    
    
    [self autoLogin];
    [GKUserDefault removeObjectForKey:@"Connected"];
    [GKUserDefault synchronize];
    [self setIQKeybordManager];
    [self setSVprogressHUD];
    [self KVONetworkChange];
    [self setNotificationPush];
    [self setUMeng];
    [self addObserver];
    return YES;
}


- (void) addObserver
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loginSuccess:) name:LOGINSELECTCENTERINDEX object:nil];
}


#pragma mark -登录成功通知
- (void) loginSuccess:(NSNotification *)noti
{
    [self autoLogin];
}
- (void) autoLogin{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    //隐藏状态栏
    //[[UIApplication sharedApplication] setStatusBarHidden:YES];
    // 判断是打钩，自动登录
    //    GFUserVo *mUserVo = [GFUserDao readUserInfo];
    GKNavigationController *navigationController = [[GKNavigationController alloc]init];
        NSLog(@"[[DCObjManager dc_readUserDataForKey:@'isLogin'] = %@",[DCObjManager dc_readUserDataForKey:@"isLogin"]);
    //     [SVProgressHUD showSuccessWithStatus:@"缓存登录成功！"];
    if (![[DCObjManager dc_readUserDataForKey:@"isLogin"] isEqualToString:@"1"]) {
        //    if (mUserVo.isLogin) {
        // 跳转至登录界面
//        [SVProgressHUD showErrorWithStatus:@"登录失败，请重新登录！"];
        navigationController = [[GKNavigationController alloc]initWithRootViewController:[[GKLoginViewController alloc]init]];
    } else {
//        [SVProgressHUD showSuccessWithStatus:@"缓存登录成功！"];
        navigationController = [[GKNavigationController alloc]initWithRootViewController:[[GKHomeViewController alloc]init]];
    }
    self.window.rootViewController = navigationController;
    [self.window makeKeyAndVisible];
}
//设置友盟统计
- (void)setUMeng{
    [UMConfigure setLogEnabled:YES];
    //    [UMConfigure initWithAppkey:@"5b4320e2b27b0a50d000001e" channel:@"TEST"];
    [UMConfigure initWithAppkey:@"5bab5efdf1f5565349000131" channel:@"TEST"];
    [MobClick setScenarioType:E_UM_DPLUS];
}
//设置通知模式
- (void)setNotificationPush{
    UIUserNotificationSettings *notificationSettings = [UIUserNotificationSettings settingsForTypes:UIUserNotificationTypeAlert | UIUserNotificationTypeBadge | UIUserNotificationTypeSound categories:nil];
    //多次注册UIUserNotificationSettings会导致以前的设置被覆盖。
    [[UIApplication sharedApplication] registerUserNotificationSettings:notificationSettings];
}
//实时监控网络状态
- (void)KVONetworkChange {
    [[AFNetworkReachabilityManager sharedManager] setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        if (status == AFNetworkReachabilityStatusNotReachable) {
            NSLog(@"没网");
            [GKUserDefault setObject:@"0" forKey:@"NetworkStatus"];
            [GKUserDefault synchronize];
        }else{
            [GKUserDefault setObject:@"1" forKey:@"NetworkStatus"];
            [GKUserDefault synchronize];
            NSLog(@"有网");
        }
    }];
    
    //监控网络状态，开启监听
    [[AFNetworkReachabilityManager sharedManager] startMonitoring];
}

//- (void)customizeInterfaceWithTabBarController:(CYLTabBarController *)tabBarController {
    //设置导航栏
//    [self setUpNavigationBarAppearance];

    //隐藏tabBar顶部黑线
    //    [tabBarController hideTabBadgeBackgroundSeparator];
//}


/**
 *  设置navigationBar样式

- (void)setUpNavigationBarAppearance {
    // 设置导航条背景
    // 获得全局的主题导航条
    UINavigationBar *navBar = [UINavigationBar appearance];
    //        navBar.barStyle = UIBarStyleBlack;
    // 设置导航条的背景
    // UIBarMetricsDefault, 横竖平都能显示
    // UIBarMetricsCompact, 竖屏不能显示，横屏能显示
    // forBarMetrics:跟按钮的 forState: 什么状态下显示的图片
    [navBar setBackgroundImage:[self imageFromColor:Main_Color] forBarMetrics:UIBarMetricsDefault];
    
    //下面两个方法去掉导航条下面的黑线，没必要时不要添加
    //        [navBar setBackgroundImage:[[UIImage alloc] init] forBarPosition:UIBarPositionAny barMetrics:UIBarMetricsDefault];
    //        [navBar setShadowImage:[[UIImage alloc] init]];
    
    //底部阴影
    //    [navBar setShadowImage:[UIImage imageNamed:@"tapbar_top_line"]];
    
    //设置非半透明，纠正导航条色差 设置为YES 后，状态栏的颜色就不跟随导航条的颜色了
    navBar.translucent = NO;
    
    //设置导航条背景颜色
    //        navBar.backgroundColor = Main_Color;
    //        [navBar setBarTintColor:Main_Color];
    // 设置导航条返回按钮的箭头颜色
    navBar.tintColor = [UIColor whiteColor];
    
    // [navBar setShadowImage:[UIImage new]];
    // 设置导航条标题文字的属性：颜色和字体
    NSMutableDictionary *attrbutes = [NSMutableDictionary dictionary];
    attrbutes[NSForegroundColorAttributeName] = [UIColor blackColor];
    attrbutes[NSFontAttributeName] = GKBlodFont(17);
    [navBar setTitleTextAttributes:attrbutes];
    
    // 获得全局的item主题
    UIBarButtonItem *item = [UIBarButtonItem appearance];
    // 设置导航条标题文字的属性：颜色和字体
    NSMutableDictionary *itemAttrbutes = [NSMutableDictionary dictionary];
    itemAttrbutes[NSForegroundColorAttributeName] = [UIColor blackColor];
    itemAttrbutes[NSFontAttributeName] = GKFont(16);
    [item setTitleTextAttributes:itemAttrbutes forState:UIControlStateNormal];
}
 */





- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

- (void)setIQKeybordManager{
    [[IQKeyboardManager sharedManager] setEnable:YES];
    [[IQKeyboardManager sharedManager] setShouldResignOnTouchOutside:YES];
    [[IQKeyboardManager sharedManager] setEnableAutoToolbar:NO];
}

- (void)setSVprogressHUD{
    [SVProgressHUD setMinimumDismissTimeInterval:1.5];
    [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
//    [SVProgressHUD setInfoImage:[UIImage imageNamed:@""]];
    [SVProgressHUD setSuccessImage:[UIImage imageNamed:@"pop_toast_success"]];
    [SVProgressHUD setErrorImage:[UIImage imageNamed:@"pop_toast_error"]];
    [SVProgressHUD setFont:GKFont(14)];
    [SVProgressHUD setMinimumSize:CGSizeMake(100, 100)];
}








@end
