//
//  Config.h
//  GKBusCharging
//
//  Created by mrwang90hou on 2018/6/15.
//  Copyright © 2018年 L. All rights reserved.
//

#ifndef Config_h
#define Config_h


#define XBMakeColorWithRGB(R,G,B,A) [UIColor colorWithRed:R/255.0 green:G/255.0 blue:B/255.0 alpha:A]
// 屏幕宽高
#define SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)
#define SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)

#define K_HEIGHT_STATUSBAR    ((K_IPHONE_X==YES)?44.0f: 20.0f)
#define K_HEIGHT_NAVBAR   ((K_IPHONE_X==YES)?88.0f: 64.0f)
#define K_HEIGHT_TABBAR   ((K_IPHONE_X==YES)?83.0f: 49.0f)
//判断是否iphoneX
#define K_IPHONE_X ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1125, 2436), [[UIScreen mainScreen] currentMode].size) : NO)
//判断是否iphone5
#define K_IPHONE_5 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO)
//#define GKCGSizeMake(width,height) K_IPHONE_5 ? CGSizeMake(width, height):CGSizeMake(width, height)



#define GKAppDelegate (AppDelegate *)[UIApplication sharedApplication].delegate
/** 弱引用 */
#define GKWeakSelf __weak typeof(self) weakSelf = self;
// 通知
#define GKNotificationCenter [NSNotificationCenter defaultCenter]
// 偏好设置
#define GKUserDefault [NSUserDefaults standardUserDefaults]

//看设计以什么设备来做设计图  以下是iPhone8为标准
#define FixWidthNumber(float) ([UIScreen mainScreen].bounds.size.width/375)*float
#define FixHeightNumber(float) ([UIScreen mainScreen].bounds.size.height/667)*float

#define GKHttpViewModelProperty(modelName)  @property(strong, nonatomic) modelName *viewModel;
#define GKHttpViewModel(modelName) \
-(modelName *)viewModel{\
if (_viewModel != nil) {\
return _viewModel;\
}\
modelName *view =[[modelName alloc]init];\
_viewModel = view;\
return _viewModel;\
}\

//增加GKHttpSettingUpViewModelProperty
#define GKHttpSettingUpViewModelProperty(modelName)  @property(strong, nonatomic) modelName *settingUpViewModel;
#define GKHttpSettingUpViewModel(modelName) \
-(modelName *)settingUpViewModel{\
if (_settingUpViewModel != nil) {\
return _settingUpViewModel;\
}\
modelName *view =[[modelName alloc]init];\
_settingUpViewModel = view;\
return _settingUpViewModel;\
}\
/** 定义变量 */

#define GKMenuTotalDatasListProperty  @property(strong, nonatomic) NSDictionary *menuTotalDatasList;
//#define BUNDLE NSBundle *bundle = [NSBundle mainBundle];
//#define GKMenuTotalDatasList  NSBundle *bundle = [NSBundle mainBundle];self.menuTotalDatasList = [NSDictionary dictionaryWithContentsOfFile:[bundle pathForResource:@"MenuDatasList" ofType:@"plist"]];



#define makeCornerRadius(view,radius) \
view.layer.cornerRadius = radius;\
view.layer.masksToBounds = YES;\
view.layer.shouldRasterize = YES;\
view.layer.rasterizationScale = [UIScreen mainScreen].scale;

//单例为了方便实用，只要将以下代码定义在header文件或者.pch文件即可；
// .h
#define singleton_interface(class) + (instancetype)shared##class;

// .m
#define singleton_implementation(class) \
static class *_instance; \
\
+ (id)allocWithZone:(struct _NSZone *)zone \
{ \
    static dispatch_once_t onceToken; \
    dispatch_once(&onceToken, ^{ \
        _instance = [super allocWithZone:zone]; \
    }); \
    \
    return _instance; \
} \
\
+ (instancetype)shared##class \
{ \
    if (_instance == nil) { \
        _instance = [[class alloc] init]; \
    } \
    \
    return _instance; \
}

#define needNavBarHidden \
- (void)navigationController:(UINavigationController*)navigationController willShowViewController:(UIViewController*)viewController animated:(BOOL)animated{\
    if(viewController == self){\
        [self.navController setNavigationBarHidden:YES animated:YES];\
    }else{\
        [self.navController setNavigationBarHidden:NO animated:YES];\
        if(self.navController.delegate == self){\
            self.navController.delegate = nil;\
        }\
    }\
}

#define needNavBarShow \
- (void)navigationController:(UINavigationController*)navigationController willShowViewController:(UIViewController*)viewController animated:(BOOL)animated{\
    if(viewController == self){\
        [self.navController setNavigationBarHidden:NO animated:YES];\
    }else{\
        [self.navController setNavigationBarHidden:YES animated:YES];\
        if(self.navController.delegate == self){\
            self.navController.delegate = nil;\
        }\
    }\
}

//通过一个方法来找到这个黑线(findHairlineImageViewUnder):
#define navBarLineHidden \
- (UIImageView *)findHairlineImageViewUnder:(UIView *)view {\
    if ([view isKindOfClass:UIImageView.class] && view.bounds.size.height <= 1.0) {\
        return (UIImageView *)view;\
    }\
    for (UIView *subview in view.subviews) {\
        UIImageView *imageView = [self findHairlineImageViewUnder:subview];\
        if (imageView) {\
            return imageView;\
        }\
    }\
    return nil;\
}

#endif /* Config_h */
