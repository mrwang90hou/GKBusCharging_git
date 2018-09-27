//
//  GKUserInfo.h
//  GKBusCharging
//
//  Created by mrwang90hou on 2019/9/26.
//  Copyright © 2019年 mrwang90hou. All rights reserved.
//

#import "JKDBModel.h"

@interface GKUserInfo : JKDBModel

@property (nonatomic, copy) NSString *sex;

@property (nonatomic, copy) NSString *username;

@property (nonatomic, copy) NSString *nickname;

@property (nonatomic, copy) NSString *userimage;

@property (nonatomic, copy) NSString *birthDay;

@property (nonatomic, copy) NSString *defaultAddress;

@end
