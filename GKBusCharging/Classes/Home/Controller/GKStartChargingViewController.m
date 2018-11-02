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

#import "GKUseGuideViewController.h"
// Models

// Views
#import "XLCircleProgress.h"
#import <FLAnimatedImage/FLAnimatedImage.h>
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


/*
 */
@property (nonatomic,assign)int seconds;
@property (nonatomic,assign)int minutes;
@property (nonatomic,assign)int hours;
@property (nonatomic,assign) int loadRecordTime;
@property (nonatomic,strong )NSTimer *timer;

@property (nonatomic,strong) SocketRocketUtility *socket;
@property (nonatomic, strong) FLAnimatedImageView *imgView;
@property (nonatomic, strong) FLAnimatedImageView *imgView2;

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
    //rightBarButton
//    UIBarButtonItem *btn1 = [[UIBarButtonItem alloc]initWithTitle:@"获取信息" style:UIBarButtonItemStyleDone target:self action:@selector(requestDataOfChargingLineStatus)];
//    UIBarButtonItem *btn2 = [[UIBarButtonItem alloc]initWithTitle:@"结束充电" style:UIBarButtonItemStyleDone target:self action:@selector(requestData2)];
//    [self.navigationItem setRightBarButtonItems:[NSArray arrayWithObjects: btn1,btn2,nil]];
    //如果为已充电状态
    if (self.hasBeenCharging) {
        self.chargingStatusBool = self.hasBeenCharging;
        [self.startChargingBtn setHidden:true];
        [self.statusLabel setHidden:false];
        [self.chargingLoadingIamgeView setHidden:false];
        [self.bgImageView setHidden:false];
//        [self.chargingTimeLabel setHidden:false];
//        [self.chargingTimeStatusLabel setHidden:false];
        [self.endBtn setTitle:@"结束充电" forState:UIControlStateNormal];
        [self requestDataOfChargingLineStatus];
        [[NSNotificationCenter defaultCenter] removeObserver:self];
        [self addObserver];
    }
}
//查询充电线状态
 -(void)requestDataOfChargingLineStatus{
     NSString *cookid = [DCObjManager dc_readUserDataForKey:@"key"];
     if (cookid) {
         [GCHttpDataTool cxChargingLineStatusWithDict:nil success:^(id responseObject) {
//             NSMutableDictionary *muTotalData = [NSMutableArray new];
//             [muTotalData setValue:responseObject[@"devid"] forKey:@"devid"];
//             [muTotalData setValue:responseObject[@"cabid"] forKey:@"cabid"];
             self.totalData = [NSMutableDictionary new];
             [self.totalData setValue:responseObject[@"devid"] forKey:@"devid"];
             [self.totalData setValue:responseObject[@"cabid"] forKey:@"cabid"];
             
             //获取当前加载时间
             int totalTimeBySeconds = [responseObject[@"time"] intValue]/1000;
             //                    totalTimeBySeconds = [htmlString intValue]/100;
             self.hours =  totalTimeBySeconds/3600;
             //format of minute
             self.minutes = (totalTimeBySeconds%3600)/60;
             //format of second
             self.seconds =  totalTimeBySeconds%60-0.5;
             //
             //            self.minutes = 0;
             //            self.hours = 0;
             //            self.seconds = 0;
             //类方法会自动释放。
             //类方法会自动释放。
             self.timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(startRecordTime) userInfo:nil repeats:YES];
             
         } failure:^(MQError *error) {
             [SVProgressHUD showErrorWithStatus:error.msg];
         }];
         NSLog(@"《冲哈哈》获取用户cookid成功");
     }else{
         //        [SVProgressHUD showErrorWithStatus:@"cookid is null"];
         NSLog(@"❌❌获取用户cookid失败❌❌");
         return;
     }
 }

-(void)getData{
    
//    NSString *userid = self.totalData[@"userid"];
//    NSString *devid = self.totalData[@"devid"];
//    NSString *cabid = self.totalData[@"cabid"];
//    NSString *deviceID = [DCObjManager dc_readUserDataForKey:@"deviceID"];
    
    
    //读取gif数据
//    NSData *gifData = [NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"chraging_btn_normal" ofType:@"gif"]];
//    UIWebView *webView = [[UIWebView alloc] init]; // 自己设置尺寸大小
//    // 最后添加到需要添加的视图位置就行了，例如：
//    [self.view addSubview:webView];
//    [webView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.center.equalTo(self.chargingLoadingIamgeView);
//        make.size.equalTo(self.chargingLoadingIamgeView);
//    }];
//    //取消回弹效果
//    webView.scrollView.bounces = NO;
//    webView.backgroundColor = [UIColor clearColor];
//    //设置缩放模式
//    webView.scalesPageToFit = YES;
//    //用webView加载数据
//    [webView loadData:gifData MIMEType:@"image/gif" textEncodingName:nil baseURL:nil];
    /*********/
    
    
//    self.startChargingBtn.layer.masksToBounds = YES;
//    self.startChargingBtn.layer.cornerRadius = 110;
//    self.startChargingBtn.layer.cornerRadius = 90;
    
    
    FLAnimatedImageView *imgView = [FLAnimatedImageView new];
    imgView.contentMode = UIViewContentModeScaleAspectFit;
    [self.startChargingBtn addSubview:imgView];
    [imgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.startChargingBtn);
//        make.size.equalTo(self.startChargingBtn);
        make.edges.mas_equalTo(UIEdgeInsetsMake(-15, -15, -15, -15));
        make.size.mas_equalTo(CGSizeMake(220, 220));
    }];
    NSString  *filePath = [[NSBundle bundleWithPath:[[NSBundle mainBundle] bundlePath]]pathForResource:@"chraging_btn_normal" ofType:@"gif"];
    NSData *imageData = [NSData dataWithContentsOfFile:filePath];
    imgView.backgroundColor = [UIColor clearColor];
    imgView.animatedImage = [FLAnimatedImage animatedImageWithGIFData:imageData];
    
    FLAnimatedImageView *imgView2 = [FLAnimatedImageView new];
    imgView2.contentMode = UIViewContentModeScaleAspectFit;
    [self.startChargingBtn addSubview:imgView2];
    [imgView2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.startChargingBtn);
        make.size.equalTo(imgView);
//        make.edges.mas_equalTo(UIEdgeInsetsMake(-15, -15, -15, -15));
    }];
    NSString  *filePath2 = [[NSBundle bundleWithPath:[[NSBundle mainBundle] bundlePath]]pathForResource:@"chraging_btn_loading" ofType:@"gif"];
    NSData  *imageData2 = [NSData dataWithContentsOfFile:filePath2];
    imgView2.backgroundColor = [UIColor clearColor];
    imgView2.animatedImage = [FLAnimatedImage animatedImageWithGIFData:imageData2];
    
//    [self.startChargingBtn setImage:imgView forState:UIControlStateNormal];
//    [self.startChargingBtn setImage:imgView2 forState:UIControlStateSelected];
    
    [imgView setHidden:false];
    [imgView2 setHidden:true];
    self.imgView = imgView;
    self.imgView2 = imgView2;
//
//
//    if (!self.imageView1) {
//        self.imageView1 = [[FLAnimatedImageView alloc] init];
//        self.imageView1.contentMode = UIViewContentModeScaleAspectFill;
//        self.imageView1.clipsToBounds = YES;
//    }
//    [self.view addSubview:self.imageView1];
//    self.imageView1.frame = CGRectMake(0.0, 120.0, self.view.bounds.size.width, 447.0);
//
//    NSURL *url1 = [[NSBundle mainBundle] URLForResource:@"rock" withExtension:@"gif"];
//    NSData *data1 = [NSData dataWithContentsOfURL:url1];
//    FLAnimatedImage *animatedImage1 = [FLAnimatedImage animatedImageWithGIFData:data1];
//    self.imageView1.animatedImage = animatedImage1;

    
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
    _hours = 0;
    _minutes = 0;
    _seconds = 0;
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(startRecordTime) userInfo:nil repeats:YES];
    //通知 HomeViewController
//    NSTimer *tm;
    [[NSNotificationCenter defaultCenter] postNotificationName:@"租电成功" object:nil userInfo:nil];
    
}
//动态启动动画加载
-(void)updataingUI{
//    [self addCircle];
    [self.statusLabel setText:@"正在启动..."];
//    [SVProgressHUD showWithStatus:@"正在启动，请稍后..."];
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
    NSString *webSocketString = [NSString stringWithFormat:@"%@?type=selectcharge&userId=%@&socketId=%@",WebSocketURL,self.totalData[@"userid"],self.totalData[@"devid"]];
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
        //打开使用指南
        [self.navigationController pushViewController:[GKUseGuideViewController new] animated:YES];
    }else{
        //结束充电
        [self requestData2];
    }
}

- (IBAction)startChargingAction:(id)sender {
    //建立WebSocket连接
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [self addObserver];
    //租借状态【动态】改变
    [self updataingUI];
//    [self updataUI];
    
    [self.imgView setHidden:true];
    [self.imgView2 setHidden:false];
}

- (void)SRWebSocketDidOpen {
    NSLog(@"开启成功");
    //开启成功后的执行
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        //向服务器发生租借充电线请求
//        [self requestData];
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
            [self.statusLabel setText:@"开始充电"];
            [self.socket SRWebSocketClose];
            //断开WebSocket连接
            [[SocketRocketUtility instance] SRWebSocketClose];
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
//            [SVProgressHUD showSuccessWithStatus:@"用户归还充电线接口成功！"];
            [SVProgressHUD showSuccessWithStatus:@"归还成功！"];
            //转回初始状态
            [self getBackDidLoadView];
            
        } failure:^(MQError *error) {
            [SVProgressHUD showErrorWithStatus:error.msg];
        }];
    }else{
        return;
    }
}

-(void)startRecordTime{
    _seconds++;
    //没过１００毫秒，就让秒＋１，然后让毫秒在归零
    if(_seconds==60){
        _minutes++;
        _seconds = 0;
    }
    if (_minutes == 60) {
        _hours++;
        _minutes = 0;
    }
    //让不断变量的时间数据进行显示到label上面。
    self.chargingTimeLabel.text = [NSString stringWithFormat:@"%02d:%02d:%02d",_hours,_minutes,_seconds];
    [self.chargingTimeLabel setHidden:false];
    [self.chargingTimeStatusLabel setHidden:false];
}

//返回初始 View 加载完成的状态
- (void)getBackDidLoadView{
    //需要让定时器暂停
    [self.timer setFireDate:[NSDate distantFuture]];
    self.chargingStatusBool = false;
    [self.startChargingBtn setHidden:false];
    [self.statusLabel setHidden:false];
    [self.chargingLoadingIamgeView setHidden:true];
    [self.bgImageView setHidden:true];
    [self.chargingTimeLabel setHidden:true];
    [self.chargingTimeStatusLabel setHidden:true];
    [self.endBtn setTitle:@"使用指南" forState:UIControlStateNormal];
    [self.statusLabel setText:@"开始充电"];
    [self.startChargingBtn setHidden:false];
    //反馈给 homeViewController
    [[NSNotificationCenter defaultCenter] postNotificationName:@"EndCharging" object:nil];
    //关闭 webSocket
    [self.socket SRWebSocketClose];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [self selfAlterViewback];
}
#pragma 退出界面
- (void)selfAlterViewback
{
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
