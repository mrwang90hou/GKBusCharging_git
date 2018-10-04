//
//  GKChangeNameController.m
//  GKBusCharging
//
//  Created by 王宁 on 2018/10/2.
//  Copyright © 2018年 L. All rights reserved.
//

#import "GKChangeNameController.h"

@interface GKChangeNameController ()
@property (nonatomic,strong)UITextField * nameTF;
@property (nonatomic,strong)UIButton * saveBtn;
@end

@implementation GKChangeNameController

- (instancetype)initWithStyle:(UITableViewStyle)style{
    return [super initWithStyle:UITableViewStyleGrouped];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"用户昵称";
    self.view.backgroundColor = TABLEVIEW_BG;
    
    UIButton * saveBtn = [[UIButton alloc]initWithFrame:CGRectMake(0,0,50,30)];
    [saveBtn setTitle:@"保存" forState:UIControlStateNormal];
    saveBtn.titleLabel.font = GKMediumFont(17);
    self.saveBtn = saveBtn;
    [self nameChange];
    UIBarButtonItem * rightItem = [[UIBarButtonItem alloc] initWithCustomView:saveBtn];
    self.navigationItem.rightBarButtonItem = rightItem;
}

- (void)nameChange{
    if (self.nameTF.text.length > 0){
        [self.saveBtn setTitleColor:SAVE_COLOR forState:UIControlStateNormal];
        [self.saveBtn addTarget:self action:@selector(saveBtnClick) forControlEvents:UIControlEventTouchUpInside];
        self.saveBtn.userInteractionEnabled = YES;
    }else{
        [self.saveBtn setTitleColor:UIColorFromHex(0xCCCCCC) forState:UIControlStateNormal];
        self.saveBtn.userInteractionEnabled = NO;
    }
}

- (void)saveBtnClick{
    [SVProgressHUD showWithStatus:@"正在保存..."];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [SVProgressHUD dismiss];
        [DCObjManager dc_saveUserData:self.nameTF.text forKey:@"UserName"];
        [SVProgressHUD showSuccessWithStatus:@"保存成功！"];
        [[NSNotificationCenter defaultCenter] postNotificationName:KNotiUserNameChange object:nil];
        //                    [self dismissViewControllerAnimated:YES completion:nil];
        [self.navigationController popViewControllerAnimated:YES];
    });
}

#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"GKChangeNameController"];
    
    GKTextField * nameTF = [GKTextField new];
    [cell.contentView addSubview:nameTF];
    [nameTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.bottom.equalTo(cell.contentView);
    }];
    nameTF.backgroundColor = [UIColor clearColor];
    nameTF.placeholder = @"请输入昵称";
    [nameTF setLeftMargin:15];
    nameTF.clearButtonMode = UITextFieldViewModeWhileEditing;
    self.nameTF = nameTF;
    [nameTF addTarget:self action:@selector(nameChange) forControlEvents:UIControlEventEditingChanged];
    nameTF.font = GKMediumFont(16);
    
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *headerView = [[UIView alloc]init];
    return headerView;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView *footerView = [[UIView alloc]init];
    return footerView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 10;
}
@end
