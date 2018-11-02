//
//  GKBusListModel.h
//  GKBusCharging
//
//  Created by mrwang90hou on 2018/11/2.
//  Copyright © 2017年 goockr. All rights reserved.
//

#import <Foundation/Foundation.h>
//#import "RoomModel.h"
//#import "YYModel.h"
//#import "HotelsModel.h"

@interface GKBusListModel : NSObject

@property (nonatomic, strong) NSString *iid;
@property (nonatomic, strong) NSString *busAscriptionId;
@property (nonatomic, strong) NSString *busNumber;
@property (nonatomic, strong) NSString *createtime;
@property (nonatomic, strong) NSString *busAscriptionName;
@property (nonatomic, strong) NSString *province;

@property (nonatomic, strong) NSString *isNewRecord;
@property (nonatomic, strong) NSString *busType;
@property (nonatomic, strong) NSString *city;
@property (nonatomic, strong) NSString *bz;
@property (nonatomic, strong) NSString *lxr;
@property (nonatomic, strong) NSString *photos;
@property (nonatomic, strong) NSString *busName;
@property (nonatomic, strong) NSString *score;
@property (nonatomic, strong) NSString *lxdh;
@property (nonatomic, strong) NSString *allowLend;

@end
