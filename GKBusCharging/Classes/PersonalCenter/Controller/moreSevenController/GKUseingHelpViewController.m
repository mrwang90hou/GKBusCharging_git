//
//  GKUseingHelpViewController.m
//  UItableview Cell的点击
//
//  Created by apple on 28/2/17.
//  Copyright © 2017年 mark. All rights reserved.
//

#import "GKUseingHelpViewController.h"
#import "DDSectionModel.h"
#import "DDTableViewHeader.h"
#import "MoreTableViewCell.h"
#import "UIColor+Extension.h"

@interface GKUseingHelpViewController ()<UITableViewDataSource,UITableViewDelegate>


@property (nonatomic,strong) NSArray<DDSectionModel *> *dataSource;

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@end

@implementation GKUseingHelpViewController
#pragma mark - lazy load
-(UITableView *)tableView{
    //    if (!_tableView) {
    //        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    //UITableViewStyleGrouped
    //        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    //        [_tableView registerNib:[UINib nibWithNibName:@"GKBusInfoCell" bundle:nil] forCellReuseIdentifier:GKBusInfoCellID];
    //        _tableView.backgroundColor = [UIColor colorWithRed:244/255.0 green:244/255.0 blue:244/255.0 alpha:1];
    _tableView.allowsSelection = NO;
    //        _tableView.delegate = self;
    //        _tableView.dataSource = self;
    //    }
    return _tableView;
}



- (NSArray *)dataSource{

    if (!_dataSource) {
        
        _dataSource = [[NSArray alloc] init];
    }
    
    return _dataSource;
}

- (void)viewDidLoad {
    [super viewDidLoad];

//    self.tableView =[[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
//    self.tableView =[[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    
    self.tableView.backgroundColor = [UIColor whiteColor];
    //    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.separatorStyle = UITableViewCellStyleSubtitle;
    [DDSectionModel loadData:^(NSArray *models) {
       
        self.dataSource = models;
        
    }];
    
    self.title = @"使用帮助";
    [self getUI];
    [self getData];
}

- (void)getUI{
    
}
#pragma mark -页面逻辑方法

- (void)getData{
    
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return self.dataSource.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.dataSource[section].isExpanded ? (self.dataSource[section].cellModels.count) : 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MoreTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"myCellID"];
    
    if (!cell) {
        
        cell = [[MoreTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"myCellID"];
    }
    cell.cellModel = self.dataSource[indexPath.section].cellModels[indexPath.row];
    // 实际开发中不要这样设置
    cell.contentView.backgroundColor = [UIColor lightGrayColor];
    cell.contentView.layer.borderColor = [UIColor defaultColor].CGColor;
    cell.contentView.layer.borderWidth = 0.5;
    cell.textLabel.textColor = [UIColor whiteColor];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
//    CGFloat *height = CGRectGetWidth(cell.contentTV.bounds);
    
    return cell;
}


- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{

    DDTableViewHeader *headerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"header"];
    
    if (!headerView) {
        headerView = [[DDTableViewHeader alloc] initWithReuseIdentifier:@"header"];
    }
    headerView.sectionModel = self.dataSource[section];
    headerView.HeaderClickedBack = ^(BOOL isExpand){
    
        [tableView reloadSections:[[NSIndexSet alloc] initWithIndex:section] withRowAnimation:UITableViewRowAnimationAutomatic];
    };
    
    return  headerView;
}


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    DDTableViewHeader *headerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"header"];
    
    if (!headerView) {
        headerView = [[DDTableViewHeader alloc] initWithReuseIdentifier:@"header"];
    }
    headerView.sectionModel = self.dataSource[section];
    return  headerView.contentTV.bounds.size.height;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return  12;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    MoreTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"myCellID"];
    if (!cell) {
        cell = [[MoreTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"myCellID"];
    }
    cell.cellModel = self.dataSource[indexPath.section].cellModels[indexPath.row];
    
    return cell.contentTV.bounds.size.height;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
