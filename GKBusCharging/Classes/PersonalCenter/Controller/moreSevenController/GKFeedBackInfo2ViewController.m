//
//  GKFeedBackInfo2ViewController.m
//  GKBusCharging
//
//  Created by 王宁 on 2018/10/9.
//  Copyright © 2018年 goockr. All rights reserved.
//


#import "GKFeedBackInfo2ViewController.h"

// Controllers

#import "GKServiceTermsViewController.h"
// Models

// Views

#import "GKFeedBackInfoCell.h"
#import "GKBusInfoCell.h"
// Vendors

// Categories

#import "UITextView+STAutoHeight.h"
// Others

static NSString *GKFeedBackInfoCellID = @"GKFeedBackInfoCell";

static NSString *GKBusInfoCellID = @"GKBusInfoCell";
@interface GKFeedBackInfo2ViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, assign) NSString *timeLabelString;
@property (nonatomic, assign) NSString *detailTFString;
//@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic,strong) UITableView *tableView;

//@property (nonatomic,strong) NSArray<DDSectionModel *> *dataSource;

@property (nonatomic,strong) NSArray *dataSource;

@end

@implementation GKFeedBackInfo2ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"反馈详情2";
    [self getData];
    [self setupUI];
    //动态控制 detailTF 的换行，并使得textView随之扩大
//    UITextView *contentTV = [[UITextView alloc]initWithFrame:CGRectMake(0, 0, ScreenW-30, 44)];
//    [self.textView addSubview:contentTV];
//    contentTV.font = [UIFont systemFontOfSize:16];
//    contentTV.textColor = [UIColor blackColor];
//    [contentTV setEditable:NO];
//    contentTV.isAutoHeightEnable = YES;
    //        contentTV.font = [UIFont systemFontOfSize:15];
//            contentTV.text = @"测试一下我是自适应高度的TextView测试一下我是自适应高度的TextView测试一下我是自适应高度的TextView测试一下我是自适应高度的TextView测试一下我是自\n适应高度的TextView测试一下我是自适应高度的TextView测试一下我是自适应高度的TextView测试一下我是自适应高度的TextView测试一下我是自适应高度的TextView测试一下我是自适应高度的TextView测试一下我是自适应高度的TextView测试一下我是自适应高度的TextView";
    //        contentTV.st_placeHolder = @"请输入您的信息";
    //        contentTV.st_maxHeight = 200;
    //    contentTV.layer.borderWidth = 1;
    //    contentTV.layer.borderColor = [UIColor lightGrayColor].CGColor;
    //    contentTV.backgroundColor = [UIColor whiteColor];
//    contentTV.st_lineSpacing = 5;
    
    
//    contentTV.text = self.detailTF.text;
//    contentTV.textViewHeightDidChangedHandle = ^(CGFloat textViewHeight) {
//    };
//    self.detailTF = contentTV;
    //重新布局设置[self.textView]的约束！！！
//    CGRectGetHeight(self.detailTF.frame.size.height);
//    [self.tableView setHidden:true];
}
-(void)setupUI{
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
}
#pragma mark -页面逻辑方法

-(void)getData{
    self.timeLabelString = @"2018/10/09 15:26:25";
    self.detailTFString = @"此处显示的是客户提交的错误故障信息详情！";
}
#pragma mark - lazy load
-(UITableView *)tableView{
        if (!_tableView) {
            _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
//    UITableViewStyleGrouped
            _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
            [_tableView registerNib:[UINib nibWithNibName:@"GKFeedBackInfoCell" bundle:nil] forCellReuseIdentifier:GKFeedBackInfoCellID];
//            [_tableView registerNib:[UINib nibWithNibName:@"GKBusInfoCell" bundle:nil] forCellReuseIdentifier:GKBusInfoCellID];
            _tableView.backgroundColor = [UIColor colorWithRed:244/255.0 green:244/255.0 blue:244/255.0 alpha:1];
            _tableView.allowsSelection = NO;
            _tableView.scrollEnabled = YES;
            _tableView.delegate = self;
            _tableView.dataSource = self;
        }
    return _tableView;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
//    GKFeedBackInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:@"GKFeedBackInfoCell"];
//    if (!cell) {
//        cell = [[GKFeedBackInfoCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"GKFeedBackInfoCell"];
//    }

    GKFeedBackInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:GKFeedBackInfoCellID forIndexPath:indexPath];
    if (indexPath.row == 0) {
        cell.peopleTitleLabel.text = self.timeLabelString;
        cell.peopleTitleLabel.textColor = RGBall(153);
        [cell.timeLabel setHidden:true];
        cell.detailTV.text = self.detailTFString;
    }else{
        cell.peopleTitleLabel.textColor = RGBall(51);
        cell.peopleTitleLabel.text = @"客服回复";
        cell.timeLabel.text = @"2018/08/26  10:20:00";
        cell.detailTV.text = @"亲，正常流程需要等待3-5个工作日，请耐心等待。";
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }

//    GKBusInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:GKBusInfoCellID forIndexPath:indexPath];
//    cell.hidden = YES;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    
    return 100;
}








@end
