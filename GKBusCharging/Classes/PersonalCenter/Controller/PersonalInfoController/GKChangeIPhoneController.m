//
//  GKChangeIPhoneController.m
//  GKBusCharging
//
//  Created by 王宁 on 2018/10/2.
//  Copyright © 2018年 goockr. All rights reserved.
//

#import "GKChangeIPhoneController.h"

#import "GKBindingPhoneView.h"

//@interface GKChangeIPhoneController ()<UINavigationControllerDelegate>
@interface GKChangeIPhoneController ()
@property(nonatomic,weak)UINavigationController*navController;
@property (nonatomic,strong)UITextField * phoneTF;
@property (nonatomic,strong)UITextField * codeTF;
@end

@implementation GKChangeIPhoneController

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
    self.title = @"修改手机";
    
    UIView *headerBGView = [[UIView alloc]initWithFrame:CGRectMake(0, K_HEIGHT_NAVBAR, ScreenW, ScreenH/4)];
    [headerBGView setBackgroundColor:RGBall(247)];
    [self.view addSubview:headerBGView];
    
    UILabel *phoneLabel = [[UILabel alloc]init];
//    [phoneLabel setText:@"138***38000"];
//    NSLog(@"self.phoneNumber = %@",self.phoneNumber);
    NSString *bStr = [self.phoneNumber substringWithRange:NSMakeRange(3,3)];
    NSString *newStr = [self.phoneNumber stringByReplacingOccurrencesOfString:bStr withString:@"***"];
    [phoneLabel setText:newStr];
    [phoneLabel setFont:[UIFont fontWithName:PFR size:18]];
    phoneLabel.textAlignment = NSTextAlignmentCenter;
    [headerBGView addSubview:phoneLabel];
    [phoneLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(headerBGView).offset(18);
        make.centerX.equalTo(headerBGView);
        make.size.mas_equalTo(CGSizeMake(200, 18));
    }];

    UILabel *titleLabel = [[UILabel alloc]init];
    [titleLabel setText:@"当前手机号"];
    [titleLabel setFont:[UIFont fontWithName:PFR size:16]];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    [headerBGView addSubview:titleLabel];
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(headerBGView);
        make.bottom.mas_equalTo(phoneLabel.mas_top).offset(-16);
        make.size.mas_equalTo(CGSizeMake(140, 16));
    }];
//    [headerBGView mas_makeConstraints:^(MASConstraintMaker *make) {
//        headerBGView.
//    }];
    GKBindingPhoneView * signUpView = [[GKBindingPhoneView alloc] initWithFrame:CGRectMake(0, K_HEIGHT_NAVBAR+ScreenH/4, ScreenW, ScreenH/4*3)];
    [self.view addSubview:signUpView];
    [signUpView.nextBtn addTarget:self action:@selector(nextBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [signUpView.nextBtn setTitle:@"更换手机号" forState:UIControlStateNormal];
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
//                    [[NSNotificationCenter defaultCenter] postNotificationName:KNotiPhoneNumberChange object:nil];
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
