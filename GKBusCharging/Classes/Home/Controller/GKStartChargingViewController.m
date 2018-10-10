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
    [self requestData];
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
#pragma mark -数据请求
- (void)requestData{
    
    NSString *deviceID = [DCObjManager dc_readUserDataForKey:@"deviceID"];
    
}

@end
