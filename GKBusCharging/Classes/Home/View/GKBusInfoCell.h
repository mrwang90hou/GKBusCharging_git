//
//  GKBusInfoCell.h
//  住哪儿
//
//  Created by 杭城小刘 on 2016/12/27.
//  Copyright © 2016年 geek. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GKBusInfoCell : UITableViewCell
//-(void)createCellWithDictionary:(NSDictionary *)dict withNoCommentFlag:(BOOL)flag;
//@property (nonatomic, assign) BOOL hidden;

@property (weak, nonatomic) IBOutlet UIImageView *busImageLogo;
@property (strong, nonatomic) IBOutlet UILabel *busLinesNumberLabel;

@property (weak, nonatomic) IBOutlet UILabel *busCardNumberLabel;

@property (weak, nonatomic) IBOutlet UILabel *offerBatteryLabel;

@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;

@property (strong, nonatomic) IBOutlet UILabel *zonghe;

@property (strong, nonatomic) IBOutlet UIImageView *star;



@end
