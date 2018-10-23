//
//  AppDelegate.h
//  GKBusCharging
//
//  Created by mrwang90hou on 2018/9/26.
//  Copyright © 2018年 goockr. All rights reserved.
//

#import <UIKit/UIKit.h>

//#import "WXApi.h"
@interface AppDelegate : UIResponder <UIApplicationDelegate,WXApiDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (assign, nonatomic) BOOL hadShowAlert;

- (void) autoLogin;

//- (void) getDeviceListWithShowTip:(BOOL)show;

+ (AppDelegate *)sharedAppDelegate;

@end

