//
//  FontAndColor.h
//  Record
//
//  Created by mrwang90hou on 2018/6/15.
//  Copyright © 2018年 L. All rights reserved.
//

#ifndef FontAndColor_h
#define FontAndColor_h

//随机色
#define arc4randomColor [UIColor colorWithRed:(arc4random_uniform(255))/255.0 green:(arc4random_uniform(255))/255.0 blue:(arc4random_uniform(255))/255.0 alpha:1.0]

// 16进制色传入
#define UIColorFromHex(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]
#define UIColorWithRGB(r,g,b) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:1]

//主色调蓝色   pink:#F70082    organge ：#E1503B    yellow：#EFBA3A
#define Main_Color [UIColor colorWithRed:255.0/255.0 green:255.0/255.0 blue:255.0/255.0 alpha:1/1.0]




//导航栏右侧按钮色调
#define SAVE_COLOR UIColorFromHex(0x085DF7)

#define TABLEVIEW_BG UIColorFromHex(0xF6F7FA)
// 设置字体大小
#define GKFont(size) [UIFont systemFontOfSize:size]
#define GKBlodFont(size) [UIFont boldSystemFontOfSize:size]
#define GKMediumFont(size) [UIFont systemFontOfSize:size]
//#define GKMediumFont(size) [UIFont systemFontOfSize:size weight:UIFontWeightMedium]
#define GKFontAndFontName(string,float) [UIFont fontWithName:string size:float]
#endif /* FontAndColor_h */
