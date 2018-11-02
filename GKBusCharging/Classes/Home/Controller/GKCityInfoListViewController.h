//
//  GKCityInfoListViewController.h
//  GKBusCharging
//
//  Created by 王宁 on 2018/11/2.
//  Copyright © 2018年 goockr. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef void(^GKCityInfoListViewControllerBlock)(NSString *cityName);

@interface GKCityInfoListViewController : GKBaseSetViewController


@property (nonatomic, copy) GKCityInfoListViewControllerBlock choseCityBlock;
/**
 选择城市后的回调
 
 @param block 回调
 */
- (void)choseCityBlock:(GKCityInfoListViewControllerBlock)block;
@end
