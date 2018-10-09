//
//  GKSignInCodeView.m
//  GKBusCharging
//
//  Created by 王宁 on 2018/9/30.
//  Copyright © 2018年 goockr. All rights reserved.
//

#import "GKSignInCodeView.h"
// Views
#import "UIView+Toast.h"

#import "AppDelegate.h"


@interface GKSignInCodeView ()<UITextFieldDelegate>



@end


@implementation GKSignInCodeView
- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self){
        self.backgroundColor = [UIColor whiteColor];
        
        MJWeakSelf;
        
        // 取消按钮
        UIButton *cancelButton = [[UIButton alloc] init];
        [self addSubview:cancelButton];
        [cancelButton setBackgroundImage:[UIImage imageNamed:@"btn_evaluate_close"] forState:UIControlStateNormal];
//        [cancelButton addTarget:self action:@selector(close) forControlEvents:UIControlEventTouchUpInside];
        //    [[cancelButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        //        [bgView removeFromSuperview];
        //    }];
        [cancelButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(self).mas_offset(-8);
            make.top.mas_equalTo(self.mas_top).mas_offset(8);
            make.size.mas_equalTo(CGSizeMake(20, 20));
        }];
        self.cancelButton = cancelButton;
        
        
        //手机号登录
        UILabel *phoneLabel = [[UILabel alloc]init];
        [self addSubview:phoneLabel];
        phoneLabel.text = @"手机号登录";
        [phoneLabel setFont:[UIFont fontWithName:PFR size:24]];
        [phoneLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(cancelButton.mas_bottom).with.offset(15);
            make.left.equalTo(@15);
            make.height.mas_equalTo(20);
            make.width.mas_equalTo(150);
        }];
        
        UIView * codeView = [UIView new];
        [self addSubview:codeView];
        [codeView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(self);
            make.height.mas_equalTo(50);
            make.centerX.equalTo(self);
            make.centerY.mas_equalTo(self.mas_centerY).offset(15);
//            make.top.mas_equalTo(phoneView.mas_bottom);
        }];
        codeView.backgroundColor = [UIColor whiteColor];
        self.codeView = codeView;
        
        UIView * phoneView = [UIView new];
        [self addSubview:phoneView];
        [phoneView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.mas_equalTo(codeView.mas_top);
            make.left.right.equalTo(weakSelf);
            make.height.mas_equalTo(codeView);
        }];
        phoneView.backgroundColor = [UIColor whiteColor];
        
        UIImageView * phoneIconImageView = [UIImageView new];
        [phoneView addSubview:phoneIconImageView];
        [phoneIconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(phoneView).with.offset(FixWidthNumber(17.5));
            make.centerY.equalTo(phoneView);
            make.size.mas_equalTo(CGSizeMake(22, 22));
        }];
        phoneIconImageView.contentMode = UIViewContentModeScaleAspectFit;
        phoneIconImageView.image = [UIImage imageNamed:@"icon_phone-1"];
        
        UIView * lineView = [UIView new];
        [phoneView addSubview:lineView];
        [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(phoneView).with.offset(15);
            make.right.equalTo(phoneView).with.offset(-15);
            make.bottom.mas_equalTo(phoneView).with.offset(-1);
            make.height.mas_equalTo(1);
        }];
        lineView.backgroundColor = UIColorFromHex(0xF0F0F0);
        
        UIButton * countryBtn = [UIButton new];
        [phoneView addSubview:countryBtn];
        [countryBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(phoneIconImageView.mas_right).with.offset(10);
            make.centerY.equalTo(phoneView);
            make.size.mas_equalTo(CGSizeMake(30, 26));
        }];
        [countryBtn setTitle:@"+86" forState:UIControlStateNormal];
        [countryBtn setTitleColor:UIColorFromHex(0x666666) forState:UIControlStateNormal];
        countryBtn.titleLabel.font = GKBlodFont(14);
        
        UIImageView * arrowImageView = [UIImageView new];
        [phoneView addSubview:arrowImageView];
        [arrowImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(countryBtn.mas_right).with.offset(10);
            make.centerY.equalTo(countryBtn);
            make.size.mas_equalTo(CGSizeMake(10, 10));
        }];
        arrowImageView.contentMode = UIViewContentModeScaleAspectFit;
        arrowImageView.image = [UIImage imageNamed:@"btn_pull_down"];
        
        UITextField * phoneTF = [UITextField new];
        [phoneView addSubview:phoneTF];
        [phoneTF mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(arrowImageView.mas_right).with.offset(15);
            make.right.mas_equalTo(phoneView).with.offset(-15);
            make.height.centerY.equalTo(phoneView);
        }];
        phoneTF.placeholder = @"请输入手机号码";
        phoneTF.clearButtonMode = UITextFieldViewModeWhileEditing;
        phoneTF.font = GKMediumFont(16);
        self.phoneTF = phoneTF;
        
        UIImageView * codeImageView = [UIImageView new];
        [codeView addSubview:codeImageView];
        [codeImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(codeView).with.offset(FixWidthNumber(17.5));
            make.centerY.equalTo(codeView);
            make.size.mas_equalTo(CGSizeMake(22, 22));
        }];
        codeImageView.contentMode = UIViewContentModeScaleAspectFit;
        codeImageView.image = [UIImage imageNamed:@"icon_information"];
        
        UIView * codeLineView = [UIView new];
        [codeView addSubview:codeLineView];
        [codeLineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(codeView).with.offset(15);
            make.right.equalTo(codeView).with.offset(-15);
            make.bottom.mas_equalTo(codeView).with.offset(-1);
            make.height.mas_equalTo(1);
        }];
        codeLineView.backgroundColor = UIColorFromHex(0xF0F0F0);
        
        UITextField * codeTF = [UITextField new];
        [codeView addSubview:codeTF];
        [codeTF mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(codeImageView.mas_right).with.offset(FixWidthNumber(11.5));
            make.right.mas_equalTo(codeView).with.offset(-140);
            make.centerY.equalTo(codeView);
        }];
        codeTF.clearButtonMode = UITextFieldViewModeWhileEditing;
        codeTF.placeholder = @"请输入验证码";
        codeTF.font = GKMediumFont(16);
        self.codeTF = codeTF;
        
        UIButton * codeBtn = [UIButton new];
        [codeView addSubview:codeBtn];
        [codeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(codeTF.mas_right).with.offset(10);
            make.centerY.equalTo(codeView);
            make.height.mas_equalTo(30);
            make.right.mas_equalTo(codeView).with.offset(-20);
        }];
        codeBtn.backgroundColor = [UIColor whiteColor];
        [codeBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
        [codeBtn setTitleColor:UIColorFromHex(0xFCE9B) forState:UIControlStateNormal];
        codeBtn.titleLabel.font = GKMediumFont(12);
//        codeBtn.layer.borderColor = UIColorFromHex(0xFCE9B).CGColor;
//        codeBtn.layer.borderWidth = 1;
//        codeBtn.layer.cornerRadius = 5;
//        codeBtn.layer.masksToBounds = YES;
        [codeBtn addTarget:self action:@selector(codeBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [codeBtn setBackgroundImage:[UIImage imageNamed:@"btn_6_selected"] forState:UIControlStateDisabled];
        [codeBtn setBackgroundImage:[UIImage imageNamed:@"btn_6_normal"] forState:UIControlStateNormal];
        self.codeBtn = codeBtn;
       
        GKButton * nextBtn = [GKButton new];
        [self addSubview:nextBtn];
        [nextBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(codeView.mas_bottom).with.offset(48);
            make.left.mas_equalTo(weakSelf).with.offset(20);
            make.right.mas_equalTo(weakSelf).with.offset(-20);
            make.height.mas_equalTo(44);
        }];
//        [nextBtn setupCircleButton];
        [nextBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [nextBtn setTitle:@"登录" forState:UIControlStateNormal];
        [nextBtn addTarget:self action:@selector(nextBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        nextBtn.titleLabel.font = GKMediumFont(16);
//        [nextBtn setBackgroundColor:UIColorFromHex(0xFCE9B)];
        [nextBtn setBackgroundImage:[UIImage imageNamed:@"login_btn_1_disabled"] forState:UIControlStateDisabled];
        [nextBtn setBackgroundImage:[UIImage imageNamed:@"login_btn_1_normal"] forState:UIControlStateNormal];
        self.nextBtn = nextBtn;
        self.nextBtn.enabled = false;
        
        [self.phoneTF addTarget:self action:@selector(textFieldDidBeginEditing:) forControlEvents:UIControlEventEditingChanged];
        [self.codeTF addTarget:self action:@selector(textFieldDidBeginEditing:) forControlEvents:UIControlEventEditingChanged];
        
        
        self.phoneTF.text = @"01234567890";
        
    }
    return self;
}
//获取验证码按钮
- (void)codeBtnClick:(UIButton *)btn{
    __block NSInteger time = 59; //倒计时时间
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
    
    self.nextBtn.enabled = YES;
    self.codeTF.text = @"01234";
    dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 0),1.0*NSEC_PER_SEC, 0); //每秒执行
    dispatch_source_set_event_handler(_timer, ^{
        if(time <= 0){ //倒计时结束，关闭
            dispatch_source_cancel(_timer);
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.clickLayer removeFromSuperlayer];
                [btn setTitle:@"获取验证码" forState:UIControlStateNormal];
                [btn setTitleColor:UIColorFromHex(0x1FCE9B) forState:UIControlStateNormal];
                btn.userInteractionEnabled = YES;
                btn.enabled = YES;
            });
        }else{
            int seconds = time % 60;
            dispatch_async(dispatch_get_main_queue(), ^{
                //颜色渐变
//                CAGradientLayer *layer = [CAGradientLayer layer];
//                layer.frame = CGRectMake(0, 0, btn.frame.size.width, btn.frame.size.height);
//                layer.startPoint = CGPointMake(0, 0);
//                layer.endPoint = CGPointMake(1, 1);
//                layer.colors = @[(id)UIColorFromHex(0xFCE9B).CGColor,(id)UIColorFromHex(0xFCE9B).CGColor,(id)UIColorFromHex(0xFCE9B).CGColor];
//                if (self.clickLayer ==nil) {
//                    [btn.layer insertSublayer:layer atIndex:0];
//                    self.clickLayer = layer;
//                }
                //设置按钮显示读秒效果
                [btn setTitle:[NSString stringWithFormat:@"%.2d秒重新获取", seconds] forState:UIControlStateNormal];
                [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                btn.userInteractionEnabled = NO;
                btn.enabled = NO;
            });
            time--;
        }
    });
    dispatch_resume(_timer);
}
//登录按钮
-(void)nextBtnClick:(UIButton *)btn{
//    NSString *url = [NSString stringWithFormat:@"%@/controller/api/login.php",@"http://192.168.0.107/Hotels_Server_new"];
//    NSLog(@"URL连接为：%@", url);
    if ([self.phoneTF.text isEqualToString:@""]) {
        [SVProgressHUD showInfoWithStatus:@"请输入账号"];
        return ;
    }
    if ([self.pwdTF.text isEqualToString:@""]) {
        [SVProgressHUD showInfoWithStatus:@"请输入密码"];
        return;
    }
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"telephone"] = self.phoneTF.text;
    params[@"password"] = self.pwdTF.text;
    [SVProgressHUD showWithStatus:@"正在登录"];
//    [LY_NetworkManager ly_GETRequestWithUrlString2:url parameters:params progress:nil success:^(id responseObject) {
//
////    [LY_NetworkManager ly_GETRequestWithUrlString2:url parameters:params progress:nil success:^(id *responseDict, NSDictionary *dataDict, BOOL result, NSString *errorMessage) {
////        NSArray * contentA = [responseDict objectForKey:@"code"];
////        NSArray * contentA = [responseObject objectForKey:@"content"];
////        NSLog(@"contentA=%@",contentA[0]);
//        NSLog(@"responseDict=%@",responseObject[@"code"]);
////        for (int i=0; i<contentA.count; i++) {
////            NSLog(@"%@",contentA[i]);
////        }
////        NSDictionary *json = [NSJSONSerialization JSONObjectWithData:responseDict options:NSJSONReadingMutableLeaves error:nil];
////        int a = [json[@"code"] integerValue];
////        NSLog(@"%d",a);
////        if ([[contentA[0] stringByReplacingOccurrencesOfString:@"\"" withString:@""] isEqualToString:@"200"]) {
////        if ([json[@"code"] integerValue] == 200) {
//        if ([responseObject[@"code"] integerValue] == 200) {
//            [SVProgressHUD showSuccessWithStatus:@"登录成功"];
////            UserInfo *userInfo = [[UserInfo alloc] init];
////            userInfo.id = json[@"data"][@"id"];
////            userInfo.telephone = json[@"data"][@"telephone"];
////            userInfo.password =  json[@"data"][@"password"];
////            userInfo.avator =  json[@"data"][@"avator"];
////            userInfo.birthday =  json[@"data"][@"birthday"];
////            userInfo.gender =  json[@"data"][@"gender"];
////            userInfo.account =  json[@"data"][@"account"];
////            userInfo.nickname =  json[@"data"][@"nickname"];
////            [UserManager saveUserObject:userInfo];
////            [self.navigationController popViewControllerAnimated:YES];
//        }else{
//            [SVProgressHUD showErrorWithStatus:@"登录失败"];
//        }
//    } failure:^(NSError *error, NSString *errorMessage) {
//        [SVProgressHUD showErrorWithStatus:errorMessage];
//    }];
    
    WEAKSELF
    if (![self.phoneTF.text isEqualToString:@""] && ![self.codeTF.text isEqualToString:@""]) {
        [DCObjManager dc_saveUserData:@"1" forKey:@"isLogin"]; //1代表登录
        [DCObjManager dc_saveUserData:self.phoneTF.text forKey:@"UserPhone"]; //记录手机号
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [SVProgressHUD dismiss];
            [weakSelf makeToast:@"登录成功" duration:0.5 position:CSToastPositionCenter];
//            [weakSelf setUpUserBaseData];
            AppDelegate *app=(AppDelegate *)[UIApplication sharedApplication].delegate;
            [app autoLogin];
        });
        
    }else{
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [SVProgressHUD dismiss];
            [weakSelf makeToast:@"账号密码错误请重新登录" duration:0.5 position:CSToastPositionCenter];
        });
    }
}

#pragma mark - <UITextFieldDelegate>
- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    if (_phoneTF.text.length != 0 && _codeTF.text.length != 0) {
//        _loginButton.backgroundColor = RGB(252, 159, 149);
        self.nextBtn.enabled = YES;
    }else{
//        _loginButton.backgroundColor = [UIColor lightGrayColor];
        self.nextBtn.enabled = NO;
    }
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self endEditing:YES];
}
//- (void)close{
//    [SVProgressHUD showInfoWithStatus:@"关闭成功！"];
//}
#pragma mark - 设置初始数据
//- (void)setUpUserBaseData
//{
//    GKUserInfo *userInfo = UserInfoData;
//    if (userInfo.username.length == 0) { //userName为指定id不可改动用来判断是否有用户数据
//        GKUserInfo *userInfo = [[GKUserInfo alloc] init];
//        userInfo.nickname = @"RocketsChen";
//        userInfo.sex = @"男";
//        userInfo.birthDay = @"1996-02-10";
//        userInfo.userimage = @"icon";
//        userInfo.username = @"qq-w923740293";
//        userInfo.defaultAddress = @"中国 上海";
//        dispatch_async(dispatch_get_global_queue(0, 0), ^{//异步保存
//            [userInfo saveOrUpdate];
//        });
//    }
//}


@end
