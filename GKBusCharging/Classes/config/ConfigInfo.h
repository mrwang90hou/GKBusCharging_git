//
//  ConfigInfo.h
//  GKBusCharging
//
//  Created by mrwang90hou on 2018/9/26.
//  Copyright © 2018年 goockr. All rights reserved.
//

#ifndef ConfigInfo_h
#define ConfigInfo_h



//项目缓存信息值
#define TOKEN  @"token"
//获取屏幕宽高
//#define SCREEN_WIDTH   [UIScreen mainScreen].bounds.size.width
//#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height

#define Weak(wself) __weak typeof(self)(wself) = self
//屏幕适配
#define SET_FIX_SIZE_WIDTH (SCREEN_WIDTH / 414.0f)
//获取适配后的数据大小
#define AUTO(num)  num * SET_FIX_SIZE_WIDTH
//字体大小
#define FONT(x)     [UIFont systemFontOfSize:x]
//主调色
//#define BASECOLOR   DDRGBColor(0, 190, 255, 1)
//主调色
#define BASECOLOR   DDRGBColor(31, 206, 155, 1)
//字体色
#define TEXTCOLOR   DDRGBColor(57, 57, 57, 1)
#define TEXTMAINCOLOR   DDRGBColor(88, 79, 96, 1)
#define TEXTGRAYCOLOR   DDRGBColor(153, 153, 153, 1)

//浅色字体
#define TEXTCOLOR_LIGHT   DDRGBColor(124, 124, 124, 1)
//灰色背景
#define GRAYCOLOR   DDRGBColor(243, 244, 245, 1)
//线的颜色
#define LINECOLOR   DDRGBColor(169, 169, 169, 1)
//订单状态颜色
#define OrderColor   DDRGBColor(252, 108, 21, 1)
//照片的使用
#define REDPACKETBUNDLE(name) [NSString stringWithFormat:@"SourcesBundle.bundle/2x/%@", name]
#define LFIMAGE(name)    [UIImage imageNamed:REDPACKETBUNDLE(name)]
#define SETIMAGE(name)    [UIImage imageNamed:name]

//获取通知中心
#define DDNotificationCenter [NSNotificationCenter defaultCenter]
//获取随机颜色值
#define DDRandomColor [UIColor colorWithRed:arc4random_uniform(256)/255.0 green:arc4random_uniform(256)/255.0 blue:arc4random_uniform(256)/255.0 alpha:1.0]
//设置rgb颜色
#define DDRGBColor(r, g, b, a) [UIColor colorWithRed:(r)/256.0 green:(g)/256.0 blue:(b)/256.0 alpha:a]

// clear背景颜色
#define DDClearColor [UIColor clearColor]

//使用宏定义16进制颜色值
#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]
//log
#ifdef DEBUG
#define LFLog(...) NSLog(@"%s 第%d行 \n %@\n\n",__func__,__LINE__,[NSString stringWithFormat:__VA_ARGS__])
#else
#define LFLog(...)
#endif

#define LRViewBorderRadius(View, Radius, Width, Color)\
\
[View.layer setCornerRadius:(Radius)];\
[View.layer setMasksToBounds:YES];\
[View.layer setBorderWidth:(Width)];\
[View.layer setBorderColor:[Color CGColor]]


//判断是否为iPhone
#define IS_IPHONE (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
//判断是否为iPad
#define IS_IPAD (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
//判断是否为ipod
#define IS_IPOD ([[[UIDevice currentDevice] model] isEqualToString:@"iPod touch"])
// 判断是否为 iPhone 5SE
#define iPhone5SE [[UIScreen mainScreen] bounds].size.width == 320.0f && [[UIScreen mainScreen] bounds].size.height == 568.0f
// 判断是否为iPhone 6/6s
#define iPhone6_6s [[UIScreen mainScreen] bounds].size.width == 375.0f && [[UIScreen mainScreen] bounds].size.height == 667.0f
// 判断是否为iPhone 6Plus/6sPlus
#define iPhone6Plus_6sPlus [[UIScreen mainScreen] bounds].size.width == 414.0f && [[UIScreen mainScreen] bounds].size.height == 736.0f
#define iPhoneX [[UIScreen mainScreen] bounds].size.height == 812.0f
//获取系统版本
#define IOS_SYSTEM_VERSION [[[UIDevice currentDevice] systemVersion] floatValue]
//判断 iOS 8 或更高的系统版本
#define IOS_VERSION_8_OR_LATER (([[[UIDevice currentDevice] systemVersion] floatValue] >=8.0)? (YES):(NO))
//获取当前app版本
#define IOS_VERSION [[[NSBundle mainBundle] infoDictionary] objectForKey:(NSString *)kCFBundleVersionKey]
#define iOS11 ([[UIDevice currentDevice].systemVersion doubleValue] >= 11.0)








#endif /* ConfigInfo_h */
