//
//  GKBusInfoCell.h
//  GKBusCharging
//
//  Created by 王宁 on 2018/9/29.
//  Copyright © 2018年 goockr. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GKBusInfoCell : UITableViewCell
//-(void)createCellWithDictionary:(NSDictionary *)dict withNoCommentFlag:(BOOL)flag;
//@property (nonatomic, assign) BOOL hidden;

@property (strong, nonatomic) IBOutlet UIView *myView;
@property (weak, nonatomic) IBOutlet UIImageView *busImageLogo;
@property (strong, nonatomic) IBOutlet UILabel *busLinesNumberLabel;

@property (weak, nonatomic) IBOutlet UILabel *busCardNumberLabel;

@property (weak, nonatomic) IBOutlet UILabel *offerBatteryLabel;

@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;

@property (strong, nonatomic) IBOutlet UILabel *zonghe;

@property (strong, nonatomic) IBOutlet UIImageView *star;



@end
