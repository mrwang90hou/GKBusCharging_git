//
//  GKLoginViewController.m
//  GKBusCharging
//
//  Created by 王宁 on 2018/9/29.
//  Copyright © 2018年 goockr. All rights reserved.
//


#import "GKLoginViewController.h"

// Controllers
#import "GKNavigationController.h"
#import "GKHomeViewController.h"
////#import "DCRegisteredViewController.h"

#import "GKServiceTermsViewController.h"
// Models

// Views
//#import "GKAccountPsdByPhoneView.h" //账号密码登录
////#import "DCVerificationView.h" //验证码登录
#import "GKSignInCodeView.h"
// Vendors

// Categories

// Others
#import <AlipaySDK/AlipaySDK.h>
#import "APAuthInfo.h"
#import "APOrderInfo.h"
#import "APRSASigner.h"
#import "APWebViewController.h"


#import "WXApiRequestHandler.h"
#import "WXApiManager.h"
#import "RespForWeChatViewController.h"
#import "Constant.h"
#import "WechatAuthSDK.h"
#import "UIAlertView+WX.h"



@interface GKLoginViewController ()<WXApiManagerDelegate,UITextViewDelegate, WechatAuthAPIDelegate>

/* 上一次选中的按钮 */
@property (strong , nonatomic)UIButton *selectBtn;
/* indicatorView */
@property (strong , nonatomic)UIView *indicatorView;
/* titleView */
@property (strong , nonatomic)UIView *titleView;
/* contentView */
@property (strong , nonatomic)UIScrollView *contentView;

///* 验证码 */
//@property (strong , nonatomic)DCVerificationView *verificationView;
///* 账号密码登录 */
//@property (strong , nonatomic)GKAccountPsdByPhoneView *accountPsdView;


@property (nonatomic,strong) UIView *loginByPhoneView;

@property (nonatomic, strong) HMSegmentedControl *segmentedControl;

@property (nonatomic,strong) GKSignInCodeView *signInCodeView;

@property (nonatomic,strong) UIView *bgView;

@end

@implementation GKLoginViewController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar setHidden:true];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.navigationController.navigationBar setHidden:false];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    [self sertUpBase];
    
//    [self setUpTiTleView];
    
    [self setUpAcceptNote];
}

#pragma mark - 接受跟换控制
- (void)setUpAcceptNote
{
    [[NSNotificationCenter defaultCenter]addObserverForName:LOGINSELECTCENTERINDEX object:nil queue:[NSOperationQueue mainQueue] usingBlock:^(NSNotification * _Nonnull note) {
        [self close];
        [self.view endEditing:YES];
        //返回主视图
        [self dismissViewControllerAnimated:YES completion:nil];
        [SVProgressHUD showSuccessWithStatus:@"登录成功!"];
    }];
    
}
- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
#pragma mark - base
- (void)sertUpBase {
    self.view.backgroundColor = [UIColor whiteColor];
    self.automaticallyAdjustsScrollViewInsets = false;
}

#pragma mark - 标题登录
- (void)setUpTiTleView
{
    _titleView = [UIView new];
    _titleView.frame = CGRectMake(0, 0, ScreenW, 35);
    
    NSArray *titleArray = @[@"账号密码登录",@"短信验证登录"];
    CGFloat buttonW = (_titleView.dc_width - 30) / 2;
    CGFloat buttonH = _titleView.dc_height - 3;
    CGFloat buttonX = 15;
    CGFloat buttonY = 0;
    for (NSInteger i = 0; i < titleArray.count; i++) {
        
        UIButton *button = [UIButton  buttonWithType:UIButtonTypeCustom];
        [button setTitle:titleArray[i] forState:UIControlStateNormal];
        button.titleLabel.font = PFR16Font;
        button.tag = i;
        [button setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
        button.frame = CGRectMake((i * buttonW) + buttonX, buttonY, buttonW, buttonH);
        [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        [_titleView addSubview:button];
    }
    
    UIButton *firstButton = _titleView.subviews[0];
    [self buttonClick:firstButton];
    
    _indicatorView = [UIView new];
    _indicatorView.backgroundColor = [firstButton titleColorForState:UIControlStateSelected];
    [firstButton.titleLabel sizeToFit];
    _indicatorView.dc_height = 2;
    _indicatorView.dc_width = firstButton.titleLabel.dc_width;
    _indicatorView.dc_centerX = firstButton.dc_centerX;
    _indicatorView.dc_y = _titleView.dc_bottom - _indicatorView.dc_height;
    [_titleView addSubview:_indicatorView];
    
    self.contentView.contentSize = CGSizeMake(ScreenW * titleArray.count, 0);
}


#pragma mark - 按钮点击
- (void)buttonClick:(UIButton *)button
{
    button.selected = !button.selected;
    [_selectBtn setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    [button setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    
    _selectBtn = button;
    
    WEAKSELF
    [UIView animateWithDuration:0.25 animations:^{
        weakSelf.indicatorView.dc_width = button.titleLabel.dc_width;
        weakSelf.indicatorView.dc_centerX = button.dc_centerX;
    }];
    
    CGPoint offset = _contentView.contentOffset;
    offset.x = _contentView.dc_width * button.tag;
    [_contentView setContentOffset:offset animated:YES];
}

#pragma mark - 内容

#pragma mark - 退出当前界面
- (IBAction)dismissViewController {
//    [SVProgressHUD showInfoWithStatus:@"点击关闭退出按钮！"];
    [self.view endEditing:YES];
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)weChatLoginAction:(id)sender {
//    [SVProgressHUD showErrorWithStatus:@"暂未开通！"];
    [self sendAuthRequest];
    
}

- (IBAction)aliPayLoginAction:(id)sender {
//    [SVProgressHUD showErrorWithStatus:@"暂未开通！"];
    [self doAPAuth];
}

- (IBAction)loginByPhone:(UIButton *)sender {
    
//    self.loginByPhoneView.hidden = true;
    [self setUILoginByPhoneView];
    
    
}

-(void)setUILoginByPhoneView{
    
    // 大背景
    UIView *bgView = [[UIView alloc] init];
    [[[[UIApplication sharedApplication] delegate] window] addSubview:bgView];
    bgView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.4];
    [bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsMake(0, 0, 0, 0));
    }];
    self.bgView = bgView;
    //整体的布局view
    GKSignInCodeView *totalView = [GKSignInCodeView new];
    [bgView addSubview:totalView];
    [totalView setBackgroundColor:[UIColor whiteColor]];
    [totalView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(bgView);
        make.centerY.mas_equalTo(bgView).mas_offset(0);
        make.left.mas_equalTo(bgView.mas_left).with.offset(ScreenW/10);
        make.right.mas_equalTo(bgView.mas_right).with.offset(-ScreenW/10);
        make.height.mas_equalTo(totalView.mas_width);
        //make.width.mas_equalTo(200);
    }];
    [totalView.cancelButton addTarget:self action:@selector(close) forControlEvents:UIControlEventTouchUpInside];
    totalView.layer.masksToBounds = YES;
    totalView.layer.cornerRadius = 8;
    self.signInCodeView = totalView;
    
}

-(void)close{
    [self.bgView removeFromSuperview];
}

- (IBAction)serviceContractAction:(id)sender {
//    [SVProgressHUD showInfoWithStatus:@"服务协议！"];
    [self.navigationController pushViewController:[GKServiceTermsViewController new] animated:YES];
}


-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    NSInteger index = scrollView.contentOffset.x / scrollView.dc_width;
    UIButton *button = _titleView.subviews[index];
    
    [self buttonClick:button];
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}



#pragma mark   ==============点击模拟授权行为==============
- (void)doAPAuth
{
    // 重要说明
    // 这里只是为了方便直接向商户展示支付宝的整个支付流程；所以Demo中加签过程直接放在客户端完成；
    // 真实App里，privateKey等数据严禁放在客户端，加签过程务必要放在服务端完成；
    // 防止商户私密数据泄露，造成不必要的资金损失，及面临各种安全风险；
    /*============================================================================*/
    /*=======================需要填写商户app申请的===================================*/
    /*============================================================================*/
    NSString *pid = @"2088231170036274";
    NSString *appID = @"2018092961523884";
    
    // 如下私钥，rsa2PrivateKey 或者 rsaPrivateKey 只需要填入一个
    // 如果商户两个都设置了，优先使用 rsa2PrivateKey
    // rsa2PrivateKey 可以保证商户交易在更加安全的环境下进行，建议使用 rsa2PrivateKey
    // 获取 rsa2PrivateKey，建议使用支付宝提供的公私钥生成工具生成，
    // 工具地址：https://doc.open.alipay.com/docs/doc.htm?treeId=291&articleId=106097&docType=1
    NSString *rsa2PrivateKey = @"MIIEvQIBADANBgkqhkiG9w0BAQEFAASCBKcwggSjAgEAAoIBAQCqZkZle8BfLg8hUIcYlPsn7DEw+NugHMLX4raE412sk0zV5FKt2MWrlwIFatjXBFCAUP9G783j7jjgeb7dUn21Nbsq30ahWjVZni30hyvZ+kSQ5Ff1ztHXs0leEDrnL+kdmjdXKI8+PigZd7cyu4XmirgDAK1tORlpQgftzxjhAY5QJBLnwRAOEBSjz2knucxkCNh+tu0DOuAw1nWv3jjrM5s72oPEfTB62gIxzxIrH94+rchJHHuoHFDJFOmsUdVm7F03dEXgp1P7c3NiWBwMGhjuX3tUC3jZng3YLgHn1CIaLmYGUO+JrXl8knZhEsNmHSG89oOk3w4+DdkSEchLAgMBAAECggEBAJNiRO9QG3L31rRc/4y+h4HfZCjUhro1Rj4OZQoJ0qMLAQFcLDsb7NVelqvy370SiUKDTFmh3zaPfPiDtRefWwWahNovJts2uEBcdak0JTSzqAyexIniqlPkScgnR5thMEOfeNBVT5hpkKt+haFG2yktwL0wH9EB+z20lEEXyJAMK8OUUsweJzOkBjaYRmC3iy50SWxsRAYl8GrLI6YAbvGA6ogi44IQEwTgMG/axT3oqrr74zlywMIH8MJRcCWsqhhvMUHNlxKD6zRvf6LYNlDlHQye0zwcGh7HDFgal2o/mCOdlM5w83dYxEpRylI9JCkj2JCZ0TeduFfJPDhXVgECgYEA2vdJcR2efA3IT9TVyySfSRJ96JYwoTVI+12RcWZY/fvtLQYYZSr1XbxFvnQkQLMUdQkzUEr40UbxRQZ+A0sDHG7Vt71zZ5B2WbdIVIsp8L7TSvHAtD8WbKjtPJehrX2dstDDRQHAyqYTY+ETNAuf1frMx79PB7SMHqCV6/mkb0sCgYEAxzgsrQPMRuI150Xyf/YiKMl9kd1Ta1SBPCtlXBOiB7nV8hm3I0UKA/UiPRDWHnZZ9m5+ETLEO6u2s25vF5esmNYDNcqTzZbeop+i1vfqEshy9/rAR4XBqCqPvFwNUZam4ICKL1RbK26Cet1LBaLYYbknooqVqNmrysmwN0MbawECgYAGygQM7c4sKoE7eG3ojoohyeD9hSqc1PoeURhhW7sGpPkFnFrFSD+zWFMRRKibGPJZbp+YrbppQrnYWgsuLvU5vHYD7GvXmjMRNQ2ZEXeLb189w6El9Y7Mb7BrYIgyyOJK2Q405YkEv4F6Z1AhHPsnt08CInxg0MhHatM7LdJbYQKBgEGBMgdtoUSJaunxsOvsVY0Nu5EzshMvhRLwvfJJrlRWAYgKdpJNSB7HAowLtivsBGaoLCGhjK6GJpvXKwYZ5DGY5RNR2cmW2vuj+9otSDUG3e6173VVALk3zW1E40g5fgOBoG4xkYy1WIfnrZxb0ERJqkOix9TuRbN3H8777M8BAoGAS7f4C3g/UJ2tpencChNT6op9qzGVe/fMhAC1ILOq3PQMtTyMPgwcCrqUS8p9QepWL5KniHBYLZXwbn1MTuWJCtFxYWaq5+WYT3T1IK48xKimW9rv3Lk7m0UxfdAs+OQj3pfQbkKDNgm2Y0iF70bcGrslE+IBQ2CDwgZe59hI28c=";
    NSString *rsaPrivateKey = @"";
    /*============================================================================*/
    /*============================================================================*/
    /*============================================================================*/
    
    //pid和appID获取失败,提示
    if ([pid length] == 0 ||
        [appID length] == 0 ||
        ([rsa2PrivateKey length] == 0 && [rsaPrivateKey length] == 0))
    {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示"
                                                                       message:@"缺少pid或者appID或者私钥,请检查参数设置"
                                                                preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *action = [UIAlertAction actionWithTitle:@"知道了"
                                                         style:UIAlertActionStyleDefault
                                                       handler:^(UIAlertAction *action){
                                                           
                                                       }];
        [alert addAction:action];
        [self presentViewController:alert animated:YES completion:^{ }];
        return;
    }
    
    //生成 auth info 对象
    APAuthInfo *authInfo = [APAuthInfo new];
    authInfo.pid = pid;
    authInfo.appID = appID;
    
    //auth type
    NSString *authType = [[NSUserDefaults standardUserDefaults] objectForKey:@"authType"];
    if (authType) {
        authInfo.authType = authType;
    }
    
    //应用注册scheme,在AlixPayDemo-Info.plist定义URL types
    NSString *appScheme = @"GKBusCharging";
    
    // 将授权信息拼接成字符串
    NSString *authInfoStr = [authInfo description];
    NSLog(@"authInfoStr = %@",authInfoStr);
    
    // 获取私钥并将商户信息签名,外部商户可以根据情况存放私钥和签名,只需要遵循RSA签名规范,并将签名字符串base64编码和UrlEncode
    NSString *signedString = nil;
    APRSASigner* signer = [[APRSASigner alloc] initWithPrivateKey:((rsa2PrivateKey.length > 1)?rsa2PrivateKey:rsaPrivateKey)];
    if ((rsa2PrivateKey.length > 1)) {
        signedString = [signer signString:authInfoStr withRSA2:YES];
    } else {
        signedString = [signer signString:authInfoStr withRSA2:NO];
    }
    
    // 将签名成功字符串格式化为订单字符串,请严格按照该格式
    if (signedString.length > 0) {
        authInfoStr = [NSString stringWithFormat:@"%@&sign=%@&sign_type=%@", authInfoStr, signedString, ((rsa2PrivateKey.length > 1)?@"RSA2":@"RSA")];
        [[AlipaySDK defaultService] auth_V2WithInfo:authInfoStr
                                     fromScheme:appScheme
                                       callback:^(NSDictionary *resultDic) {
                                           NSLog(@"result = %@",resultDic);
                                           // 解析 auth code
                                           NSString *result = resultDic[@"result"];
                                           NSString *authCode = nil;
                                           if (result.length>0) {
                                               NSArray *resultArr = [result componentsSeparatedByString:@"&"];
                                               for (NSString *subResult in resultArr) {
                                                   if (subResult.length > 10 && [subResult hasPrefix:@"auth_code="]) {
                                                       authCode = [subResult substringFromIndex:10];
                                                       break;
                                                   }
                                               }
                                           }
                                           NSLog(@"授权结果 authCode = %@", authCode?:@"");
//                                           authCode?[SVProgressHUD showSuccessWithStatus:[NSString stringWithFormat:@"授权成功！authCode：%@",authCode]]:[SVProgressHUD showErrorWithStatus:@"授权失败！"];
                                       }];
    }
}
#pragma mark +++++++++++++++微信授权登录++++++++++++++++++
- (void)sendAuthRequest {
    [WXApiRequestHandler sendAuthRequestScope:kAuthScope
                                        State:kAuthState
                                       OpenID:kAuthOpenID
                             InViewController:self];
}
#pragma mark -WechatAuthAPIDelegate
/*#pragma mark -WechatAuthAPIDelegate
#pragma mark -WechatAuthAPIDelegate
//得到二维码
- (void)onAuthGotQrcode:(UIImage *)image
{
    NSLog(@"onAuthGotQrcode");
}

//二维码被扫描
- (void)onQrcodeScanned
{
    NSLog(@"onQrcodeScanned");
}

//成功登录
- (void)onAuthFinish:(int)errCode AuthCode:(NSString *)authCode
{
    NSLog(@"onAuthFinish");
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"onAuthFinish"
                                                    message:[NSString stringWithFormat:@"authCode:%@ errCode:%d", authCode, errCode]
                                                   delegate:self
                                          cancelButtonTitle:@"OK"
                                          otherButtonTitles:nil, nil];
    [alert show];
}

#pragma mark - WXApiManagerDelegate
- (void)managerDidRecvGetMessageReq:(GetMessageFromWXReq *)req {
    // 微信请求App提供内容， 需要app提供内容后使用sendRsp返回
    NSString *strTitle = [NSString stringWithFormat:@"微信请求App提供内容"];
    NSString *strMsg = [NSString stringWithFormat:@"openID: %@", req.openID];
    [UIAlertView showWithTitle:strTitle message:strMsg sure:^(UIAlertView *alertView, NSString *text) {
        RespForWeChatViewController* controller = [[RespForWeChatViewController alloc] init];
        [self presentViewController:controller animated:YES completion:nil];
    }];
}

- (void)managerDidRecvShowMessageReq:(ShowMessageFromWXReq *)req {
    WXMediaMessage *msg = req.message;
    
    //显示微信传过来的内容
    NSString *strTitle = [NSString stringWithFormat:@"微信请求App显示内容"];
    NSString *strMsg = nil;
    
    if ([msg.mediaObject isKindOfClass:[WXAppExtendObject class]]) {
        WXAppExtendObject *obj = msg.mediaObject;
        strMsg = [NSString stringWithFormat:@"openID: %@, 标题：%@ \n描述：%@ \n附带信息：%@ \n文件大小:%lu bytes\n附加消息:%@\n", req.openID, msg.title, msg.description, obj.extInfo, (unsigned long)obj.fileData.length, msg.messageExt];
    }
    else if ([msg.mediaObject isKindOfClass:[WXTextObject class]]) {
        WXTextObject *obj = msg.mediaObject;
        strMsg = [NSString stringWithFormat:@"openID: %@, 标题：%@ \n描述：%@ \n内容：%@\n", req.openID, msg.title, msg.description, obj.contentText];
    }
    else if ([msg.mediaObject isKindOfClass:[WXImageObject class]]) {
        WXImageObject *obj = msg.mediaObject;
        strMsg = [NSString stringWithFormat:@"openID: %@, 标题：%@ \n描述：%@ \n图片大小:%lu bytes\n", req.openID, msg.title, msg.description, (unsigned long)obj.imageData.length];
    }
    else if ([msg.mediaObject isKindOfClass:[WXLocationObject class]]) {
        WXLocationObject *obj = msg.mediaObject;
        strMsg = [NSString stringWithFormat:@"openID: %@, 标题：%@ \n描述：%@ \n经纬度：lng:%f_lat:%f\n", req.openID, msg.title, msg.description, obj.lng, obj.lat];
    }
    else if ([msg.mediaObject isKindOfClass:[WXFileObject class]]) {
        WXFileObject *obj = msg.mediaObject;
        strMsg = [NSString stringWithFormat:@"openID: %@, 标题：%@ \n描述：%@ \n文件类型：%@ 文件大小:%lu\n", req.openID, msg.title, msg.description, obj.fileExtension, (unsigned long)obj.fileData.length];
    }
    else if ([msg.mediaObject isKindOfClass:[WXWebpageObject class]]) {
        WXWebpageObject *obj = msg.mediaObject;
        strMsg = [NSString stringWithFormat:@"openID: %@, 标题：%@ \n描述：%@ \n网页地址：%@\n", req.openID, msg.title, msg.description, obj.webpageUrl];
    }
    [UIAlertView showWithTitle:strTitle message:strMsg sure:nil];
}

- (void)managerDidRecvLaunchFromWXReq:(LaunchFromWXReq *)req {
    WXMediaMessage *msg = req.message;
    
    //从微信启动App
    NSString *strTitle = [NSString stringWithFormat:@"从微信启动"];
    NSString *strMsg = [NSString stringWithFormat:@"openID: %@, messageExt:%@", req.openID, msg.messageExt];
    [UIAlertView showWithTitle:strTitle message:strMsg sure:nil];
}

- (void)managerDidRecvMessageResponse:(SendMessageToWXResp *)response {
    NSString *strTitle = [NSString stringWithFormat:@"发送媒体消息结果"];
    NSString *strMsg = [NSString stringWithFormat:@"errcode:%d", response.errCode];
    [UIAlertView showWithTitle:strTitle message:strMsg sure:nil];
}

- (void)managerDidRecvAddCardResponse:(AddCardToWXCardPackageResp *)response {
    NSMutableString* cardStr = [[NSMutableString alloc] init];
    for (WXCardItem* cardItem in response.cardAry) {
        [cardStr appendString:[NSString stringWithFormat:@"code:%@ cardid:%@ cardext:%@ cardstate:%u\n",cardItem.encryptCode,cardItem.cardId,cardItem.extMsg,(unsigned int)cardItem.cardState]];
    }
    [UIAlertView showWithTitle:@"add card resp" message:cardStr sure:nil];
}

- (void)managerDidRecvChooseCardResponse:(WXChooseCardResp *)response {
    NSMutableString* cardStr = [[NSMutableString alloc] init];
    for (WXCardItem* cardItem in response.cardAry) {
        [cardStr appendString:[NSString stringWithFormat:@"cardid:%@, encryptCode:%@, appId:%@\n",cardItem.cardId,cardItem.encryptCode,cardItem.appID]];
    }
    [UIAlertView showWithTitle:@"choose card resp" message:cardStr sure:nil];
}

- (void)managerDidRecvChooseInvoiceResponse:(WXChooseInvoiceResp *)response {
    NSMutableString* cardStr = [[NSMutableString alloc] init];
    for (WXInvoiceItem* cardItem in response.cardAry) {
        [cardStr appendString:[NSString stringWithFormat:@"cardid:%@, encryptCode:%@, appId:%@\n",cardItem.cardId,cardItem.encryptCode,cardItem.appID]];
    }
    [UIAlertView showWithTitle:@"choose invoice resp" message:cardStr sure:nil];
}

- (void)managerDidRecvAuthResponse:(SendAuthResp *)response {
    NSString *strTitle = [NSString stringWithFormat:@"Auth结果"];
    NSString *strMsg = [NSString stringWithFormat:@"code:%@,state:%@,errcode:%d", response.code, response.state, response.errCode];
    
    [UIAlertView showWithTitle:strTitle message:strMsg sure:nil];
}

- (void)managerDidRecvSubscribeMsgResponse:(WXSubscribeMsgResp *)response
{
    NSString *title = [NSString stringWithFormat:@"templateId:%@,scene:%@,action:%@,reserved:%@,openId:%@",response.templateId,[NSNumber numberWithInteger:response.scene],response.action,response.reserved,response.openId];
    [UIAlertView showWithTitle:title message:nil sure:nil];
}

- (void)managerDidRecvLaunchMiniProgram:(WXLaunchMiniProgramResp *)response
{
    NSString *strTitle = [NSString stringWithFormat:@"LaunchMiniProgram结果"];
    NSString *strMsg = [NSString stringWithFormat:@"errMsg:%@,errcode:%d", response.extMsg, response.errCode];
    [UIAlertView showWithTitle:strTitle message:strMsg sure:nil];
}

- (void)managerDidRecvInvoiceAuthInsertResponse:(WXInvoiceAuthInsertResp *)response
{
    NSString *strTitle = [NSString stringWithFormat:@"电子发票授权开票"];
    NSString *strMsg = [NSString stringWithFormat:@"errcode:%d,wxorderid:%@", response.errCode, response.wxOrderId];
    [UIAlertView showWithTitle:strTitle message:strMsg sure:nil];
}

- (void)managerDidRecvNonTaxpayResponse:(WXNontaxPayResp *)response
{
    NSString *strTitle = [NSString stringWithFormat:@"非税支付结果"];
    NSString *strMsg = [NSString stringWithFormat:@"errcode:%d,wxorderid:%@", response.errCode, response.wxOrderId];
    [UIAlertView showWithTitle:strTitle message:strMsg sure:nil];
}

- (void)managerDidRecvPayInsuranceResponse:(WXPayInsuranceResp *)response
{
    NSString *strTitle = [NSString stringWithFormat:@"医保支付结果"];
    NSString *strMsg = [NSString stringWithFormat:@"errcode:%d, wxorderid:%@", response.errCode, response.wxOrderId];
    [UIAlertView showWithTitle:strTitle message:strMsg sure:nil];
}

- (void)managerDidRecvOfflineResp:(WXOfflinePayResp *)response
{
    NSString *strTitle = [NSString stringWithFormat:@"离线支付结果"];
    NSString *strMsg = [NSString stringWithFormat:@"errcode:%d,errMsg:%@", response.errCode,response.errStr];
    [UIAlertView showWithTitle:strTitle message:strMsg sure:nil];
}

- (void)managerDidRecvPay:(PayResp *)resp
{
    NSString *strTitle = [NSString stringWithFormat:@"支付成功 wehcatPay结果"];
    if (resp.errCode == WXSuccess)
    {
        NSString *strMsg = [NSString stringWithFormat:@"returnKey:%@,errcode:%d", resp.returnKey, resp.errCode];
        [UIAlertView showWithTitle:strTitle message:strMsg sure:nil];
    }
    else
    {
        [UIAlertView showWithTitle:@"支付失败" message:nil sure:nil];
    }
}

- (void)managerDidRecvSubscribeMiniProgramMsg:(WXSubscribeMiniProgramMsgResp *)response
{
    NSString *strTitle = [NSString stringWithFormat:@"订阅小程序消息结果"];
    NSString *strMsg = [NSString stringWithFormat:@"errcode:%d openid:%@ nickName:%@", response.errCode,response.openId, response.nickName];
    [UIAlertView showWithTitle:strTitle message:strMsg sure:nil];
}

*/
@end
