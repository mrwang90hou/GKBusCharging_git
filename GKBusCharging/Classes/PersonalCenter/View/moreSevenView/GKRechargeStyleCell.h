//
//  GKRechargeStyleCell.h
//  GKBusCharging
//
//  Created by 王宁 on 2018/10/5.
//  Copyright © 2018年 goockr. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GKRechargeStyleCell : UITableViewCell
//-(void)createCellWithDictionary:(NSDictionary *)dict withNoCommentFlag:(BOOL)flag;
//@property (nonatomic, assign) BOOL hidden;
@property (weak, nonatomic) IBOutlet UIImageView *styleImageLogo;
@property (strong, nonatomic) IBOutlet UILabel *styleLabel;

@property (weak, nonatomic) IBOutlet UILabel *detailsLabel;

@property (strong, nonatomic) IBOutlet UIImageView *selectedOrNotImage;

@end
