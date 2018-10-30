//
//  GCHttpDataTool.m
//  goockr_dustbin
//
//  Created by csl on 2016/11/23.
//  Copyright © 2016年 csl. All rights reserved.
//

#import "GCHttpDataTool.h"

#import "AFNetworking.h"




@implementation GCHttpDataTool


+(void)getLoginSmsCodeWithDict:(NSDictionary *)dict success:(void (^)(id))success failure:(void (^)(MQError *))failure
{
    
//    NSString *urlString=[NSString stringWithFormat:@"%@%@",GK_URL,SENDMessageURL];
    NSString *urlString=[NSString stringWithFormat:@"%@",SENDMessageURL];
    NSLog(@"当前URL请求【获取验证号登录验证码】为：%@",urlString);
    NSLog(@"parameters参数为：%@",dict);
    
    [GCHttpTool Post:urlString parameters:dict success:^(id responseObject) {
        
        if ([responseObject[@"code"] intValue] != 200)
        {
            MQError *err=[[MQError alloc] init];;
            
            err.code=[responseObject[@"code"] intValue];
            
            err.msg=responseObject[@"msg"];
            
            failure(err);
            NSLog(@"❌❌❌❌❌❌❌❌❌❌❌❌❌❌❌❌[responseObject[@Code] intValue] = %d",[responseObject[@"Code"] intValue]);
            
        }else{
            success(responseObject);
        }
        
    } failure:^(MQError *error) {
        
        failure(error);
        
    }];

}

+(void)smsLoginWithDict:(NSDictionary *)dict success:(void (^)(id))success failure:(void (^)(MQError *))failure
{
    NSString *urlString=[NSString stringWithFormat:@"%@",LOGINAccountURL];
    NSLog(@"当前URL请求【验证码登录】为：%@",urlString);
    NSLog(@"parameters参数为：%@",dict);
    
    [GCHttpTool Post:urlString parameters:dict success:^(id responseObject) {
        
        if ([responseObject[@"code"] intValue] != 200)
        {
            MQError *err=[[MQError alloc] init];;
            
            err.code=[responseObject[@"code"] intValue];
            
            err.msg=responseObject[@"msg"];
            
            failure(err);
            NSLog(@"❌❌❌❌❌❌❌❌❌❌❌❌❌❌❌❌[responseObject[@Code] intValue] = %d",[responseObject[@"Code"] intValue]);
            
        }else{
            success(responseObject);
        }
        
    } failure:^(MQError *error) {
        
        failure(error);
        
    }];
    
    
}

+(void)scanQRCodeChargeWithDict:(NSDictionary *)dict success:(void (^)(id))success failure:(void (^)(MQError *))failure
{
    NSString *urlString=[NSString stringWithFormat:@"%@",SCANQRCodeChargeURL];
    NSLog(@"当前URL请求【扫码进入充电页】为：%@",urlString);
    NSLog(@"parameters参数为：%@",dict);
    
    [GCHttpTool Post:urlString parameters:dict success:^(id responseObject) {
        
        success(responseObject);
        
    } failure:^(MQError *error) {
        
        failure(error);
        
    }];

}



+(void)rentChargingLineURLWithDict:(NSDictionary *)dict success:(void (^)(id))success failure:(void (^)(MQError *))failure
{
    NSString *urlString=[NSString stringWithFormat:@"%@",RENTChargingLineURL];
    NSLog(@"当前URL请求【租借充电线】为：%@",urlString);
    NSLog(@"parameters参数为：%@",dict);
    
    [GCHttpTool Post:urlString parameters:dict success:^(id responseObject) {
        
        if ([responseObject[@"result"] intValue] == 0) {
            success(responseObject);
        }else{
            //        Result
            //        0:请求发送到达客户端
            //        -4:网络错误
            //        -5:保存数据出错
            //        -7:机柜正在处理其他请求
            //        -8:机柜繁忙
            NSString *errorStr = @"";
            switch ([responseObject[@"result"] intValue]) {
                    //            case 0:
                    //                success(responseObject);
                    //                break;
                case -4:
//                    errorStr = @"网络错误";
                    errorStr = @"租借失败：充电柜离线！";
                    break;
                case -5:
                    errorStr = @"保存数据出错";
                    break;
    //            case -6:
    //                errorStr = @"网络错误";
                    break;
                case -7:
                    errorStr = @"机柜正在处理其他请求";
                    break;
                case -8:
                    errorStr = @"机柜繁忙";
                    break;
                default:
                    break;
                    
            }
            MQError *err=[MQError errorWithCode:[responseObject[@"result"] intValue] msg:errorStr];
            //        failure(err);
            //        err.code = [responseObject[@"result"] intValue];
            //        err.msg=responseObject[@"msg"];
            failure(err);
        }
    } failure:^(MQError *error) {
        
        failure(error);
        
    }];

}


+ (void)cxChargingLineStatusWithDict:(NSDictionary *)dict success:(void (^)(id))success failure:(void (^)(MQError *))failure
{
    NSString *urlString=[NSString stringWithFormat:@"%@",CXChargingLineStatusURL];
    NSLog(@"当前URL请求【查询充电状态、查询用户状态】为：%@",urlString);
    NSLog(@"parameters参数为：%@",dict);
    
    [GCHttpTool Post:urlString parameters:dict success:^(id responseObject) {
        
        success(responseObject);
        
    } failure:^(MQError *error) {
        
        failure(error);
        
    }];

}

+(void)returnChargingLineWithDict:(NSDictionary *)dict success:(void (^)(id))success failure:(void (^)(MQError *))failure
{
    NSString *urlString=[NSString stringWithFormat:@"%@",RETURNChargingLineURL];
    NSLog(@"当前URL请求【归还充电线】为：%@",urlString);
    NSLog(@"parameters参数为：%@",dict);
    
    [GCHttpTool Post:urlString parameters:dict success:^(id responseObject) {
        if ([responseObject[@"code"] intValue] != 200)
        {
            MQError *err=[[MQError alloc] init];;
            
            err.code=[responseObject[@"code"] intValue];
            
            err.msg=responseObject[@"msg"];
            
            failure(err);
        }else{
            success(responseObject);
        }
        
    } failure:^(MQError *error) {
        
        failure(error);
        
    }];

}


+(void)cxUserBillListWithDict:(NSDictionary *)dict success:(void (^)(id))success failure:(void (^)(MQError *))failure
{
    NSString *urlString=[NSString stringWithFormat:@"%@",CXUserBillListURL];
    NSLog(@"当前URL请求【查询用户账单列表】为：%@",urlString);
    NSLog(@"parameters参数为：%@",dict);
    
    [GCHttpTool Post:urlString parameters:dict success:^(id responseObject) {
        
        success(responseObject);
        
    } failure:^(MQError *error) {
        
        NSLog(@"error.code = %d , error.msg = %@",error.code,error.msg);
//        [ hud hudUpdataTitile:@"绑定产品成功" hideTime:KHudSuccessShowShortTime];
        failure(error);
        
    }];
}


+ (void)cxUserBillDetailWithDict:(NSDictionary *)dict success:(void (^)(id))success failure:(void (^)(MQError *))failure
{
    NSString *urlString=[NSString stringWithFormat:@"%@",CXUserBillDetailURL];
    NSLog(@"当前URL请求【查询用户账单详细】为：%@",urlString);
    NSLog(@"parameters参数为：%@",dict);
    
    
    [GCHttpTool Post:urlString parameters:dict success:^(id responseObject) {
        
        success(responseObject);
        
    } failure:^(MQError *error) {
        
        failure(error);
        
    }];

}


+(void)getUserInfoWithDict:(NSDictionary *)dict success:(void (^)(id))success failure:(void (^)(MQError *))failure
{
    NSString *urlString=[NSString stringWithFormat:@"%@",GETUserInfoURL];
    NSLog(@"当前URL请求【获取个人信息】为：%@",urlString);
    NSLog(@"parameters参数为：%@",dict);
    [GCHttpTool Post:urlString parameters:dict success:^(id responseObject) {
        
        success(responseObject);
        
    } failure:^(MQError *error) {
        
        failure(error);
        
    }];
}


+ (void)uploadFaultInfoWithDict:(NSDictionary *)dict success:(void (^)(id))success failure:(void (^)(MQError *))failure
{
    NSString *urlString=[NSString stringWithFormat:@"%@",UPLOADFaultInfoURL];
    NSLog(@"当前URL请求【处理用户报障信息、上传故障信息】为：%@",urlString);
    NSLog(@"parameters参数为：%@",dict);
    
    [GCHttpTool Post:urlString parameters:dict success:^(id responseObject) {
        if ([responseObject[@"code"] intValue] != 200)
        {
            if ([responseObject[@"code"] intValue] == 500) {
                MQError *err=[MQError errorWithCode:-1 msg:@"缺少参数！"];
                failure(err);
            }
            MQError *err=[[MQError alloc] init];
            
            err.code=[responseObject[@"code"] intValue];
            
            err.msg=responseObject[@"msg"];
            
            failure(err);
        }else{
            success(responseObject);
        }
        
    } failure:^(MQError *error) {
        
        failure(error);
        
    }];
}

+ (void)getFaultListWithDict:(NSDictionary *)dict success:(void (^)(id))success failure:(void (^)(MQError *))failure
{
    NSString *urlString=[NSString stringWithFormat:@"%@",GETFaultListURL];
    NSLog(@"当前URL请求【获取故障历史信息、报障历史列表】为：%@",urlString);
    NSLog(@"parameters参数为：%@",dict);
    
    
    [GCHttpTool Post:urlString parameters:dict success:^(id responseObject) {
        
        success(responseObject);
        
    } failure:^(MQError *error) {
        
        failure(error);
        
    }];
}


+ (void)getFaultDetailInfoWithDict:(NSDictionary *)dict success:(void (^)(id))success failure:(void (^)(MQError *))failure
{
    NSString *urlString=[NSString stringWithFormat:@"%@",GETFaultDetailInfo];
    NSLog(@"当前URL请求【获取故障详细信息】为：%@",urlString);
    NSLog(@"parameters参数为：%@",dict);
    
    
    
    [GCHttpTool Post:urlString parameters:dict success:^(id responseObject) {
        
        success(responseObject);
        
    } failure:^(MQError *error) {
        
        failure(error);
        
    }];
}

+ (void)rentChargingLineAgainWithDict:(NSDictionary *)dict success:(void (^)(id))success failure:(void (^)(MQError *))failure
{
    NSString *urlString=[NSString stringWithFormat:@"%@",RENTChargingLineAgainURL];
    
    NSLog(@"当前URL请求【续租充电线】为：%@",urlString);
    NSLog(@"parameters参数为：%@",dict);
    
    
    [GCHttpTool Post:urlString parameters:dict success:^(id responseObject) {
        
        success(responseObject);
        
    } failure:^(MQError *error) {
        
        failure(error);
        
    }];
}


+ (void)getBusListWithDict:(NSDictionary *)dict success:(void (^)(id))success failure:(void (^)(MQError *))failure
{
    NSString *urlString=[NSString stringWithFormat:@"%@",GetBusListURL];
    
    NSLog(@"当前URL请求【获取公交车列表】为：%@",urlString);
    NSLog(@"parameters参数为：%@",dict);
    
    
    [GCHttpTool Post:urlString parameters:dict success:^(id responseObject) {
        
        success(responseObject);
        
    } failure:^(MQError *error) {
        
        failure(error);
        
    }];
}


+ (void)getEvaluateOrderWithDict:(NSDictionary *)dict success:(void (^)(id))success failure:(void (^)(MQError *))failure
{
    NSString *urlString=[NSString stringWithFormat:@"%@",GETEvaluateOrderURL];
    
    NSLog(@"当前URL请求【获取评价订单】为：%@",urlString);
    NSLog(@"parameters参数为：%@",dict);
    
    
    [GCHttpTool Post:urlString parameters:dict success:^(id responseObject) {
        
        success(responseObject);
        
    } failure:^(MQError *error) {
        
        failure(error);
        
    }];
}


+ (void)getEvaluateOrder2WithDict:(NSDictionary *)dict success:(void (^)(id))success failure:(void (^)(MQError *))failure
{
    NSString *urlString=[NSString stringWithFormat:@"%@",GETEvaluateOrderURL2];
    
    NSLog(@"当前URL请求【获取评价订单2】为：%@",urlString);
    NSLog(@"parameters参数为：%@",dict);
    
    
    [GCHttpTool Post:urlString parameters:dict success:^(id responseObject) {
        
        success(responseObject);
        
    } failure:^(MQError *error) {
        
        failure(error);
        
    }];
}


+ (void)orderEvaluateWithDict:(NSDictionary *)dict success:(void (^)(id))success failure:(void (^)(MQError *))failure
{
    NSString *urlString=[NSString stringWithFormat:@"%@",OrderEvaluateURL];
    
    NSLog(@"当前URL请求【订单评价】为：%@",urlString);
    NSLog(@"parameters参数为：%@",dict);
    
    
    [GCHttpTool Post:urlString parameters:dict success:^(id responseObject) {
        if ([responseObject[@"code"] intValue] != 200)
        {
            if ([responseObject[@"code"] intValue] == 404) {
                MQError *err=[MQError errorWithCode:-1 msg:@"评价失败！"];
                failure(err);
            }
            MQError *err=[[MQError alloc] init];
            
            err.code=[responseObject[@"code"] intValue];
            
            err.msg=responseObject[@"msg"];
            failure(err);
        }else{
            success(responseObject);
        }
        
    } failure:^(MQError *error) {
        
        failure(error);
        
    }];
}


+ (void)getCityListWithDict:(NSDictionary *)dict success:(void (^)(id))success failure:(void (^)(MQError *))failure
{
    NSString *urlString=[NSString stringWithFormat:@"%@",GETCityListURL];
    
    NSLog(@"当前URL请求【获取城市列表】为：%@",urlString);
    NSLog(@"parameters参数为：%@",dict);
    [GCHttpTool Post:urlString parameters:dict success:^(id responseObject) {
        
        success(responseObject);
        
    } failure:^(MQError *error) {
        
        failure(error);
        
    }];
}



@end
