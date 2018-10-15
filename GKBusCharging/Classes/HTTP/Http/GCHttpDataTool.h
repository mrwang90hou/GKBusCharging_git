//
//  GCHttpDataTool.h
//  goockr_dustbin
//
//  Created by csl on 2016/11/23.
//  Copyright © 2016年 csl. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "HttpCommon.h"
#import "GCHttpTool.h"

@interface GCHttpDataTool : NSObject


/**
 【1.0】获取验证号登录验证码
 
 @param dict 传入参数
 @param success 成功回调
 @param failure 失败回调
 */
+ (void) getLoginSmsCodeWithDict:(NSDictionary *)dict success:(void (^)(id responseObject))success failure:(void (^)(MQError *error))failure;


/**
  【1.1】验证码登录

 @param dict 传入参数
 @param success 成功回调
 @param failure 失败回调
 */
+ (void) smsLoginWithDict:(NSDictionary *)dict success:(void (^)(id responseObject))success failure:(void (^)(MQError *error))failure;


/**
 【2】扫码接口
 
 @param dict 传入参数
 @param success 成功回调
 @param failure 失败回调
 */
+ (void) scanQRCodeChargeWithDict:(NSDictionary *)dict success:(void (^)(id responseObject))success failure:(void (^)(MQError *error))failure;


/**
 【3】租充电线接口

 @param dict 传入参数
 @param success  成功回调
 @param failure 失败回调
 */
+ (void) rentChargingLineURLWithDict:(NSDictionary *)dict success:(void (^)(id responseObject))success failure:(void (^)(MQError *error))failure;


/**
 【4】监听客户端返回消息

 @param dict 传入参数
 @param success 成功回调
 @param failure 失败回调
 */
//+ (void) forgetPwdWithDict:(NSDictionary *)dict success:(void (^)(id responseObject))success failure:(void (^)(MQError *error))failure;


/**
 【5】查询用户状态
 
 @param dict 传入参数
 @param success 成功回调
 @param failure 失败回调
 */
+ (void) cxChargingLineStatusWithDict:(NSDictionary *)dict success:(void (^)(id responseObject))success failure:(void (^)(MQError *error))failure;

/**
 【6】归还充电线接口
 
 @param dict 传入字典
 @param success 请求成功的回调
 @param failure 请求失败的回调
 */
+ (void) returnChargingLineWithDict:(NSDictionary *)dict success:(void (^)(id responseObject))success failure:(void (^)(MQError *error))failure;


/**
 【7】查询用户账单列表
 
 @param dict 传入字典
 @param success 请求成功的回调
 @param failure 请求失败的回调
 */
+ (void) cxUserBillListWithDict:(NSDictionary *)dict success:(void (^)(id responseObject))success failure:(void (^)(MQError *error))failure;


/**
 【8】查询账单详细
 
 @param dict 传入字典
 @param success 请求成功的回调
 @param failure 请求失败的回调
 */
+ (void) cxUserBillDetailWithDict:(NSDictionary *)dict success:(void (^)(id responseObject))success failure:(void (^)(MQError *error))failure;


/**
 【9】获取个人信息
 
 @param dict 传入字典
 @param success 请求成功的回调
 @param failure 请求失败的回调
 */
+ (void) getUserInfoWithDict:(NSDictionary *)dict success:(void (^)(id responseObject))success failure:(void (^)(MQError *error))failure;


/**
 【10】处理用户报障信息、上传故障信息
 
 @param dict 传入字典
 @param success 请求成功的回调
 @param failure 请求失败的回调
 */
+ (void) uploadFaultInfoWithDict:(NSDictionary *)dict success:(void (^)(id responseObject))success failure:(void (^)(MQError *error))failure;


/**
 【11】获取故障历史信息、报障历史列表
 
 @param dict 传入字典
 @param success 请求成功的回调
 @param failure 请求失败的回调
 */
+ (void) getFaultListWithDict:(NSDictionary *)dict success:(void (^)(id responseObject))success failure:(void (^)(MQError *error))failure;


/**
 【12】获取故障记录详细
 
 @param dict 传入字典
 @param success 请求成功的回调
 @param failure 请求失败的回调
 */
+ (void) getFaultDetailInfoWithDict:(NSDictionary *)dict success:(void (^)(id responseObject))success failure:(void (^)(MQError *error))failure;

/**
 【13】续租
 
 @param dict 传入字典
 @param success 请求成功的回调
 @param failure 请求失败的回调
 */
+ (void)rentChargingLineAgainWithDict:(NSDictionary *)dict success:(void (^)(id))success failure:(void (^)(MQError *))failure;


/**
 【14】公交车列表
 
 @param dict 传入字典
 @param success 请求成功的回调
 @param failure 请求失败的回调
 */
+ (void)getBusListWithDict:(NSDictionary *)dict success:(void (^)(id))success failure:(void (^)(MQError *))failure;

/**
 【15】获取评价账单详细
 
 @param dict 传入字典
 @param success 请求成功的回调
 @param failure 请求失败的回调
 */
+ (void)getEvaluateOrderWithDict:(NSDictionary *)dict success:(void (^)(id))success failure:(void (^)(MQError *))failure;

/**
 【16】获取评价订单详细2
 
 @param dict 传入字典
 @param success 请求成功的回调
 @param failure 请求失败的回调
 */
+ (void)getEvaluateOrder2WithDict:(NSDictionary *)dict success:(void (^)(id))success failure:(void (^)(MQError *))failure;

/**
 【17】评价订单
 
 @param dict 传入字典
 @param success 请求成功的回调
 @param failure 请求失败的回调
 */
+ (void)orderEvaluateWithDict:(NSDictionary *)dict success:(void (^)(id))success failure:(void (^)(MQError *))failure;



/**
 【18】获取城市列表
 
 @param dict 传入字典
 @param success 请求成功的回调
 @param failure 请求失败的回调
 */
+ (void)getCityListWithDict:(NSDictionary *)dict success:(void (^)(id))success failure:(void (^)(MQError *))failure;


















@end
