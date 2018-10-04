//
//  GKBalanceView.m
//  GKBusCharging
//
//  Created by 王宁 on 2018/10/4.
//  Copyright © 2018年 L. All rights reserved.
//

#import "GKBalanceView.h"

@implementation GKBalanceView
- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self){
        self.backgroundColor = RGBall(247);
        
        MJWeakSelf;
        UIView * phoneView = [UIView new];
        [self addSubview:phoneView];
        [phoneView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(weakSelf).with.offset(15);
            make.left.right.equalTo(weakSelf);
            make.height.mas_equalTo(50);
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
        
        UIView * codeView = [UIView new];
        [self addSubview:codeView];
        [codeView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.height.equalTo(phoneView);
            make.top.mas_equalTo(phoneView.mas_bottom);
        }];
        codeView.backgroundColor = [UIColor whiteColor];

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
        
        UIButton * rechargeBtn = [UIButton new];
        [codeView addSubview:rechargeBtn];
        [rechargeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(codeTF.mas_right).with.offset(10);
            make.centerY.equalTo(codeView);
            make.height.mas_equalTo(30);
            make.right.mas_equalTo(codeView).with.offset(-20);
        }];
        rechargeBtn.backgroundColor = [UIColor whiteColor];
        [rechargeBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
        [rechargeBtn setTitleColor:UIColorFromHex(0x1FCE9B) forState:UIControlStateNormal];
        rechargeBtn.titleLabel.font = GKMediumFont(12);
        //        rechargeBtn.layer.borderColor = UIColorFromHex(0xFCE9B).CGColor;
        //        rechargeBtn.layer.borderWidth = 1;
        //        rechargeBtn.layer.cornerRadius = 5;
        //        rechargeBtn.layer.masksToBounds = YES;
        [rechargeBtn addTarget:self action:@selector(codeBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [rechargeBtn setBackgroundImage:[UIImage imageNamed:@"btn_6_selected"] forState:UIControlStateDisabled];
        [rechargeBtn setBackgroundImage:[UIImage imageNamed:@"btn_6_normal"] forState:UIControlStateNormal];
        self.rechargeBtn = rechargeBtn;
        
        GKButton * getCashBtn = [GKButton new];
        [self addSubview:getCashBtn];
        [getCashBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(codeView.mas_bottom).with.offset(44);
            make.left.mas_equalTo(weakSelf).with.offset(20);
            make.right.mas_equalTo(weakSelf).with.offset(-20);
            make.height.mas_equalTo(44);
        }];
        [getCashBtn setupCircleButton];
        [getCashBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [getCashBtn setTitle:@"绑定手机" forState:UIControlStateNormal];
//        [getCashBtn addTarget:self action:@selector(nextBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        getCashBtn.titleLabel.font = GKMediumFont(16);[getCashBtn setBackgroundImage:[UIImage imageNamed:@"login_btn_1_disabled"] forState:UIControlStateDisabled];
        [getCashBtn setBackgroundImage:[UIImage imageNamed:@"login_btn_1_normal"] forState:UIControlStateNormal];
        self.getCashBtn = getCashBtn;
        self.getCashBtn.enabled = false;
        [self.phoneTF addTarget:self action:@selector(textFieldDidBeginEditing:) forControlEvents:UIControlEventEditingChanged];
        [self.codeTF addTarget:self action:@selector(textFieldDidBeginEditing:) forControlEvents:UIControlEventEditingChanged];
    }
    return self;
}

- (void)codeBtnClick:(UIButton *)btn{
    __block NSInteger time = 59; //倒计时时间
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
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
//                layer.colors = @[(id)UIColorFromHex(0x2584FF).CGColor,(id)UIColorFromHex(0x226DFF).CGColor,(id)UIColorFromHex(0x1F53FF).CGColor];
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
#pragma mark - <UITextFieldDelegate>
- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    if (_phoneTF.text.length != 0 && _codeTF.text.length != 0) {
        //        _loginButton.backgroundColor = RGB(252, 159, 149);
        self.getCashBtn.enabled = YES;
    }else{
        //        _loginButton.backgroundColor = [UIColor lightGrayColor];
        self.getCashBtn.enabled = NO;
    }
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self endEditing:YES];
}
#pragma mark - 设置初始数据
- (void)setUpUserBaseData
{
    GKUserInfo *userInfo = UserInfoData;
    if (userInfo.username.length == 0) { //userName为指定id不可改动用来判断是否有用户数据
        GKUserInfo *userInfo = [[GKUserInfo alloc] init];
        userInfo.nickname = @"RocketsChen";
        userInfo.sex = @"男";
        userInfo.birthDay = @"1996-02-10";
        userInfo.userimage = @"icon";
        userInfo.username = @"qq-w923740293";
        userInfo.defaultAddress = @"中国 上海";
        dispatch_async(dispatch_get_global_queue(0, 0), ^{//异步保存
            [userInfo saveOrUpdate];
        });
    }
}

@end
