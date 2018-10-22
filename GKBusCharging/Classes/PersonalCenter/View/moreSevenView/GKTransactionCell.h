//
//  GKTransactionCell.h
//  GKBusCharging
//
//  Created by 王宁 on 2018/10/22.
//  Copyright © 2018年 goockr. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GKTransactionCell : UITableViewCell
//-(void)createCellWithDictionary:(NSDictionary *)dict withNoCommentFlag:(BOOL)flag;
//@property (nonatomic, assign) BOOL hidden;




@property (strong, nonatomic) IBOutlet UILabel *headView_timeLabel;
@property (strong, nonatomic) IBOutlet UIButton *headView_detailsBtn;


@property (weak, nonatomic) IBOutlet UILabel *contentLabel01;

@property (weak, nonatomic) IBOutlet UILabel *contentLabel02;

@property (weak, nonatomic) IBOutlet UILabel *contentLabel03;

@property (strong, nonatomic) IBOutlet UILabel *contentLabel04;

@end
