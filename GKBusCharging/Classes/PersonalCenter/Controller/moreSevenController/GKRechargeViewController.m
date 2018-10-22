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

@end
