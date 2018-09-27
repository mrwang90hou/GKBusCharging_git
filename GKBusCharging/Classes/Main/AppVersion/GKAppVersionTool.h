//
//  GKAppVersionTool.h
//  GKBusCharging
//
//  Created by mrwang90hou on 2019/9/26.
//  Copyright © 2019年 mrwang90hou. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GKAppVersionTool : NSObject

/**
 *  获取之前保存的版本
 *
 *  @return NSString类型的AppVersion
 */
+ (NSString *)dc_GetLastOneAppVersion;
/**
 *  保存新版本
 */
+ (void)dc_SaveNewAppVersion:(NSString *)version;


@end
