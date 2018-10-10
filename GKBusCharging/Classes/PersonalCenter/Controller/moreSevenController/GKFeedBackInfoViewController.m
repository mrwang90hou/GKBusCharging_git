//
//  GKFeedBackInfoViewController.m
//  GKBusCharging
//
//  Created by 王宁 on 2018/10/9.
//  Copyright © 2018年 goockr. All rights reserved.
//


#import "GKFeedBackInfoViewController.h"

// Controllers

#import "GKServiceTermsViewController.h"
// Models

// Views

#import "GKFeedBackInfoCell.h"
// Vendors

// Categories

#import "UITextView+STAutoHeight.h"
// Others

@interface GKFeedBackInfoViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (strong, nonatomic) IBOutlet UILabel *timeLabel;
@property (strong, nonatomic) IBOutlet UIView *textView;

@property (strong, nonatomic) IBOutlet UITextView *detailTF;

@property (strong, nonatomic) IBOutlet UITableView *tableView;


//@property (nonatomic,strong) NSArray<DDSectionModel *> *dataSource;

@property (nonatomic,strong) NSArray *dataSource;

@end

@implementation GKFeedBackInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"反馈详情";
    [self getData];
    //动态控制 detailTF 的换行，并使得textView随之扩大
    
    UITextView *contentTV = [[UITextView alloc]initWithFrame:CGRectMake(0, 0, ScreenW-30, 44)];
    [self.textView addSubview:contentTV];
//    contentTV.font = [UIFont systemFontOfSize:16];
//    contentTV.textColor = [UIColor blackColor];
//    [contentTV setEditable:NO];
    contentTV.isAutoHeightEnable = YES;
    //        contentTV.font = [UIFont systemFontOfSize:15];
//            contentTV.text = @"测试一下我是自适应高度的TextView测试一下我是自适应高度的TextView测试一下我是自适应高度的TextView测试一下我是自适应高度的TextView测试一下我是自\n适应高度的TextView测试一下我是自适应高度的TextView测试一下我是自适应高度的TextView测试一下我是自适应高度的TextView测试一下我是自适应高度的TextView测试一下我是自适应高度的TextView测试一下我是自适应高度的TextView测试一下我是自适应高度的TextView";
    //        contentTV.st_placeHolder = @"请输入您的信息";
    //        contentTV.st_maxHeight = 200;
    //    contentTV.layer.borderWidth = 1;
    //    contentTV.layer.borderColor = [UIColor lightGrayColor].CGColor;
    //    contentTV.backgroundColor = [UIColor whiteColor];
//    contentTV.st_lineSpacing = 5;
    contentTV.text = self.detailTF.text;
    contentTV.textViewHeightDidChangedHandle = ^(CGFloat textViewHeight) {
    };
    self.detailTF = contentTV;
    
    //重新布局设置[self.textView]的约束！！！
//    CGRectGetHeight(self.detailTF.frame.size.height);
    
//    [self.tableView setHidden:true];
    
}

#pragma mark -页面逻辑方法

-(void)getData{
    self.timeLabel.text = @"2018/10/09 15:26:25";
    self.detailTF.text = @"此处显示的是客户提交的错误故障信息详情！";
}
#pragma mark - lazy load
-(UITableView *)tableView{
    //    if (!_tableView) {
    //        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    //UITableViewStyleGrouped
    //        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    //        [_tableView registerNib:[UINib nibWithNibName:@"GKBusInfoCell" bundle:nil] forCellReuseIdentifier:GKBusInfoCellID];
    //        _tableView.backgroundColor = [UIColor colorWithRed:244/255.0 green:244/255.0 blue:244/255.0 alpha:1];
    _tableView.allowsSelection = NO;
    _tableView.scrollEnabled = YES;
    //        _tableView.delegate = self;
    //        _tableView.dataSource = self;
    //    }
    return _tableView;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
//    return self.dataSource[section].isExpanded ? (self.dataSource[section].cellModels.count) : 0;
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    GKFeedBackInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:@"myCellID"];
    if (!cell) {
        cell = [[GKFeedBackInfoCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"myCellID"];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return  12;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60;
}








@end
