//
//  GKFeedBackInfoCell.h
//  GKBusCharging
//
//  Created by 王宁 on 2018/10/7.
//  Copyright © 2018年 goockr. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GKFeedBackInfoCell : UITableViewCell
//-(void)createCellWithDictionary:(NSDictionary *)dict withNoCommentFlag:(BOOL)flag;
//@property (nonatomic, assign) BOOL hidden;

@property (strong, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *peopleTitleLabel;
@property (strong, nonatomic) IBOutlet UITextView *detailTV;

@end
