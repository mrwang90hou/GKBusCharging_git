//
//  DCGMScanViewController.m
//  GFMapleLeaves
//
//  Created by mrwang90hou on 2019/9/10.
//Copyright © 2018年 mrwang90hou. All rights reserved.
//

#import "DCGMScanViewController.h"
#import "GKStartChargingViewController.h"
// Controllers

// Models

// Views
#import "DCCameraTopView.h"
// Vendors

// Categories

// Others

@interface DCGMScanViewController ()<DCScanBackDelegate>

/* 顶部工具View */
@property (nonatomic, strong) DCCameraTopView *cameraTopView;

@property (nonatomic,assign) NSString *qrCodeMessage;


@end

@implementation DCGMScanViewController

#pragma mark - LazyLoad


#pragma mark - LifeCyle
//用于做扫码判定,没有这个请求头认为不是充电宝
static NSString *saomapandingUrl = @"https://www.zgzzwl.com.cn/";

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
//    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    [self.navigationController setNavigationBarHidden:YES animated:animated];
    
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
    [self.navigationController setNavigationBarHidden:NO animated:animated];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"二维码/条码";
//    self.navigationController.navigationBar.backgroundColor = [UIColor blackColor];
    
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    [self setUpBase];
    
    [self setUpTopView];
    
    [self setUpBottomView];
}

#pragma mark - initialize
- (void)setUpBase
{
    self.scanDelegate = self;
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
}

#pragma mark - 导航栏处理
- (void)setUpTopView
{
    _cameraTopView = [[DCCameraTopView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, K_HEIGHT_NAVBAR)];
    WEAKSELF
    _cameraTopView.leftItemClickBlock = ^{
        [weakSelf.navigationController popViewControllerAnimated:YES];
    };
    
    _cameraTopView.rightItemClickBlock = ^{
        [weakSelf flashButtonClick:weakSelf.flashButton];
    };
    
    _cameraTopView.rightRItemClickBlock = ^{
        [weakSelf jumpPhotoAlbum];
    };
    
    _cameraTopView.backgroundColor = [UIColor blackColor];
    [self.view addSubview:_cameraTopView];
}

- (void)setUpBottomView
{
    UIView *bottomView = [UIView new];
    bottomView.frame = CGRectMake(0, ScreenH - 65, ScreenW, 50);
    UILabel *supLabel = [UILabel new];
    
    supLabel.text = @"支持扫描";
    supLabel.font = self.tipLabel.font;
    supLabel.textAlignment = NSTextAlignmentCenter;
    supLabel.textColor = [[UIColor whiteColor]colorWithAlphaComponent:0.9];
    supLabel.frame = CGRectMake(0, 0, ScreenW, 20);
    [bottomView addSubview:supLabel];
    
    NSArray *titles = @[@"快递单",@"物价码",@"二维码"];
    NSArray *images = @[@"",@"",@""];
    CGFloat btnW = (ScreenW - 80) / titles.count;
    CGFloat btnH = bottomView.dc_height - supLabel.dc_bottom - 5;
    CGFloat btnX;
    CGFloat btnY = supLabel.frame.size.height + supLabel.frame.origin.y + 5;
    for (NSInteger i = 0; i < titles.count; i++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.titleLabel.font = [UIFont systemFontOfSize:12];
        [button setTitle:titles[i] forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:images[i]] forState:UIControlStateNormal];
        [button setTitleColor:RGBA(245, 245, 245, 1) forState:UIControlStateNormal];
        
        btnX = 40 + (i * btnW);
        button.frame = CGRectMake(btnX, btnY, btnW, btnH);
        [bottomView addSubview:button];
    }
    bottomView.hidden = true;
    [self.view addSubview:bottomView];
}

#pragma mark - <DCScanBackDelegate>
- (void)DCScanningSucessBackWithInfor:(NSString *)message
{
    NSLog(@"代理回调扫描识别结果%@",message);
    self.qrCodeMessage = message;
    //判断是【扫码】还是【识别图片中二维码】 并进行修正
//    if ([message hasSuffix:@"PIC="]) {
    if ([message rangeOfString:@"PIC="].location != NSNotFound) {
        NSLog(@"待修正的二维码");
        [message stringByReplacingOccurrencesOfString:@"PIC="withString:@""];
//        return;
//        [SVProgressHUD showSuccessWithStatus:@"通过识别图片获取二维码信息，URL 信息链接修复成功"];
    }
//    NSLog(@"message.length = %lu",(unsigned long)message.length);
    NSArray *array = [message componentsSeparatedByString:@"p="];//从字符A中分隔成2个元素的数组
    NSLog(@"array:%@",array);
    NSLog(@"array1 ==== %@",[array firstObject]);
    NSLog(@"array2 ==== %@",[array lastObject]);
    NSString *codeStr = [array lastObject];
    //判断是否为正确的【二维码】
    if ([message containsString:saomapandingUrl]) {
        //扫码接口
        NSDictionary *dict=@{
                          @"cabid":codeStr
                          };
        [GCHttpDataTool scanQRCodeChargeWithDict:dict success:^(id responseObject) {
//            [SVProgressHUD showSuccessWithStatus:@"扫码二维码成功！"];
            
            NSLog(@"正确的二维码");
            [self.navigationController popViewControllerAnimated:YES];
            NSDictionary *result = responseObject;
            [[NSNotificationCenter defaultCenter] postNotificationName:@"QRCodeSuccess" object:nil userInfo:result];
        } failure:^(MQError *error) {
            [SVProgressHUD showErrorWithStatus:error.msg];
        }];
        
        
//        [SVProgressHUD showWithStatus:@"正在跳转\n请稍后。。。"];
//        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//            [SVProgressHUD dismiss];
//            [self.navigationController pushViewController:[GKStartChargingViewController new] animated:YES];
//        });
    }else{
        NSLog(@"错误的二维码");
//        [SVProgressHUD showErrorWithStatus:@"请扫描正确的《充哈哈》产品的租电二维码"];

//        [self.navigationController popViewControllerAnimated:YES];
    }
    
    
//    [DCObjManager dc_saveUserData:@"9999887712345613" forKey:@"deviceID"]; //记录当前扫码获取的设备 deviceID
    
    
}

#pragma mark -判断逻辑的自定义方法
//判断

#pragma mark -页面逻辑方法


@end
