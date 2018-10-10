//
//  GKTopUpTermsViewController.m
//  GFTrademark
//
//  Created by 王宁 on 2018/10/10.
//  Copyright © 2016年 gf. All rights reserved.
//

#import "GKTopUpTermsViewController.h"

@interface GKTopUpTermsViewController ()

@property (nonatomic, strong) UITextView *termsTextView;

@property (nonatomic, strong) UIWebView *termsWebView;

@end

@implementation GKTopUpTermsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"充值协议";
    self.view.backgroundColor = [UIColor whiteColor];
    [self setupSubviews];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark

- (void)setupNavigationBar {
//    [super setupNavigationBar];
}

- (void)setupSubviews {
//    _termsTextView = [[UITextView alloc]initWithFrame:self.view.bounds];
    _termsTextView = [[UITextView alloc]initWithFrame:CGRectMake(0, K_HEIGHT_NAVBAR, ScreenW, ScreenH - K_HEIGHT_NAVBAR)];
    [self.view addSubview:_termsTextView];
//    [_termsTextView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.edges.equalTo(self.view).with.insets(UIEdgeInsetsMake(8, 8, 8, 8));
//    }];
    _termsTextView.editable = NO;
    _termsTextView.font = [UIFont systemFontOfSize:16];
    _termsTextView.text = @"\t尊敬的用户，为了保障您的合法权益，请您在充值前仔细阅读本《充值协议》（充哈哈充电《充值协议》简称为“本协议”），以了解充哈哈充电的充值、提现以及余额使用规则并避免产生任何误解。当您点击“立即充值”按钮，即视为您已阅读、理解本协议，并同意按照本协议约定的规则进行充值、提现及账户余额使用。\n 1.充值本金：\n \t您通过“充哈哈充电”软件向您已注册的用户账户实际支付的金额。  2.账户余额：\n \t您的用户账户中显示的金额。  3.账户余额有效期：\n \t用户账户余额的有效期为自充值之日起至使用完毕为止。  4.账户余额使用规则：\n  \t①账户余额仅可用于支付充电所产生的费用，不可用于转移或转赠。\n  \t②用户账号使用期间，充值本金将会优先使用。  5.保证与承诺\n \t您完全理解并同意，智造车载充电所提供的充值协议所相关条款，仅适用于正当、合法按照《充值协议》使用服务的用户，一旦发现您的用户账号存在任何利用前述规则从事作弊行为以获取不正当经济利益的情形，智造车载充电有权冻结或者关闭您的用户账号以及任何其他与作弊行为相关的用户账号，并且智造车载充电保留停止向您提供服务以及根据作弊行为的严重程度进一步追究法律责任的权利。  6.特别说明\n \t在适用法律法规允许的范围内，本协议下充值、提现及账户余额的使用规则的最终解释权归智造车载充电所有。\n";
    
    //测试使用webView
//    _termsWebView = [[UIWebView alloc]initWithFrame:self.view.bounds];
//    [self.view addSubview:_termsWebView];
//    [_termsWebView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.edges.equalTo(self.view).with.insets(UIEdgeInsetsMake(8, 8, 8, 8));
//    }];
//    _termsWebView.backgroundColor = [UIColor clearColor];
//
//    NSString *terms = @"<html> <style type=\"text/css\">    .indent{text-indent: 2em;}    </style> <body><div class=\"indent\">这一段文字会自动首行缩进2字符。</div> </body>";
//
//    [_termsWebView loadHTMLString:terms baseURL:nil];
    
}

@end
