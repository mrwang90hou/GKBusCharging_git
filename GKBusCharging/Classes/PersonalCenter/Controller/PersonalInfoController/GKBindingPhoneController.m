//
//  GKBindingPhoneController.m
//  Record
//
//  Created by 王宁 on 2018/9/30.
//  Copyright © 2018年 goockr. All rights reserved.
//

#import "GKBindingPhoneController.h"
#import "GKSetPasswordController.h"

#import "GKSignUpView.h"

//@interface GKBindingPhoneController ()<UINavigationControllerDelegate>
@interface GKBindingPhoneController ()<UINavigationControllerDelegate>
@property(nonatomic,weak)UINavigationController*navController;
@property (nonatomic,strong)UITextField * phoneTF;
@property (nonatomic,strong)UITextField * codeTF;
@end

@implementation GKBindingPhoneController

needNavBarShow;

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar setBarStyle:UIBarStyleDefault];
    self.navigationController.delegate = self;
    self.navController = self.navigationController;
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.navigationController.navigationBar setBarStyle:UIBarStyleDefault];
    self.navigationController.delegate = nil;
}

- (UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleDefault;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"绑定手机";
    
    GKSignUpView * signUpView = [[GKSignUpView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:signUpView];
    [signUpView.nextBtn addTarget:self action:@selector(nextBtnClick) forControlEvents:UIControlEventTouchUpInside];
    self.phoneTF = signUpView.phoneTF;
    self.codeTF = signUpView.codeTF;
    
#warning 测试数据
    self.phoneTF.text = @"18575857329";
    self.codeTF.text = @"1";
}

- (void)nextBtnClick{
    if(self.phoneTF.text.length == 0){
        [SVProgressHUD showErrorWithStatus:@"请输入手机号码"];
    }else{
        if ([self IsPhoneNumber:self.phoneTF.text] == YES ) {
            if(self.codeTF.text.length == 0){
                [SVProgressHUD showErrorWithStatus:@"请输入验证码"];
            }else{
                [SVProgressHUD showSuccessWithStatus:@"Success"];
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [self.navigationController pushViewController:[GKSetPasswordController new] animated:YES];
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
