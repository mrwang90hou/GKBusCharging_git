//
//  GKStartChargingViewController.m
//  GKBusCharging
//
//  Created by 王宁 on 2018/10/10.
//  Copyright © 2018年 goockr. All rights reserved.
//


#import "GKStartChargingViewController.h"

// Controllers

#import "GKServiceTermsViewController.h"
// Models

// Views
#import "XLCircleProgress.h"
// Vendors

// Categories

// Others

@interface GKStartChargingViewController ()


/**
 充电状态
 */
@property (nonatomic,assign) Boolean chargingStatusBool;

@property (strong, nonatomic) IBOutlet UIImageView *bgImageView;
@property (strong, nonatomic) IBOutlet UIButton *startChargingBtn;

@property (strong, nonatomic) IBOutlet UILabel *statusLabel;
@property (strong, nonatomic) IBOutlet UIImageView *chargingLoadingIamgeView;
@property (strong, nonatomic) IBOutlet UILabel *chargingTimeLabel;
@property (strong, nonatomic) IBOutlet UILabel *chargingTimeStatusLabel;
@property (strong, nonatomic) IBOutlet UIButton *endBtn;

@property (nonatomic,strong) SocketRocketUtility *socket;
@end

@implementation GKStartChargingViewController
{
    XLCircleProgress *_circle;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"开始充电";
    _chargingStatusBool = NO;
    [self getData];
//    [self requestData];
}


-(void)getData{
    
//    NSString *userid = self.totalData[@"userid"];
//    NSString *devid = self.totalData[@"devid"];
//    NSString *cabid = self.totalData[@"cabid"];
//    NSString *deviceID = [DCObjManager dc_readUserDataForKey:@"deviceID"];
}

-(void)updataUI{
    [_circle removeFromSuperview];
    self.chargingStatusBool = YES;
//    [self.statusLabel setText:@"正在启动"];
//    [SVProgressHUD showWithStatus:@"正在启动..."];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [SVProgressHUD showSuccessWithStatus:@"启动成功!"];
        [self.startChargingBtn setHidden:true];
        [self.statusLabel setHidden:false];
        [self.chargingLoadingIamgeView setHidden:false];
        [self.bgImageView setHidden:false];
        [self.chargingTimeLabel setHidden:false];
        [self.chargingTimeStatusLabel setHidden:false];
        [self.endBtn setTitle:@"结束充电" forState:UIControlStateNormal];
    });
    NSLog(@"┗( ´・∧・｀)┛┗( ´・∧・｀)┛┗( ´・∧・｀)┛┗( ´・∧・｀)┛┗( ´・∧・｀)┛┗( ´・∧・｀)┛┗( ´・∧・｀)┛");
    //计时器开始
    //通知 HomeViewController
    NSTimer *tm;
    [[NSNotificationCenter defaultCenter] postNotificationName:@"租电成功" object:nil userInfo:nil];
}
//动态启动动画加载
-(void)updataingUI{
//    [self addCircle];
    [self.statusLabel setText:@"正在启动..."];
    [SVProgressHUD showWithStatus:@"正在启动，请稍后..."];
}
//动态启动动画加载失败
-(void)updataingFailUI{
    [self.statusLabel setText:@"开始充电"];
}
-(void)addCircle
{
//    CGFloat margin = 15.0f;
    CGFloat circleWidth = self.startChargingBtn.bounds.size.width*1.1;
    _circle = [[XLCircleProgress alloc] initWithFrame:CGRectMake(0, 0, circleWidth, circleWidth)];
    _circle.center = self.startChargingBtn.center;
    [self.view addSubview:_circle];
    [_circle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.startChargingBtn);
        make.size.mas_equalTo(CGSizeMake(circleWidth, circleWidth));
    }];
    
    _circle.center = self.view.center;
    UISlider *slider = [[UISlider alloc] initWithFrame:CGRectMake(50, CGRectGetMaxY(_circle.frame) + 50, self.view.bounds.size.width - 2*50, 30)];
    [slider addTarget:self action:@selector(sliderMethod:) forControlEvents:UIControlEventValueChanged];
    [slider setMaximumValue:1];
    [slider setMinimumValue:0];
    [slider setMinimumTrackTintColor:[UIColor colorWithRed:255.0f/255.0f green:151.0f/255.0f blue:0/255.0f alpha:1]];
    [self.view addSubview:slider];
    
    _circle.progress = slider.value;
}
-(void)sliderMethod:(UISlider*)slider
{
    _circle.progress = slider.value;
}
- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark -页面逻辑方法
- (void) addObserver
{
    NSString *webSocketString = [NSString stringWithFormat:@"%@?type=selectcharge&userId=%@&socketId=%@",webSocketURL,self.totalData[@"userid"],self.totalData[@"devid"]];
    SocketRocketUtility *socket = [SocketRocketUtility instance];
    self.socket = socket;
    [socket SRWebSocketOpenWithURLString:webSocketString];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(SRWebSocketDidOpen) name:kWebSocketDidOpenNote object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(SRWebSocketDidReceiveMsg:) name:kWebSocketdidReceiveMessageNote object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(SRkWebSocketBreakUp:) name:kWebSocketBreakUpNote object:nil];
}
#pragma mark -页面逻辑方法
- (IBAction)endBtnAction:(id)sender {
    
    if (!_chargingStatusBool) {
        //返回根视图
        [self.navigationController popToRootViewControllerAnimated:YES];
    }else{
        //结束充电
        [self requestData2];
    }
}
- (IBAction)startChargingAction:(id)sender {
    //建立WebSocket连接
    [self addObserver];
    //租借状态【动态】改变
    [self updataingUI];
//    [self updataUI];
//    [self updataUI];
    
}

- (void)SRWebSocketDidOpen {
    NSLog(@"开启成功");
    //开启成功后的执行
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        //向服务器发生租借充电线请求
        [self requestData];
    });
    
}

- (void)SRWebSocketDidReceiveMsg:(NSNotification *)note {
    //收到服务端发送过来的消息
    NSString * result = note.object;
    result = [result stringByReplacingOccurrencesOfString:@"-" withString:@""];
    NSLog(@"result = %@",result);
    if ([result containsString:@"hello world"]) {
        return;
    }
    
    [SVProgressHUD dismiss];
    //判断收到的请求结果
    NSString *errorStr = @"";
    switch (-[result intValue]) {
//            0,xxxxxxxxx:租借成功 xxxxxxx代表机柜号
//            110:归还成功
//            -3:充电线已经被租借
//            -9:充电柜忙碌
//            -2:充电线不存在
//            -4:充电柜离线
        case 0:
            //租借成功后的变化
            [self updataUI];
            return;
//            break;
        case -2:
            errorStr = @"充电线已经被租借";
            break;
        case -3:
            errorStr = @"充电柜忙碌";
            break;
        case -4:
            errorStr = @"充电线不存在";
            break;
        case -9:
            errorStr = @"充电柜离线";
            break;
        case -110:
            errorStr = @"归还成功";
            break;
        default:
            [SVProgressHUD showInfoWithStatus:@"未知状态"];
            break;
    }
    [SVProgressHUD showErrorWithStatus:errorStr];
    [self.socket SRWebSocketClose];
//    [[SocketRocketUtility instance] SRWebSocketClose];
    [self updataingFailUI];
    NSLog(@"断开WebSocket连接");
    
    [_circle removeFromSuperview];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)SRkWebSocketBreakUp:(NSNotification *)note {
    NSLog(@"WebSocket连接失败");
    //取消动态加载
    //断开WebSocket连接
    [[SocketRocketUtility instance] SRWebSocketClose];
    NSLog(@"断开WebSocket连接");
}
#pragma mark -数据请求
//租充电线接口
-(void)requestData{
    NSString *cookid = [DCObjManager dc_readUserDataForKey:@"key"];
    if (cookid) {
        NSDictionary *dict=@{
                             @"devid":self.totalData[@"devid"],
                             @"cabid":self.totalData[@"cabid"],
                             };
        [GCHttpDataTool rentChargingLineURLWithDict:dict success:^(id responseObject) {
//            [SVProgressHUD showSuccessWithStatus:@"租充电线接口成功！"];
            NSLog(@"租充电线接口成功！");
            //updateUI
//            [self updataUI];
        } failure:^(MQError *error) {
            [SVProgressHUD showErrorWithStatus:error.msg];
        }];
    }else{
        return;
    }
}
//用户归还充电线接口
-(void)requestData2{
    NSString *cookid = [DCObjManager dc_readUserDataForKey:@"key"];
    if (cookid) {
        NSDictionary *dict=@{
                             @"devid":self.totalData[@"devid"],
                             @"cabid":self.totalData[@"cabid"],
                             };
        [GCHttpDataTool returnChargingLineWithDict:dict success:^(id responseObject) {
            [SVProgressHUD showSuccessWithStatus:@"用户归还充电线接口成功！"];
        } failure:^(MQError *error) {
            [SVProgressHUD showErrorWithStatus:error.msg];
        }];
    }else{
        return;
    }
}



@end
