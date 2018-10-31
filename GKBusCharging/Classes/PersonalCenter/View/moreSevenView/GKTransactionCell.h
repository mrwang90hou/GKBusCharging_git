//
//  GKTransactionCell.h
//  GKBusCharging
//
//  Created by 王宁 on 2018/10/22.
//  Copyright © 2018年 goockr. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OrderModel.h"
//typedef NS_ENUM(NSInteger, OrderType){
//    OrderType_WillPay,              //待付款
//    OrderType_UnWalk,               //未出行
//    OrderType_UnEvaluate,           //待评价
//    OrderType_History               //历史记录
//};
//typedef NS_ENUM(NSInteger, OrderButtonOperationType) {
//    OrderButtonOperationType_Pay,                   //付款
//    OrderButtonOperationType_Revoke,                //取消订单
//    OrderButtonOperationType_Cancel,                //删除订单
//    OrderButtonOperationType_Evaluate,              //评价
//    OrderButtonOperationType_Remind,                //添加提醒
//    OrderButtonOperationType_ReBook                 //再次预定
//};
//@class GKTransactionCell;
//@protocol GKTransactionCellDelegte <NSObject>
//
//-(void)orderCell:(GKTransactionCell *)cell didClickButtonWithCellType:(OrderButtonOperationType)type withOrderModel:(OrderModel *)model;
//
//@end
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
