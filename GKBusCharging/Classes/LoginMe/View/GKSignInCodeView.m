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
        
//        NSString *holderText = @"请输入验证码";
//        NSMutableAttributedString *placeholder = [[NSMutableAttributedString alloc] initWithString:holderText];
//        [placeholder addAttribute:NSForegroundColorAttributeName
//                            value:[UIColor redColor]
//                            range:NSMakeRange(0, holderText.length)];
//        [placeholder addAttribute:NSFontAttributeName
//                            value:[UIFont boldSystemFontOfSize:16]
//                            range:NSMakeRange(0, holderText.length)];
//        codeTF.attributedPlaceholder = placeholder;
        
        
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
        self.phoneTF.text = @"18577986175";
//        self.codeTF.text = @"277293";
        
    }
    return self;
}
//获取验证码按钮
- (void)codeBtnClick:(UIButton *)btn{
    //验证码请求操作
    
    [self requestDataBySendMsg];
    //手机号异常或者请求失败时，则点击获取验证码无变化，提示手机号错误
    //判断手机号是否有效
    if ([self IsPhoneNumber:self.phoneTF.text] == YES ) {
        NSDictionary *dict=@{
                             @"token":@"PK1ET0sXJatywLfN",
//                             @"token":TOKEN,
                             @"phone":self.phoneTF.text,
                             };
        [SVProgressHUD showWithStatus:@"正在获取验证码..."];
        [GCHttpDataTool getLoginSmsCodeWithDict:dict success:^(id responseObject) {
            
            [SVProgressHUD dismiss];
            [SVProgressHUD showSuccessWithStatus:@"验证码发送成功！"];
            //倒计时设计
            //[MQButtonCountDownTool startTimeWithButton:self.smsCode_bt];
            __block NSInteger time = 59; //倒计时时间
            dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
            dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
            self.nextBtn.enabled = YES;
            //    self.codeTF.text = @"01234";
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
            
        } failure:^(MQError *error) {
            
            //            [self.hud hudUpdataTitile:error.msg hideTime:1.0];
            [SVProgressHUD showErrorWithStatus:error.msg];//验证码发送失败，请检查网络！
            
        }];
    }else{
        [SVProgressHUD showErrorWithStatus:@"无效手机号码"];
    }
}
//登录按钮
-(void)nextBtnClick:(UIButton *)btn{
    if ([self.phoneTF.text isEqualToString:@""]) {
        [SVProgressHUD showInfoWithStatus:@"请输入账号"];
        return ;
    }
    if ([self.pwdTF.text isEqualToString:@""]) {
        [SVProgressHUD showInfoWithStatus:@"请输入验证码"];
        return;
    }
    WEAKSELF
    if (![self.phoneTF.text isEqualToString:@""] && ![self.codeTF.text isEqualToString:@""]) {
        [SVProgressHUD showWithStatus:@"正在登录中..."];
        NSDictionary *dict=@{
                             @"phone":self.phoneTF.text,
                             @"code":self.codeTF.text,
                             @"type":PhoneTypeID,
                             };
        [GCHttpDataTool smsLoginWithDict:dict success:^(id responseObject) {
//            [[GCUser getInstance] updateUserInfoWithdict:responseObject[@"userInfo"]];
//            [MQSaveLoadTool preferenceSaveUserInfo:responseObject[@"userInfo"] whitKey:KPreferenceUserInfo];
//            [[NSNotificationCenter defaultCenter] postNotificationName:KNotiLoginSuccess object:nil];
            [DCObjManager dc_saveUserData:@"1" forKey:@"isLogin"]; //1代表登录
            [DCObjManager dc_saveUserData:@"app_termUserInfo_18577986175" forKey:@"key"]; //存储key 值
            [DCObjManager dc_saveUserData:self.phoneTF.text forKey:@"UserPhone"]; //记录手机号
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [SVProgressHUD dismiss];
                [weakSelf makeToast:@"登录成功" duration:0.5 position:CSToastPositionCenter];
                //            [weakSelf setUpUserBaseData];
                AppDelegate *app=(AppDelegate *)[UIApplication sharedApplication].delegate;
                [app autoLogin];
            });
        } failure:^(MQError *error) {
            switch (error.code) {
                case 400:
                    
                    break;
                case 500:
                    
                    break;
                    
                default:
                    break;
            }
            [SVProgressHUD showErrorWithStatus:error.msg];
        }];
        
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
#pragma mark -数据请求操作
- (void)requestDataBySendMsg{
//    [self.view endEditing:YES];
    
    //判断手机号是否有效
    if ([self IsPhoneNumber:self.phoneTF.text] == YES ) {
        NSDictionary *dict=@{
                             @"token":@"PK1ET0sXJatywLfN",
                             @"token":TOKEN,
                             @"mobile":self.phoneTF.text,
                             };
        [SVProgressHUD showWithStatus:@"正在获取验证码..."];
        [GCHttpDataTool getLoginSmsCodeWithDict:dict success:^(id responseObject) {
            
            [SVProgressHUD dismiss];
            //倒计时设计
//            [MQButtonCountDownTool startTimeWithButton:self.smsCode_bt];
            
            
        } failure:^(MQError *error) {
            
//            [self.hud hudUpdataTitile:error.msg hideTime:1.0];
            [SVProgressHUD showErrorWithStatus:error.msg];
            
        }];
    }else{
        [SVProgressHUD showErrorWithStatus:@"无效手机号码"];
    }
    
    //functype=vc&mobile=13763085121
   
}
- (BOOL)IsPhoneNumber:(NSString *)number{
    NSString *phoneRegex1=@"1[3456789]([0-9]){9}";
    NSPredicate *phoneTest1 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",phoneRegex1];
    return  [phoneTest1 evaluateWithObject:number];
}
@end
