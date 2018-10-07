//
//  GKOrderDetailsViewController.m
//  GKBusCharging
//
//  Created by 王宁 on 2018/10/8.
//  Copyright © 2018年 goockr. All rights reserved.
//


#import "GKOrderDetailsViewController.h"

// Controllers

#import "GKServiceTermsViewController.h"
// Models

// Views

// Vendors

// Categories

// Others

@interface GKOrderDetailsViewController ()

@end

@implementation GKOrderDetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"订单明细";
}
- (IBAction)serviceContractAction:(id)sender {
//    [SVProgressHUD showInfoWithStatus:@"服务协议！"];
    [self.navigationController pushViewController:[GKServiceTermsViewController new] animated:YES];
}

@end
