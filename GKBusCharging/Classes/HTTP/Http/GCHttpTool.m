//
//  GCHttpTool.m
//  goockr_heart
//
//  Created by csl on 16/10/4.
//  Copyright © 2016年 csl. All rights reserved.
//

#import "GCHttpTool.h"
#import "AFNetworking.h"


@implementation GCHttpTool

+ (void)GET:(NSString *)URLString parameters:(id)parameters success:(void (^)(id))success failure:(void (^)(NSError *))failure
{
    // 创建请求管理者
    AFHTTPSessionManager *mgr = [AFHTTPSessionManager manager];

    [mgr.requestSerializer setTimeoutInterval:5.0];
    
    [mgr GET:URLString parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        
    
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        if (success) {
            
          // NSDictionary *dict= [NSJSONSerialization JSONObjectWithData:responseObject options:0 error:nil];
            
            
           // NSLog(@"获取到的数据为：%@",dict);
            
            success(responseObject);
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
       
        if (failure) {
            
            NSLog(@"%@",error);
            failure(error);
            
        }
        
    }];
    
    
}

+ (void)Post:(NSString *)URLString parameters:(id)parameters success:(void (^)(id responseObject))success failure:(void (^)(MQError *error))failure;

{
   
    //[3]	(null)	@"NSLocalizedDescription" : @"Request failed: unacceptable content-type: text/plain"	
//    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc] init];
    //    "PhoneNumber":"13679587672",
    //    "Password":"123456"
    
    //  NSMutableDictionary *dict = @{@"PhoneNumber":@"13679587672",@"Password":@"123456"};
    
    [manager.requestSerializer willChangeValueForKey:@"timeoutInterval"];
    
    manager.requestSerializer.timeoutInterval = 10.0f;
    
    [manager.requestSerializer didChangeValueForKey:@"timeoutInterval"];
    
    //调出请求头
//    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    //将token封装入请求头
//    [manager.requestSerializer setValue:TOKEN forHTTPHeaderField:@"token-id"];
//    NSDictionary *headerFieldValueDictionary = @{@"cookid":@"app_termUserInfo_18577986175"};
//    if (headerFieldValueDictionary != nil) {
//        for (NSString *httpHeaderField in headerFieldValueDictionary.allKeys) {
//            NSString *value = headerFieldValueDictionary[httpHeaderField];
//            [manager.requestSerializer setValue:value forHTTPHeaderField:httpHeaderField];
//        }
//    }
    //判断请求参数中是否包含   “code” 或者 “token”
    if (![[parameters allKeys] containsObject:@"code"] && ![[parameters allKeys]containsObject:@"token"]) {
        //调出请求头
//        manager.requestSerializer = [AFJSONRequestSerializer serializer];
        //拼接参数的序列化器，使用的正确的序列化器
        manager.requestSerializer = [AFHTTPRequestSerializer serializer];
        //返回数据的序列化器
        manager.responseSerializer = [AFJSONResponseSerializer serializer];
        // 可接受的文本参数规格
//        manager.responseSerializer.acceptableContentTypes =  [NSSet setWithObjects:@"application/json", @"text/html",@"text/json",@"text/javascript", nil];

        manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/html",@"text/plain",nil];
        AFSecurityPolicy *security = [AFSecurityPolicy defaultPolicy];
        security.allowInvalidCertificates = YES;
        security.validatesDomainName = NO;
//        [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"content-type"];
        [manager.requestSerializer setValue:[DCObjManager dc_readUserDataForKey:@"key"] forHTTPHeaderField:@"cookid"];
//        NSLog(@"[manager.requestSerializer setValue:@app_termUserInfo_18577986175 forHTTPHeaderField:@cookid];");
    }
//    NSString *str = [manager.requestSerializer valueForHTTPHeaderField:@"cookid"];
//    NSLog(@"cookid = %@",str);
//    [manager addValue:@"app_termUserInfo_18577986175" forHTTPHeaderField:@"cookid"];
    // 为请求头增加字段, field名字要严格遵守协议
//    - (void)addValue:(NSString *)value forHTTPHeaderField:(NSString *)field
    // 根据field修改设置value, field要严格遵守http协议
//    - (void)setValue:(NSString *)value forHTTPHeaderField:(NSString *)field
    // 根据field的名字获取请求头的字段
//    - (nullable NSString *)valueForHTTPHeaderField:(NSString *)field;
//    valueForHTTPHeaderField
    // 还有一个属性, 存储该请求所有请求头信息
//    @property(copy) NSDictionary <NSString *,NSString *> *allHTTPHeaderFields
    /**/
    
//    [manager GET:URLString parameters:nil  progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//
//    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//
//    }];
    
    
    [manager POST:URLString parameters:parameters progress:^(NSProgress * _Nonnull uploadProgress) {
    
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSData *mJsonData = [NSJSONSerialization dataWithJSONObject:responseObject options:NSJSONWritingPrettyPrinted error:nil];
        NSLog(@"获取到的数据为：\n%@", [[NSString alloc] initWithData:mJsonData encoding:NSUTF8StringEncoding]);
//        NSDictionary *mResult = [NSJSONSerialization JSONObjectWithData:mJsonData options:NSJSONReadingMutableContainers error:nil];
        //        NSLog(@"获取到的数据为：%@",[responseObject description]);
//        NSLog(@"获取到的数据为：%@",[mResult description]);
//        if (parameters == nil) {
//            success(responseObject);
//        }
//        if ([responseObject[@"code"] intValue] != 200)
//        {
//            MQError *err=[[MQError alloc] init];;
//
//            err.code=[responseObject[@"code"] intValue];
//
//            err.msg=responseObject[@"msg"];
//
//            failure(err);
//            NSLog(@"❌❌❌❌❌❌❌❌❌❌❌❌❌❌❌❌[responseObject[@Code] intValue] = %d",[responseObject[@"Code"] intValue]);
//
//        }else{
            success(responseObject);
//        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//        NSLog(@"task.state = %@)",error.userInfo);
        MQError *err=[MQError errorWithCode:-1 msg:@"网络请求失败"];
//        err.msg = error.mj_JSONString;
        failure(err);
    }];
    

    
   
//    [mgr POST:URLString parameters:parameters progress:^(NSProgress * _Nonnull uploadProgress) {
//        
//        
//    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//        
//        
//        NSLog(@"获取到的数据为：%@",responseObject);
//        
//        NSDictionary *dict= [NSJSONSerialization JSONObjectWithData:responseObject options:0 error:nil];
//        
//        if (dict[@"result"]!=0)
//        {
//            MQError *err=[[MQError alloc] init];;
//            
//            err.code=[dict[@"result"] intValue];
//            
//            err.code=[dict[@"msg"] intValue];
//            
//            failure(err);
//            
//            
//            
//        }else{
//            
//            success(dict);
//            
//        }
//
//        
//    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//        
//        
//        MQError *err=[MQError errorWithCode:-1 msg:@"网络请求失败"];
//        
//        failure(err);
//        
//    }];

    
   // [self test:nil dictionary:nil];


}

+ (void) test:(NSString *)urlString dictionary:(NSDictionary *)dict
{
    
    
    urlString=@"http://120.24.5.252:8088/api/Account/Login";
    
    dict=@{
           @"PhoneNumber":@"13763085121",
           @"Password":@"123456"
           };
    
   
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    
    //    "PhoneNumber":"13679587672",
    //    "Password":"123456"
    
    //  NSMutableDictionary *dict = @{@"PhoneNumber":@"13679587672",@"Password":@"123456"};
    
    [manager.requestSerializer willChangeValueForKey:@"timeoutInterval"];
    
    manager.requestSerializer.timeoutInterval = 5.0f;
    
    [manager.requestSerializer didChangeValueForKey:@"timeoutInterval"];
    
    
   
    
    [manager POST:urlString parameters:dict progress:^(NSProgress * _Nonnull uploadProgress) {
        
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
      
        
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        
        
    }];
    
    


    
}
//responseObject是接口返回来的Unicode数据
//NSLog(@" %@",[self transformDic:responseObject]);
- (NSString *)transformDic:(NSDictionary *)dic {
    if (![dic count]) {
        return nil;
    }
    NSString *tempStr1 =
    [[dic description] stringByReplacingOccurrencesOfString:@"\"u" withString:@"\"U"];
    NSString *tempStr2 = [tempStr1 stringByReplacingOccurrencesOfString:@""  withString:@"\""];
    NSString *tempStr3 = [[@"" stringByAppendingString:tempStr2] stringByAppendingString:@""];
     NSData *tempData = [tempStr3 dataUsingEncoding:NSUTF8StringEncoding];
     NSString *str = [NSPropertyListSerialization propertyListWithData:tempData options:NSPropertyListImmutable format:NULL error:NULL];
     return str;
 }



@end

























