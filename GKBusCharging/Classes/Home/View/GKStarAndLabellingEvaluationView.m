//
//  GKStarAndLabellingEvaluationView.m
//  STOExpressDelivery
//
//  Created by mrwang90hou on 2019/10/8.
//  Copyright © 2018年 goockr. All rights reserved.
//

#import "GKStarAndLabellingEvaluationView.h"
#import "AppDelegate.h"
// Controllers
//#import "DCHandPickViewController.h"
//#import "DCBeautyMessageViewController.h"
//#import "DCMediaListViewController.h"
//#import "DCBeautyShopViewController.h"
#import "GKNavigationController.h"
#import "GKHomeViewController.h"
#import "HYBStarEvaluationView.h"
// Models

// Views
#import "UIView+Toast.h"
// Vendors
#import <SVProgressHUD.h>
// Categories

// Others

@interface GKStarAndLabellingEvaluationView ()<UITextFieldDelegate,DidChangedStarDelegate>

/* 用户名 */
@property (weak, nonatomic) IBOutlet UITextField *userNameField;
/* 密码 */
@property (weak, nonatomic) IBOutlet UITextField *userPasswordField;
/* 登录 */
@property (weak, nonatomic) IBOutlet UIButton *commitButton;

//三个标签Btn
@property (weak, nonatomic) IBOutlet UIButton *labellingBtn01;
@property (weak, nonatomic) IBOutlet UIButton *labellingBtn02;
@property (weak, nonatomic) IBOutlet UIButton *labellingBtn03;

@property (nonatomic, assign) NSMutableArray *btnArray;

@property (strong, nonatomic) IBOutlet UIView *footerView;

@property (strong, nonatomic) IBOutlet UIView *endView;

@end

@implementation GKStarAndLabellingEvaluationView
//{
//    HYBStarEvaluationView * starView;
//}
#pragma mark - Intial
- (void)awakeFromNib
{
    [super awakeFromNib];
    
    [self setUpBase];
}


#pragma mark - initialize
- (void)setUpBase
{
    self.starView = [[HYBStarEvaluationView alloc]initWithFrame:CGRectMake(120, 80, 125, 22) numberOfStars:5 isVariable:YES];
//    self.starView.actualScore = self.actualScore;
    NSLog(@"actualScore = %f",self.actualScore);
    self.starView.fullScore = 5;
    self.starView.delegate = self;
    [self.footerView addSubview:self.starView];
    [self.starView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.footerView);
        make.bottom.equalTo(self.footerView.mas_centerY).offset(-60);
        make.height.equalTo(@(22));
        make.width.equalTo(@120);
    }];
    
    NSMutableArray *arr = [NSMutableArray new];

    [arr addObject:_labellingBtn01];
    [arr addObject:_labellingBtn02];
    [arr addObject:_labellingBtn03];
    self.btnArray = arr;
    int i = 1;
    for (UIButton *btn in arr) {
        btn.titleLabel.textColor = TEXTGRAYCOLOR;
        btn.backgroundColor = [UIColor clearColor];
        btn.titleLabel.font = GKMediumFont(12);
        [btn setTitleColor:UIColorFromHex(0x999999) forState:UIControlStateNormal];//0xFCE9B
        [btn setTitleColor:UIColorFromHex(0xFCE9B) forState:UIControlStateSelected];//0xFCE9B
        btn.layer.borderColor = UIColorFromHex(0x999999).CGColor;
        btn.layer.borderWidth = 1;
        btn.layer.cornerRadius = 5;
        btn.layer.masksToBounds = YES;
        btn.tag = i;
        [btn addTarget:self action:@selector(labellingBtnAction:) forControlEvents:UIControlEventTouchUpInside];
        i++;
    }


//    UIButton *endingBtn = [[UIButton alloc]init];
//    [self addSubview:endingBtn];
//    [endingBtn addTarget:self action:@selector(endingBtnAction) forControlEvents:UIControlEventTouchUpInside];
//    [endingBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];//0xFCE9B
//    [endingBtn setTitle:@"匿名提交" forState:UIControlStateNormal];
//    [endingBtn setBackgroundImage:SETIMAGE(@"btn_5_normal") forState:UIControlStateNormal];
//    self.commitButton = endingBtn;
//    self.isCommitOrNot = false;
}

- (void)labellingBtnAction:(UIButton *)btn{
    if (!btn.selected) {
        btn.layer.borderColor = UIColorFromHex(0xFCE9B).CGColor;
    }else{
        btn.layer.borderColor = UIColorFromHex(0x999999).CGColor;
    }
    btn.selected = !btn.selected;
}
- (IBAction)endingBtnAction:(UIButton *)sender{
    [SVProgressHUD showWithStatus:@"正在提交中，请稍后..."];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [SVProgressHUD dismiss];
        SIAlertView *alertView = [[SIAlertView alloc] initWithTitle:@"     " andMessage:@"提交失败，请重新提交"];
        [alertView addButtonWithTitle:@"返回"
                                 type:SIAlertViewButtonTypeDefault
                              handler:^(SIAlertView *alertView) {
                                  [alertView dismissAnimated:NO];
                                  
                              }];
        
        [alertView addButtonWithTitle:@"重新提交"
                                 type:SIAlertViewButtonTypeDestructive
                              handler:^(SIAlertView *alertView) {
                                  [alertView dismissAnimated:NO];
                                  [self againCommitFeedback];
                              }];
        [alertView show];
    });
}

-(void)againCommitFeedback{
    [SVProgressHUD showWithStatus:@"正在提交中，请稍后..."];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [SVProgressHUD dismiss];
//        [DCObjManager dc_saveUserData:@"0" forKey:@"isWorking"];
//        [self updataUI];
        self.isCommitOrNot = true;
        [SVProgressHUD showSuccessWithStatus:@"提交成功！"];
        //返回根视图
//        [self.navigationController popToRootViewControllerAnimated:YES];
//        [[NSNotificationCenter defaultCenter] postNotificationName:@"close" object:nil];
        //显示【感谢评价】
        [self.footerView setHidden:true];
        [self.endView setHidden:false];
    });
}

- (IBAction)close:(id)sender {
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"close" object:nil];
    
}

- (IBAction)loginAccountClick:(UIButton *)sender {
    WEAKSELF
    [self endEditing:YES];
    [SVProgressHUD show];
    [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
    if ([self.userNameField.text isEqualToString:@"test"] && [self.userPasswordField.text isEqualToString:@"test"]) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [SVProgressHUD dismiss];
            
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
    if (_userNameField.text.length != 0 && _userPasswordField.text.length != 0) {
        _commitButton.backgroundColor = RGB(252, 159, 149);
        _commitButton.enabled = YES;
    }else{
        _commitButton.backgroundColor = [UIColor lightGrayColor];
        _commitButton.enabled = NO;
    }
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self endEditing:YES];
}

//- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
//    NSLog(@"这次星级为 %f",starView.actualScore);
//}

- (void)didChangeStar {
    NSLog(@"这次星级为 %f",self.starView.actualScore);
    //星级评价变动
    self.starIsChanged = true;
//    [[NSNotificationCenter defaultCenter] postNotificationName:@"starIsChanged" object:nil];
}

#pragma mark - Setter Getter Methods

@end
