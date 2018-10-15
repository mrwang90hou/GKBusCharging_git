//
//  GKStartChargingViewController.m
//  GKBusCharging
//
//  Created by 王宁 on 2018/10/10.
//  Copyright © 2018年 goockr. All rights reserved.
//


#import "GKStartChargingViewController.h"

// Controllers

#import "GKServiceTermsViewController.h"
// Models

// Views

// Vendors

// Categories

// Others

@interface GKStartChargingViewController ()


/**
 充电状态
 */
@property (nonatomic,assign) Boolean chargingStatusBool;

@end

@implementation GKStartChargingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"开始充电";
    _chargingStatusBool = NO;
    [self getData];
//    [self requestData];
}
#pragma mark -页面逻辑方法
- (IBAction)endBtnAction:(id)sender {
    
    if (!_chargingStatusBool) {
        //返回根视图
        [self.navigationController popToRootViewControllerAnimated:YES];
    }else{
        //结束充电
    }
}

-(void)getData{
    
//    NSString *userid = self.totalData[@"userid"];
//    NSString *devid = self.totalData[@"devid"];
//    NSString *cabid = self.totalData[@"cabid"];
//    NSString *deviceID = [DCObjManager dc_readUserDataForKey:@"deviceID"];
}
- (IBAction)startChargingAction:(id)sender {
    [self requestData];
    //租借状态【动态】改变
}

#pragma mark -数据请求
//租充电线接口
-(void)requestData{
    NSString *cookid = [DCObjManager dc_readUserDataForKey:@"key"];
    if (cookid) {
        NSDictionary *dict=@{
                             @"devid":self.totalData[@"devid"],
                             @"cabid":self.totalData[@"cabid"],
                             };
        [GCHttpDataTool rentChargingLineURLWithDict:dict success:^(id responseObject) {
            [SVProgressHUD showSuccessWithStatus:@"租充电线接口成功！"];
        } failure:^(MQError *error) {
            [SVProgressHUD showErrorWithStatus:error.msg];
        }];
    }else{
        return;
    }
}
@end
