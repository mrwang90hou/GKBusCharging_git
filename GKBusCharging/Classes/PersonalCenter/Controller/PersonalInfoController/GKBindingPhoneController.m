//
//  GKBindingPhoneController.m
//  GKBusCharging
//
//  Created by 王宁 on 2018/9/30.
//  Copyright © 2018年 goockr. All rights reserved.
//

#import "GKBindingPhoneController.h"
//#import "GKSetPasswordController.h"

#import "GKBindingPhoneView.h"

//@interface GKBindingPhoneController ()<UINavigationControllerDelegate>
@interface GKBindingPhoneController ()
@property(nonatomic,weak)UINavigationController*navController;
@property (nonatomic,strong)UITextField * phoneTF;
@property (nonatomic,strong)UITextField * codeTF;
@end

@implementation GKBindingPhoneController

//needNavBarShow;

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
//    [self.navigationController.navigationBar setBarStyle:UIBarStyleDefault];
//    self.navigationController.delegate = self;
//    self.navController = self.navigationController;
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
//    [self.navigationController.navigationBar setBarStyle:UIBarStyleDefault];
//    self.navigationController.delegate = nil;
}

- (UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleDefault;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"绑定手机";
    
    UIView *headerBGView = [[UIView alloc]initWithFrame:CGRectMake(0, K_HEIGHT_NAVBAR, ScreenW, ScreenH/4)];
    [headerBGView setBackgroundColor:RGBall(247)];
    [self.view addSubview:headerBGView];
    
    UIImageView *iconConnect = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"icon_connect"]];
    
    UIImageView *iconIphoneConnect = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"icon_iphone_connect"]];
    
    UIImageView *iconConnectLogo = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"icon_connect_logo"]];
    
    [headerBGView addSubview:iconConnect];
    [headerBGView addSubview:iconIphoneConnect];
    [headerBGView addSubview:iconConnectLogo];
    
    [iconConnect mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(headerBGView);
        make.size.mas_equalTo(CGSizeMake(20, 20));
    }];
    [iconIphoneConnect mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(headerBGView);
        make.left.mas_equalTo(ScreenW/4*3-60);
        make.size.mas_equalTo(CGSizeMake(60, 60));
    }];
    [iconConnectLogo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(headerBGView);
        make.left.mas_equalTo(ScreenW/4);
        make.size.mas_equalTo(CGSizeMake(60, 60));
    }];
    
    
    
    
    
//    [headerBGView mas_makeConstraints:^(MASConstraintMaker *make) {
//        headerBGView.
//    }];
    GKBindingPhoneView * signUpView = [[GKBindingPhoneView alloc] initWithFrame:CGRectMake(0, K_HEIGHT_NAVBAR+ScreenH/4, ScreenW, ScreenH/4*3)];
    [self.view addSubview:signUpView];
    [signUpView.nextBtn addTarget:self action:@selector(nextBtnClick) forControlEvents:UIControlEventTouchUpInside];
    self.phoneTF = signUpView.phoneTF;
    self.codeTF = signUpView.codeTF;
    
//#warning 测试数据
//    self.phoneTF.text = @"18575857329";
//    self.codeTF.text = @"1";
}

- (void)nextBtnClick{
    if(self.phoneTF.text.length == 0){
        [SVProgressHUD showErrorWithStatus:@"请输入手机号码"];
    }else{
        if ([self IsPhoneNumber:self.phoneTF.text] == YES ) {
            if(self.codeTF.text.length == 0){
                [SVProgressHUD showErrorWithStatus:@"请输入验证码"];
            }else{
                [SVProgressHUD showWithStatus:@"正在绑定..."];
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [SVProgressHUD dismiss];
                    [DCObjManager dc_saveUserData:self.phoneTF.text forKey:@"myPhone"];
                    [SVProgressHUD showSuccessWithStatus:@"绑定成功！"];
//                    [self dismissViewControllerAnimated:YES completion:nil];
                    [self.navigationController popViewControllerAnimated:YES];
                    [[NSNotificationCenter defaultCenter] postNotificationName:KNotiPhoneNumberChange object:nil];
//                    [self dismissViewControllerAnimated:YES completion:^{
//                         [SVProgressHUD showSuccessWithStatus:@"绑定成功！"];
//                    }];
//                    [self.navigationController pushViewController:[GKSetPasswordController new] animated:YES];
                });
            }
        }else{
            [SVProgressHUD showErrorWithStatus:@"无效手机号码"];
        }
    }
}

- (BOOL)IsPhoneNumber:(NSString *)number{
    NSString *phoneRegex1=@"1[3456789]([0-9]){9}";
    NSPredicate *phoneTest1 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",phoneRegex1];
    return  [phoneTest1 evaluateWithObject:number];
}
@end
