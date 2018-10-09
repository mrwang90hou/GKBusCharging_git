//
//  GKOrderRateViewController.m
//  GKBusCharging
//
//  Created by 王宁 on 2018/9/29.
//  Copyright © 2018年 goockr. All rights reserved.
//


#import "GKOrderRateViewController.h"

// Controllers
#import "GKNavigationController.h"
#import "DCGMScanViewController.h"
#import "JFCityViewController.h"
#import "SDCycleScrollView.h"
#import "GKBusMoreInfoViewController.h"
#import "GKOrderDetailsViewController.h"
//#import "DCTabBarController.h"
//#import "DCRegisteredViewController.h"
// Models

// Views
#import "GKPersonalHeaderView.h"
#import "GKCustomFlowLayout.h"
#import "GKBusInfoCell.h"
#import "GKOrderCell.h"
#import "HYBStarEvaluationView.h"
// Vendors

// Categories

#import "GKUpDownButton.h"
#import "DCZuoWenRightButton.h"
#import "DCLIRLButton.h"
// Others
//#import "AFNetPackage.h"

#define HeaderImageHeight ScreenW/2

#define kLineSpacing DCMargin/2

static NSString *GKBusInfoCellID = @"GKBusInfoCell";
static NSString *GKOrderCellID = @"GKOrderCell";

@interface GKOrderRateViewController ()<UITableViewDelegate,UITableViewDataSource,DidChangedStarDelegate,UITextViewDelegate>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *evaluations;
@property (nonatomic, strong) UILabel *costLabel;
@property (nonatomic, strong) UIButton *detailsCheckBtn;//DCZuoWenRightButton



//三个标签Btn
@property (nonatomic, strong) UIButton *labellingBtn01;
@property (nonatomic, strong) UIButton *labellingBtn02;
@property (nonatomic, strong) UIButton *labellingBtn03;

@property (nonatomic, assign) NSMutableArray *btnArray;

//评价内容
@property (nonatomic, strong) UITextView *evaluationContentTF;
//标记是否提交成功！
@property (nonatomic, assign) Boolean isCommitOrNot;
@property (nonatomic ,strong) UIButton *endingBtn;


@property(nonatomic,strong)UITextView *textView;
@property(nonatomic,strong)UILabel *placeHolderLabel;
@property(nonatomic,strong)UILabel *residueLabel;// 输入文本时剩余字数


@end

@implementation GKOrderRateViewController
{
    HYBStarEvaluationView * starView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
//    self.title = @"订单评价";
    [self.view setBackgroundColor:TABLEVIEW_BG];
    [self setupUI];
}

-(void)setupUI{
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.edges.equalTo(self.view);
        make.top.left.right.equalTo(self.view);
//        make.bottom.mas_equalTo(K_HEIGHT_NAVBAR+120);
        make.height.mas_equalTo(K_HEIGHT_NAVBAR+90);
    }];
    /* 消费详情view */
    UIView *consumeView = [[UIView alloc]init];
    [self.view addSubview:consumeView];
    [consumeView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.tableView.mas_bottom).offset(0);
        make.left.right.equalTo(self.view);
        make.height.equalTo(@(100));
    }];
    [consumeView setBackgroundColor:[UIColor whiteColor]];
    
    //设置定位按钮
//    DCZuoWenRightButton *detailsCheckBtn = [DCZuoWenRightButton buttonWithType:UIButtonTypeRoundedRect];
    UIButton *detailsCheckBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    
//    [detailsCheckBtn setImage:SETIMAGE(@"home_icon_page_more") forState:0];
    // 设置图标
    [detailsCheckBtn setTitle:@"查看明细>" forState:UIControlStateNormal];
    [detailsCheckBtn setTitleColor:TEXTGRAYCOLOR forState:UIControlStateNormal];
    detailsCheckBtn.titleLabel.font = PFR12Font;
    [detailsCheckBtn addTarget:self action:@selector(detailsCheckBtnAction) forControlEvents:UIControlEventTouchUpInside];
    [consumeView addSubview:detailsCheckBtn];
    [detailsCheckBtn mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.mas_equalTo(consumeView.mas_left).offset(4);
        make.centerX.equalTo(consumeView);
        make.centerY.equalTo(consumeView.mas_centerY).offset(22);
        make.height.equalTo(@(22));
        make.width.equalTo(@90);
    }];
    self.detailsCheckBtn = detailsCheckBtn;
    
    UILabel *costLabel = [[UILabel alloc]init];
    [consumeView addSubview:costLabel];
    [costLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(consumeView);
        make.bottom.equalTo(consumeView.mas_centerY);
        make.height.equalTo(@(22));
        make.width.equalTo(@200);
    }];
    costLabel.textAlignment = NSTextAlignmentCenter;
    [costLabel setFont:GKBlodFont(36)];
    [costLabel setTextColor:TEXTMAINCOLOR];
    [costLabel setText:@"10.00元"];
    self.costLabel = costLabel;
//    [costLabel setText:[NSString stringWithFormat:@"",self.]];
    
    
    
    /* 评价View */
    UIView *evaluateView = [[UIView alloc]init];
    [self.view addSubview:evaluateView];
    [evaluateView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(consumeView.mas_bottom).offset(1);
        make.left.right.equalTo(self.view);
        make.bottom.equalTo(self.view);
    }];
    [evaluateView setBackgroundColor:[UIColor whiteColor]];
    
    /*（1）HeaderView*/
    UIView *evaluateHeaderView = [[UIView alloc]init];
    [evaluateView addSubview:evaluateHeaderView];
    [evaluateHeaderView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(evaluateView);
        make.left.right.equalTo(self.view);
        make.height.equalTo(@(80));
    }];
    UILabel *titleLabel = [[UILabel alloc]init];
    [evaluateHeaderView addSubview:titleLabel];
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(evaluateHeaderView);
        make.bottom.equalTo(evaluateHeaderView.mas_centerY).offset(-5);
        make.height.equalTo(@(17));
        make.width.equalTo(@120);
    }];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    [titleLabel setFont:GKFont(12)];
    [titleLabel setTextColor:TEXTGRAYCOLOR];
    [titleLabel setText:@"匿名评价司机"];
    
    starView = [[HYBStarEvaluationView alloc]initWithFrame:CGRectMake(120, 80, 125, 22) numberOfStars:5 isVariable:YES];
    starView.actualScore = 0;
    starView.fullScore = 5;
    starView.delegate = self;
    [evaluateHeaderView addSubview:starView];
    [starView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(evaluateHeaderView);
        make.top.equalTo(evaluateHeaderView.mas_centerY).offset(5);
        make.height.equalTo(@(22));
        make.width.equalTo(@120);
    }];
    /*（2）footerView*/
    UIView *evaluateFooterView = [[UIView alloc]init];
    [evaluateView addSubview:evaluateFooterView];
    [evaluateFooterView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(evaluateHeaderView.mas_bottom);
        make.left.right.equalTo(self.view);
        make.bottom.equalTo(self.view);
    }];
    UILabel *hintLabel = [[UILabel alloc]init];
    [evaluateFooterView addSubview:hintLabel];
    [hintLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(evaluateFooterView);
        make.top.equalTo(evaluateFooterView.mas_top).offset(3);
        make.height.equalTo(@(17));
        make.width.equalTo(@120);
    }];
    hintLabel.textAlignment = NSTextAlignmentCenter;
    [hintLabel setFont:GKFont(12)];
    [hintLabel setText:@"夸夸司机吧"];
    //先布局evaluationContentTF评价内容
    UITextView *evaluationContentTF = [[UITextView alloc]init];
    [evaluateFooterView addSubview:evaluationContentTF];
    [evaluationContentTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(evaluateFooterView);
        make.centerY.equalTo(evaluateFooterView).offset(0);
        make.width.mas_equalTo(ScreenW-30);
//        make.height.mas_equalTo(evaluateFooterView.bounds.size.height/2);
        make.height.mas_equalTo(120);
    }];
    evaluationContentTF.dataDetectorTypes = UIDataDetectorTypePhoneNumber | UIDataDetectorTypeLink;
    evaluationContentTF.backgroundColor = TABLEVIEW_BG;
    evaluationContentTF.textColor = [UIColor darkGrayColor];
    evaluationContentTF.text = @"请输入评价内容";
    evaluationContentTF.font = [UIFont systemFontOfSize:15.0];
    evaluationContentTF.layer.cornerRadius = 6.0;
    evaluationContentTF.layer.borderColor = [UIColor groupTableViewBackgroundColor].CGColor;
    evaluationContentTF.layer.borderWidth = 1 / ([UIScreen mainScreen].scale);
    self.evaluationContentTF = evaluationContentTF;
    
    //三个标签Btn   labellingBtn01
    UIButton *labellingBtn01 = [[UIButton alloc]init];
    UIButton *labellingBtn02 = [[UIButton alloc]init];
    UIButton *labellingBtn03 = [[UIButton alloc]init];
    
    [evaluateFooterView addSubview:labellingBtn01];
    [evaluateFooterView addSubview:labellingBtn02];
    [evaluateFooterView addSubview:labellingBtn03];
    [labellingBtn02 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(evaluationContentTF.mas_top).offset(-8);
        make.centerX.equalTo(evaluateFooterView);
        make.size.mas_equalTo(CGSizeMake(75, 22));
    }];
    [labellingBtn01 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(labellingBtn02);
//        make.centerX.equalTo(@(ScreenW/4));
        make.centerX.mas_equalTo(self.view.mas_centerX).offset(-ScreenW/4);
        make.size.mas_equalTo(CGSizeMake(75, 22));
    }];
    [labellingBtn03 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(labellingBtn02);
//        make.centerX.mas_equalTo(ScreenW/4*3);
        make.centerX.mas_equalTo(self.view.mas_centerX).offset(ScreenW/4);
        make.size.mas_equalTo(CGSizeMake(75, 22));
    }];
    [labellingBtn01 setTitle:@"车内整洁" forState:UIControlStateNormal];
    [labellingBtn02 setTitle:@"驾驶平稳" forState:UIControlStateNormal];
    [labellingBtn03 setTitle:@"司机态度好" forState:UIControlStateNormal];
    
    
    self.labellingBtn01  = labellingBtn01;
    self.labellingBtn02  = labellingBtn02;
    self.labellingBtn03  = labellingBtn03;
    
    NSMutableArray *arr = [NSMutableArray new];
    
    [arr addObject:labellingBtn01];
    [arr addObject:labellingBtn02];
    [arr addObject:labellingBtn03];
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
//    labellingBtn01.titleLabel.textColor = TEXTGRAYCOLOR;
//    labellingBtn02.titleLabel.textColor = TEXTGRAYCOLOR;
//    labellingBtn03.titleLabel.textColor = TEXTGRAYCOLOR;
//
//    labellingBtn02.backgroundColor = [UIColor clearColor];
//    labellingBtn02.titleLabel.font = GKMediumFont(12);
//    [labellingBtn02 setTitleColor:UIColorFromHex(0x999999) forState:UIControlStateNormal];//0xFCE9B
//    labellingBtn02.layer.borderColor = UIColorFromHex(0x999999).CGColor;
//    labellingBtn02.layer.borderWidth = 1;
//    labellingBtn02.layer.cornerRadius = 5;
//    labellingBtn02.layer.masksToBounds = YES;
    
    UIButton *endingBtn = [[UIButton alloc]init];
    [evaluateFooterView addSubview:endingBtn];
    [endingBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.view).offset(-3);
        make.centerX.equalTo(self.view);
        make.size.mas_equalTo(CGSizeMake(307, 44));
    }];
    [endingBtn addTarget:self action:@selector(endingBtnAction) forControlEvents:UIControlEventTouchUpInside];
    [endingBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];//0xFCE9B
    [endingBtn setTitle:@"匿名提交" forState:UIControlStateNormal];
    [endingBtn setBackgroundImage:SETIMAGE(@"btn_5_normal") forState:UIControlStateNormal];
    self.endingBtn = endingBtn;
    
    
//    self.textView = [[UITextView alloc]initWithFrame:CGRectMake(5,50,300,170)];
//    self.textView = evaluationContentTF;
//    self.textView.delegate = self;
//    self.textView.layer.borderWidth = 1.0;//边宽
//    self.textView.layer.cornerRadius = 5.0;//设置圆角
////    self.textView.layer.borderColor =[[UIColor grayColor]colorWithAlphaComponet:0.5];
//    self.textView.layer.borderColor = [UIColor groupTableViewBackgroundColor].CGColor;
//    //再创建个可以放置默认字的lable
//    self.placeHolderLabel = [[UILabel alloc]initWithFrame:CGRectMake(5,-5,290,60)];
//    self.placeHolderLabel.numberOfLines = 0;
//    self.placeHolderLabel.text = @"请输入你的意见最多140字";
//    self.placeHolderLabel.backgroundColor =[UIColor clearColor];
//    //多余的一步不需要的可以不写  计算textview的输入字数
//    self.residueLabel = [[UILabel alloc]init];
////    [[UILabel alloc]initWithFrame:CGReactMake:(240,140,60,20)];
//
//    self.residueLabel.backgroundColor = [UIColor clearColor];
//    self.residueLabel.font = [UIFont fontWithName:@"Arial" size:12.0f];
//    self.residueLabel.text =[NSString stringWithFormat:@"140/140"];
//    self.residueLabel.textColor = [[UIColor grayColor]colorWithAlphaComponent:0.5];
//    //最后添加上即可
//    [self.view addSubview :self.textView];
//    [self.textView addSubview:self.placeHolderLabel];
//    self.evaluationContentTF = evaluationContentTF;
}


#pragma mark - UITableViewDataSourceDelegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    int h = 0;
    switch (indexPath.row) {
        case 0:
            h = 90;
            break;
        case 1:
            h = 180;
            break;
        case 2:
            h = 10;
            break;
    }
    return h;
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
//    UITableViewCell *tableViewCell;
//    switch (indexPath.row) {
//        case 0:
//            tableViewCell = [tableView dequeueReusableCellWithIdentifier:GKBusInfoCellID forIndexPath:indexPath];
////            tableViewCell.offerBatteryLabel
//            break;
//        case 1:
//            tableViewCell = [tableView dequeueReusableCellWithIdentifier:GKOrderCellID forIndexPath:indexPath];
//            break;
//        case 2:
//            tableViewCell = [tableView dequeueReusableCellWithIdentifier:GKBusInfoCellID forIndexPath:indexPath];
//            break;
//    }
    GKBusInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:GKBusInfoCellID forIndexPath:indexPath];
    
    [cell.offerBatteryLabel setHidden:true];
    return cell;
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    
//    GKBusMoreInfoViewController *vc = [[GKBusMoreInfoViewController alloc] init];
//    vc.title = [NSString stringWithFormat:@"信息详情[第%ld个]",indexPath.row+1];
//    [self.navigationController pushViewController:vc animated:YES];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    NSLog(@"这次星级为 %f",starView.actualScore);
}

- (void)didChangeStar {
    NSLog(@"这次星级为 %f",starView.actualScore);
}

//接下来通过textView的代理方法实现textfield的点击置空默认自负效果
//-（void）textViewDidChange:(UITextView*)textView
//{
//    if([textView.text length] == 0){
//        self.placeHolderLabel.text = @"请输入你的意见最多140字";
//    }else{
//        self.placeHolderLabel.text = @"";//这里给空
//    }
//    //计算剩余字数   不需要的也可不写
//    NSString *nsTextCotent = textView.text;
//    NSUInteger existTextNum = [nsTextCotent length];
//    int remainTextNum = 140 - (int)existTextNum;
//    self.residueLabel.text = [NSString stringWithFormat:@"%d/140",remainTextNum];
//}
////设置超出最大字数（140字）即不可输入 也是textview的代理方法
//- (BOOL)textView:(UITextView*)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString*)text
//{
//    if ([text isEqualToString:@"\n"]) {
//        //这里"\n"对应的是键盘的 return 回收键盘之用
//        {
//            [textView resignFirstResponder];
//            return YES;
//        }
//        if (range.location >= 140)
//        {
//            return NO;
//        }else
//        {
//            return YES;
//        }
//    }
//}
#pragma mark - lazy load
-(UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];//UITableViewStyleGrouped
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [_tableView registerNib:[UINib nibWithNibName:@"GKBusInfoCell" bundle:nil] forCellReuseIdentifier:GKBusInfoCellID];
//        _tableView.backgroundColor = [UIColor colorWithRed:244/255.0 green:244/255.0 blue:244/255.0 alpha:1];
        _tableView.backgroundColor = TABLEVIEW_BG;
        _tableView.allowsSelection = false;
        _tableView.scrollEnabled = NO;
        _tableView.delegate = self;
        _tableView.dataSource = self;
    }
    return _tableView;
}

-(NSMutableArray *)evaluations{
    if (!_evaluations) {
        _evaluations = [NSMutableArray array];
    }
    return _evaluations;
}

#pragma mark -private method
-(void)detailsCheckBtnAction{
    [SVProgressHUD showInfoWithStatus:@"查看明细"];
    [self.navigationController pushViewController:[GKOrderDetailsViewController new] animated:YES];
}
-(void)endingBtnAction{
    [SVProgressHUD showInfoWithStatus:@"提交"];
}

- (void)labellingBtnAction:(UIButton *)btn{
    //    [SVProgressHUD showInfoWithStatus:[NSString stringWithFormat:@"点击成功！%ld",btn.tag+1]];
//    GKOrderRateViewController *vc = [[GKOrderRateViewController alloc] init];
//    vc.title = [NSString stringWithFormat:@"订单评价[第%ld个]",btn.tag+1];
//    [self.navigationController pushViewController:vc animated:YES];
//    [SVProgressHUD showInfoWithStatus:[NSString stringWithFormat:@"%d,%d",btn.tag,btn.selected]];
    if (!btn.selected) {
        btn.layer.borderColor = UIColorFromHex(0xFCE9B).CGColor;
    }else{
        btn.layer.borderColor = UIColorFromHex(0x999999).CGColor;
    }
    btn.selected = !btn.selected;
}

@end
