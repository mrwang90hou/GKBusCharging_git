//
//  GKRechargeViewController.m
//  GKBusCharging
//
//  Created by 王宁 on 2018/10/4.
//  Copyright © 2018年 goockr. All rights reserved.
//

#import "GKRechargeViewController.h"
#import "DCGMScanViewController.h"
#import "GKRechargeStyleCell.h"
#import "GKTopUpTermsViewController.h"
//
#import <AlipaySDK/AlipaySDK.h>
#import "APAuthInfo.h"
#import "APOrderInfo.h"
#import "APRSASigner.h"
#import "APWebViewController.h"

static NSString *GKRechargeStyleCellID = @"GKRechargeStyleCell";

@interface GKRechargeViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong)UIButton * rechargeMoneyBtn01;
@property (nonatomic,strong)UIButton * rechargeMoneyBtn02;
@property (nonatomic,strong)UIButton * rechargeNowBtn;
@property (nonatomic,strong)UITableView * tableView;


@property (nonatomic,strong)NSArray * titleListArray;
@property (nonatomic,strong)NSArray * detailsListArray;
@property (nonatomic,strong)NSArray * imagesListArray;

@property (nonatomic,assign) Boolean tableViewCellSelectedState;

@end

@implementation GKRechargeViewController

//needNavBarShow;

#pragma mark -日后需设计成为layoutSubviews

#pragma mark - lazy load
-(UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];//UITableViewStyleGrouped
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [_tableView registerNib:[UINib nibWithNibName:@"GKRechargeStyleCell" bundle:nil] forCellReuseIdentifier:GKRechargeStyleCellID];
        _tableView.backgroundColor = [UIColor colorWithRed:244/255.0 green:244/255.0 blue:244/255.0 alpha:1];
        _tableView.allowsSelection = YES;
        _tableView.scrollEnabled = NO;
        _tableView.delegate = self;
        _tableView.dataSource = self;
    }
    return _tableView;
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
}

- (UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleDefault;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = TABLEVIEW_BG;
    self.title = @"充值余额";
    [self setUI];
    [self getDataFromPlist];
    self.tableViewCellSelectedState = false;
    
    //设置你想选中的某一行,我这里是第一行
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    //执行此方法,表明表视图要选中这一行
    [self.tableView selectRowAtIndexPath:indexPath animated:YES scrollPosition:UITableViewScrollPositionNone];
    //调用此方法,显示我们自定义的选中颜色
    [self tableView:self.tableView didSelectRowAtIndexPath:indexPath];
    
    self.rechargeMoneyBtn01.selected = true;
}

- (void)getDataFromPlist{
    NSString *plistPath = [[NSBundle mainBundle]pathForResource:@"RechargeStyle" ofType:@"plist"];
    // [NSBundle mainBundle] 关联的就是项目的主资源包
    //    NSBundle *bundle = [NSBundle mainBundle];
    // 利用mainBundle 获得plist文件在主资源包中的全路径
    //    NSString *file = [bundle pathForResource:@"shops" ofType:@"plist"];
    // 凡是参数名为File，传递的都是文件的全路径
    NSArray *datasArray = [NSArray arrayWithContentsOfFile:plistPath];
    NSMutableArray *titleListMuArray = [NSMutableArray new];
    NSMutableArray *detailsListMuArray = [NSMutableArray new];
    NSMutableArray *imagesListMuArray = [NSMutableArray new];
    for (NSMutableDictionary *dic in datasArray) {
        [titleListMuArray addObject:dic[@"titleLabel"]];
        [detailsListMuArray addObject:dic[@"detailsLabel"]];
        [imagesListMuArray addObject:dic[@"imageName"]];
        //        NSLog(@"dic[@'titleName'] = %@,dic[@'imageName‘] = %@",dic[@"titleName"],dic[@"imageName"]);
    }
    self.titleListArray = [titleListMuArray copy];
    self.detailsListArray = [detailsListMuArray copy];
    self.imagesListArray = [imagesListMuArray copy];
}

-(void)setUI{
    /*充值金额*/
    
    UILabel *rechargeMoneyLabel = [[UILabel alloc]init];
    [rechargeMoneyLabel setText:@"充值金额"];
    [rechargeMoneyLabel setFont:[UIFont fontWithName:PFR size:12]];
    [rechargeMoneyLabel setTextColor:TEXTMAINCOLOR];
    rechargeMoneyLabel.textAlignment = NSTextAlignmentLeft;
    [self.view addSubview:rechargeMoneyLabel];
    [rechargeMoneyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(K_HEIGHT_NAVBAR + 5);
        make.left.mas_equalTo(self.view.mas_left).offset(5);
        make.size.mas_equalTo(CGSizeMake(60, 18));
    }];
    //3元
    UIButton *rechargeMoneyBtn01 = [[UIButton alloc]init];
    [self.view addSubview:rechargeMoneyBtn01];
    [rechargeMoneyBtn01 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(rechargeMoneyLabel.mas_bottom).with.offset(20);
        make.centerX.mas_equalTo(self.view.mas_centerX).offset(-ScreenW/4);
        make.size.mas_equalTo(CGSizeMake((ScreenW-18)/2, 70));
    }];
    [rechargeMoneyBtn01 setTitleColor:TEXTMAINCOLOR forState:UIControlStateNormal];
    [rechargeMoneyBtn01 setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
    [rechargeMoneyBtn01 setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
    [rechargeMoneyBtn01 setTitle:@"3 元" forState:UIControlStateNormal];
    rechargeMoneyBtn01.titleLabel.font = GKMediumFont(15);
    [rechargeMoneyBtn01 setBackgroundImage:[UIImage imageNamed:@"recharge_amount_bg_normal"] forState:UIControlStateNormal];
    [rechargeMoneyBtn01 setBackgroundImage:[UIImage imageNamed:@"recharge_amount_bg_selected"] forState:UIControlStateSelected];
    [rechargeMoneyBtn01 setBackgroundImage:[UIImage imageNamed:@"recharge_amount_bg_selected"] forState:UIControlStateHighlighted];
    [rechargeMoneyBtn01 addTarget:self action:@selector(rechargeMoneyBtnSelected:) forControlEvents:UIControlEventTouchUpInside];
    rechargeMoneyBtn01.tag = 1;
    self.rechargeMoneyBtn01 = rechargeMoneyBtn01;
    
    //5元
    UIButton *rechargeMoneyBtn02 = [[UIButton alloc]init];
    [self.view addSubview:rechargeMoneyBtn02];
    [rechargeMoneyBtn02 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(rechargeMoneyBtn01);
        make.centerX.mas_equalTo(self.view.mas_centerX).offset(ScreenW/4);
        make.size.mas_equalTo(rechargeMoneyBtn01);
    }];
    [rechargeMoneyBtn02 setTitleColor:TEXTMAINCOLOR forState:UIControlStateNormal];
    [rechargeMoneyBtn02 setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
    [rechargeMoneyBtn02 setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
    
    [rechargeMoneyBtn02 setTitle:@"5 元" forState:UIControlStateNormal];
    rechargeMoneyBtn02.titleLabel.font = GKMediumFont(15);
    [rechargeMoneyBtn02 setBackgroundImage:[UIImage imageNamed:@"recharge_amount_bg_normal"] forState:UIControlStateNormal];
    [rechargeMoneyBtn02 setBackgroundImage:[UIImage imageNamed:@"recharge_amount_bg_selected"] forState:UIControlStateSelected];
    [rechargeMoneyBtn02 setBackgroundImage:[UIImage imageNamed:@"recharge_amount_bg_selected"] forState:UIControlStateHighlighted];
    [rechargeMoneyBtn02 addTarget:self action:@selector(rechargeMoneyBtnSelected:) forControlEvents:UIControlEventTouchUpInside];
    rechargeMoneyBtn02.tag = 2;
    self.rechargeMoneyBtn02 = rechargeMoneyBtn02;
    /*支付方式*/
    UILabel *payStyleLabel = [[UILabel alloc]init];
    [payStyleLabel setText:@"支付方式"];
    [payStyleLabel setFont:[UIFont fontWithName:PFR size:12]];
    [payStyleLabel setTextColor:TEXTMAINCOLOR];
    payStyleLabel.textAlignment = NSTextAlignmentLeft;
    [self.view addSubview:payStyleLabel];
    [payStyleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(rechargeMoneyBtn01.mas_bottom).offset(30);    make.left.mas_equalTo(self.view.mas_left).offset(5);
        make.size.mas_equalTo(CGSizeMake(60, 18));

    }];
    //tableView
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(payStyleLabel.mas_bottom).with.offset(20);
        make.width.mas_equalTo(ScreenW);
        make.bottom.mas_equalTo(self.view.mas_bottom).with.offset(-120);
    }];
//    [self.tableView setBackgroundColor:BASECOLOR];
    
    /*底部支付协议*/
    UIView *protocolView = [[UIView alloc]init];
    [self.view addSubview:protocolView];
    [protocolView setBackgroundColor:[UIColor clearColor]];
    [protocolView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self.view.mas_bottom).with.offset(-75);
        make.centerX.equalTo(self.view);
        make.height.mas_equalTo(22);
        make.width.mas_equalTo(170);
    }];
    //点击立即充值即同意《充值协议》
    UILabel *protocolLabel = [[UILabel alloc]init];
    [protocolView addSubview:protocolLabel];
    [protocolLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(protocolView);
        make.centerY.equalTo(protocolView);
        make.size.mas_equalTo(CGSizeMake(110, 18));
    }];
    [protocolLabel setText:@"点击立即充值即同意"];
    protocolLabel.textAlignment = NSTextAlignmentLeft;
    [protocolLabel setFont:[UIFont fontWithName:PFR size:12]];
    [protocolLabel setTextColor:RGBall(153)];

    UIButton * protocolBtn = [UIButton new];
    [protocolView addSubview:protocolBtn];
    [protocolBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(protocolView);
        make.left.mas_equalTo(protocolLabel.mas_right).offset(-2);
        make.size.mas_equalTo(CGSizeMake(80, 18));
    }];
    [protocolBtn setTitleColor:BASECOLOR forState:UIControlStateNormal];
    [protocolBtn setTitle:@"《充值协议》" forState:UIControlStateNormal];
    protocolBtn.titleLabel.font = GKMediumFont(12);
    [protocolBtn addTarget:self action:@selector(getprotocolBtnClick) forControlEvents:UIControlEventTouchUpInside];

    UIButton * rechargeNowBtn = [UIButton new];
    [self.view addSubview:rechargeNowBtn];
    [rechargeNowBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self.view.mas_bottom).with.offset(-20);
        make.left.mas_equalTo(self.view).with.offset(20);
        make.right.mas_equalTo(self.view).with.offset(-20);
        make.height.mas_equalTo(44);
    }];
    [rechargeNowBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [rechargeNowBtn setTitle:@"立即充值" forState:UIControlStateNormal];
    rechargeNowBtn.titleLabel.font = GKMediumFont(16);
//    [rechargeNowBtn setBackgroundImage:[UIImage imageNamed:@"btn_5_disabled"] forState:UIControlStateDisabled];
    [rechargeNowBtn setBackgroundImage:[UIImage imageNamed:@"btn_5_normal"] forState:UIControlStateNormal];
    [rechargeNowBtn addTarget:self action:@selector(rechargeNowBtnClick) forControlEvents:UIControlEventTouchUpInside];
//    [rechargeNowBtn setEnabled:false];
    self.rechargeNowBtn = rechargeNowBtn;
}

#pragma mark - UITableViewDataSourceDelegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 2;
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    GKRechargeStyleCell *cell = [tableView dequeueReusableCellWithIdentifier:GKRechargeStyleCellID forIndexPath:indexPath];
//    NSString *str = [NSString stringWithFormat:@"%@",[self.imagesListArray objectAtIndex:indexPath.row]];
    [cell.styleImageLogo setImage:[UIImage imageNamed:[self.imagesListArray objectAtIndex:indexPath.row]]];
    cell.styleLabel.text = [self.titleListArray objectAtIndex:indexPath.row];
    cell.detailsLabel.text = [self.detailsListArray objectAtIndex:indexPath.row];
//    cell.detailsLabel.text = @"wangning";
//    [cell.selectedOrNotImage setImage:[UIImage imageNamed:@"btn_payment_normal"]];

    return cell;
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
//    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
//    GKRechargeStyleCell *cell = [tableView dequeueReusableCellWithIdentifier:GKRechargeStyleCellID forIndexPath:indexPath];
//    [cell.selectedOrNotImage setImage:@""];
//    cell.selectedOrNotImage.highlighted = true;
//    [cell.selectedOrNotImage setImage:[UIImage imageNamed:@"btn_payment_selected"]];
//    if (indexPath.row == 0) {
//
//    }else{
//
//    }
    [self reloadDatasAndTable:indexPath];
}

//刷新 tabView 的选择状态
-(void)reloadDatasAndTable:(NSIndexPath *)indexPath{
    for (int i = 0; i<2; i++) {
        NSIndexPath *indexPath2 = [NSIndexPath indexPathForRow:i inSection:0];
        GKRechargeStyleCell *cell = [self.tableView cellForRowAtIndexPath:indexPath2];
        if (i == indexPath.row) {
            //请求设置分辨率
//            cell.selectedOrNotImage.highlighted = true;
//            [SVProgressHUD showInfoWithStatus:@"选择"];
            [cell.selectedOrNotImage setImage:[UIImage imageNamed:@"btn_payment_selected"]];
            cell.selected = true;
//            cell.accessoryType = UITableViewCellAccessoryCheckmark;
        }else{
//            [SVProgressHUD showInfoWithStatus:@"不选择"];
//            cell.selectedOrNotImage.highlighted = false;
            [cell.selectedOrNotImage setImage:[UIImage imageNamed:@"btn_payment_normal"]];
            cell.selected = false;
        }
        cell.selectedBackgroundView = [[UIView alloc]initWithFrame:cell.bounds];
        cell.selectedBackgroundView.backgroundColor = TABLEVIEW_BG;
    }
    
    self.tableViewCellSelectedState = true;
    Boolean bl = self.rechargeMoneyBtn01.selected||self.rechargeMoneyBtn02.selected;
    if (bl) {
        [self.rechargeNowBtn setEnabled:true];
    }
}


//充值协议
- (void)getprotocolBtnClick{
//    [SVProgressHUD showSuccessWithStatus:@"《充值协议》"];
    [self.navigationController pushViewController:[GKTopUpTermsViewController new] animated:YES];
}
//立即充值
- (void)rechargeNowBtnClick{
    for (int i = 0; i<2; i++) {
        NSIndexPath *indexPath2 = [NSIndexPath indexPathForRow:i inSection:0];
        GKRechargeStyleCell *cell = [self.tableView cellForRowAtIndexPath:indexPath2];
        Boolean bl = self.rechargeMoneyBtn01.selected||self.rechargeMoneyBtn02.selected;
        //判断只要选择
        if (cell.selected && bl) {
            switch (i) {
                case 0://微信
                    //
                    [SVProgressHUD showErrorWithStatus:@"暂未开通！"];
                    return;
                    break;
                case 1://支付宝
                    [self doAPPay];
                    break;
                default:
                    break;
            }
            
            [SVProgressHUD showWithStatus:@"正在充值..."];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [SVProgressHUD dismiss];
                [SVProgressHUD showSuccessWithStatus:@"充值成功！"];
            });
        }
    }
}

-(void)rechargeMoneyBtnSelected:(UIButton *)bt{
    if (bt.selected) {
        return;
    }else{
        if (bt.tag == 1) {
            self.rechargeMoneyBtn02.selected = false;
        }else{
            self.rechargeMoneyBtn01.selected = false;
        }
        bt.selected=!bt.selected;
    }
    if (self.tableViewCellSelectedState) {
        [self.rechargeNowBtn setEnabled:true];
    }
}
#pragma mark   ==============点击订单模拟支付行为==============
//
// 选中商品调用支付宝极简支付
//
- (void)doAPPay
{
    // 重要说明
    // 这里只是为了方便直接向商户展示支付宝的整个支付流程；所以Demo中加签过程直接放在客户端完成；
    // 真实App里，privateKey等数据严禁放在客户端，加签过程务必要放在服务端完成；
    // 防止商户私密数据泄露，造成不必要的资金损失，及面临各种安全风险；
    /*============================================================================*/
    /*=======================需要填写商户app申请的===================================*/
    /*============================================================================*/
    NSString *appID = @"2018092961523884";
    
    // 如下私钥，rsa2PrivateKey 或者 rsaPrivateKey 只需要填入一个
    // 如果商户两个都设置了，优先使用 rsa2PrivateKey
    // rsa2PrivateKey 可以保证商户交易在更加安全的环境下进行，建议使用 rsa2PrivateKey
    // 获取 rsa2PrivateKey，建议使用支付宝提供的公私钥生成工具生成，
    // 工具地址：https://doc.open.alipay.com/docs/doc.htm?treeId=291&articleId=106097&docType=1
    NSString *rsa2PrivateKey = @"MIIEvQIBADANBgkqhkiG9w0BAQEFAASCBKcwggSjAgEAAoIBAQCqZkZle8BfLg8hUIcYlPsn7DEw+NugHMLX4raE412sk0zV5FKt2MWrlwIFatjXBFCAUP9G783j7jjgeb7dUn21Nbsq30ahWjVZni30hyvZ+kSQ5Ff1ztHXs0leEDrnL+kdmjdXKI8+PigZd7cyu4XmirgDAK1tORlpQgftzxjhAY5QJBLnwRAOEBSjz2knucxkCNh+tu0DOuAw1nWv3jjrM5s72oPEfTB62gIxzxIrH94+rchJHHuoHFDJFOmsUdVm7F03dEXgp1P7c3NiWBwMGhjuX3tUC3jZng3YLgHn1CIaLmYGUO+JrXl8knZhEsNmHSG89oOk3w4+DdkSEchLAgMBAAECggEBAJNiRO9QG3L31rRc/4y+h4HfZCjUhro1Rj4OZQoJ0qMLAQFcLDsb7NVelqvy370SiUKDTFmh3zaPfPiDtRefWwWahNovJts2uEBcdak0JTSzqAyexIniqlPkScgnR5thMEOfeNBVT5hpkKt+haFG2yktwL0wH9EB+z20lEEXyJAMK8OUUsweJzOkBjaYRmC3iy50SWxsRAYl8GrLI6YAbvGA6ogi44IQEwTgMG/axT3oqrr74zlywMIH8MJRcCWsqhhvMUHNlxKD6zRvf6LYNlDlHQye0zwcGh7HDFgal2o/mCOdlM5w83dYxEpRylI9JCkj2JCZ0TeduFfJPDhXVgECgYEA2vdJcR2efA3IT9TVyySfSRJ96JYwoTVI+12RcWZY/fvtLQYYZSr1XbxFvnQkQLMUdQkzUEr40UbxRQZ+A0sDHG7Vt71zZ5B2WbdIVIsp8L7TSvHAtD8WbKjtPJehrX2dstDDRQHAyqYTY+ETNAuf1frMx79PB7SMHqCV6/mkb0sCgYEAxzgsrQPMRuI150Xyf/YiKMl9kd1Ta1SBPCtlXBOiB7nV8hm3I0UKA/UiPRDWHnZZ9m5+ETLEO6u2s25vF5esmNYDNcqTzZbeop+i1vfqEshy9/rAR4XBqCqPvFwNUZam4ICKL1RbK26Cet1LBaLYYbknooqVqNmrysmwN0MbawECgYAGygQM7c4sKoE7eG3ojoohyeD9hSqc1PoeURhhW7sGpPkFnFrFSD+zWFMRRKibGPJZbp+YrbppQrnYWgsuLvU5vHYD7GvXmjMRNQ2ZEXeLb189w6El9Y7Mb7BrYIgyyOJK2Q405YkEv4F6Z1AhHPsnt08CInxg0MhHatM7LdJbYQKBgEGBMgdtoUSJaunxsOvsVY0Nu5EzshMvhRLwvfJJrlRWAYgKdpJNSB7HAowLtivsBGaoLCGhjK6GJpvXKwYZ5DGY5RNR2cmW2vuj+9otSDUG3e6173VVALk3zW1E40g5fgOBoG4xkYy1WIfnrZxb0ERJqkOix9TuRbN3H8777M8BAoGAS7f4C3g/UJ2tpencChNT6op9qzGVe/fMhAC1ILOq3PQMtTyMPgwcCrqUS8p9QepWL5KniHBYLZXwbn1MTuWJCtFxYWaq5+WYT3T1IK48xKimW9rv3Lk7m0UxfdAs+OQj3pfQbkKDNgm2Y0iF70bcGrslE+IBQ2CDwgZe59hI28c=";
    NSString *rsaPrivateKey = @"MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAqmZGZXvAXy4PIVCHGJT7J+wxMPjboBzC1+K2hONdrJNM1eRSrdjFq5cCBWrY1wRQgFD/Ru/N4+444Hm+3VJ9tTW7Kt9GoVo1WZ4t9Icr2fpEkORX9c7R17NJXhA65y/pHZo3VyiPPj4oGXe3MruF5oq4AwCtbTkZaUIH7c8Y4QGOUCQS58EQDhAUo89pJ7nMZAjYfrbtAzrgMNZ1r9446zObO9qDxH0wetoCMc8SKx/ePq3ISRx7qBxQyRTprFHVZuxdN3RF4KdT+3NzYlgcDBoY7l97VAt42Z4N2C4B59QiGi5mBlDvia15fJJ2YRLDZh0hvPaDpN8OPg3ZEhHISwIDAQAB";
    /*============================================================================*/
    /*============================================================================*/
    /*============================================================================*/
    
    //partner和seller获取失败,提示
    if ([appID length] == 0 ||
        ([rsa2PrivateKey length] == 0 && [rsaPrivateKey length] == 0))
    {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示"
                                                                       message:@"缺少appId或者私钥,请检查参数设置"
                                                                preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *action = [UIAlertAction actionWithTitle:@"知道了"
                                                         style:UIAlertActionStyleDefault
                                                       handler:^(UIAlertAction *action){
                                                           
                                                       }];
        [alert addAction:action];
        [self presentViewController:alert animated:YES completion:^{ }];
        return;
    }
    
    /*
     *生成订单信息及签名
     */
    //将商品信息赋予AlixPayOrder的成员变量
    APOrderInfo* order = [APOrderInfo new];
    
    // NOTE: app_id设置
    order.app_id = appID;
    
    // NOTE: 支付接口名称
    order.method = @"alipay.trade.app.pay";
    
    // NOTE: 参数编码格式
    order.charset = @"utf-8";
    
    // NOTE: 当前时间点
    NSDateFormatter* formatter = [NSDateFormatter new];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    order.timestamp = [formatter stringFromDate:[NSDate date]];
    
    // NOTE: 支付版本
    order.version = @"1.0";
    
    // NOTE: sign_type 根据商户设置的私钥来决定
    order.sign_type = (rsa2PrivateKey.length > 1)?@"RSA2":@"RSA";
    
    // NOTE: 商品数据
    order.biz_content = [APBizContent new];
    order.biz_content.body = @"我是测试数据";
    order.biz_content.subject = @"1";
    order.biz_content.out_trade_no = [self generateTradeNO]; //订单ID（由商家自行制定）
    order.biz_content.timeout_express = @"30m"; //超时时间设置
    order.biz_content.total_amount = [NSString stringWithFormat:@"%.2f", 0.01]; //商品价格
    
    //将商品信息拼接成字符串
    NSString *orderInfo = [order orderInfoEncoded:NO];
    NSString *orderInfoEncoded = [order orderInfoEncoded:YES];
    NSLog(@"orderSpec = %@",orderInfo);
    
    // NOTE: 获取私钥并将商户信息签名，外部商户的加签过程请务必放在服务端，防止公私钥数据泄露；
    //       需要遵循RSA签名规范，并将签名字符串base64编码和UrlEncode
    NSString *signedString = nil;
    APRSASigner* signer = [[APRSASigner alloc] initWithPrivateKey:((rsa2PrivateKey.length > 1)?rsa2PrivateKey:rsaPrivateKey)];
    if ((rsa2PrivateKey.length > 1)) {
        signedString = [signer signString:orderInfo withRSA2:YES];
    } else {
        signedString = [signer signString:orderInfo withRSA2:NO];
    }
    
    // NOTE: 如果加签成功，则继续执行支付
    if (signedString != nil) {
        //应用注册scheme,在AliSDKDemo-Info.plist定义URL types
        NSString *appScheme = @"GKBusCharging";
        
        // NOTE: 将签名成功字符串格式化为订单字符串,请严格按照该格式
        NSString *orderString = [NSString stringWithFormat:@"%@&sign=%@",
                                 orderInfoEncoded, signedString];
        
        // NOTE: 调用支付结果开始支付
        [[AlipaySDK defaultService] payOrder:orderString fromScheme:appScheme callback:^(NSDictionary *resultDic) {
            NSLog(@"reslut = %@",resultDic);
        }];
    }
}
#pragma mark -
#pragma mark   ==============产生随机订单号==============

- (NSString *)generateTradeNO
{
    static int kNumber = 15;
    NSString *sourceStr = @"0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ";
    NSMutableString *resultStr = [[NSMutableString alloc] init];
    srand((unsigned)time(0));
    for (int i = 0; i < kNumber; i++)
    {
        unsigned index = rand() % [sourceStr length];
        NSString *oneStr = [sourceStr substringWithRange:NSMakeRange(index, 1)];
        [resultStr appendString:oneStr];
    }
    return resultStr;
}

@end
