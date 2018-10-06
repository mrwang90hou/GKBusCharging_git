//
//  GKAboutUsViewController.m
//  GKBusCharging
//
//  Created by 王宁 on 2018/10/6.
//  Copyright © 2018年 goockr. All rights reserved.
//


#import "GKAboutUsViewController.h"

// Controllers

#import "GKServiceTermsViewController.h"
// Models

// Views

// Vendors

// Categories

// Others

@interface GKAboutUsViewController ()

@end

@implementation GKAboutUsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"关于我们";
}
- (IBAction)serviceContractAction:(id)sender {
//    [SVProgressHUD showInfoWithStatus:@"服务协议！"];
    [self.navigationController pushViewController:[GKServiceTermsViewController new] animated:YES];
}

@end
