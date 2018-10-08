//
//  GKAppVersionTool.m
//  GKBusCharging
//
//  Created by mrwang90hou on 2019/9/26.
//  Copyright © 2019年 mrwang90hou. All rights reserved.
//

#import "GKAppVersionTool.h"

@implementation GKAppVersionTool


// 获取保存的上一个版本信息
+ (NSString *)dc_GetLastOneAppVersion {
    
    return [[NSUserDefaults standardUserDefaults] stringForKey:@"AppVersion"];
}

// 保存新版本信息（偏好设置）
+ (void)dc_SaveNewAppVersion:(NSString *)version {
    
    [[NSUserDefaults standardUserDefaults] setObject:version forKey:@"AppVersion"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}


@end
