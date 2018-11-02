//
//  GKCityListModel.h
//  GKBusCharging
//
//  Created by mrwang90hou on 2018/11/2.
//  Copyright © 2017年 goockr. All rights reserved.
//

#import <Foundation/Foundation.h>
//#import "RoomModel.h"
//#import "YYModel.h"
//#import "HotelsModel.h"

@interface GKCityListModel : NSObject

@property (nonatomic, strong) NSString *iid;
@property (nonatomic, assign) Boolean *isNewRecord;
@property (nonatomic, strong) NSString *cityName;
@property (nonatomic, strong) NSString *cityCode;
@property (nonatomic, strong) NSString *latitude;
@property (nonatomic, strong) NSString *longitude;

@end
