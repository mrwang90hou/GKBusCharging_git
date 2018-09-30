
//
//  GKBusInfoCell.m
//  住哪儿
//
//  Created by 杭城小刘 on 2016/12/27.
//  Copyright © 2016年 geek. All rights reserved.
//

#import "GKBusInfoCell.h"

@interface GKBusInfoCell()
@property (weak, nonatomic) IBOutlet UIImageView *busImageLogo;
@property (strong, nonatomic) IBOutlet UILabel *busLinesNumberLabel;

@property (weak, nonatomic) IBOutlet UILabel *busCardNumberLabel;

@property (weak, nonatomic) IBOutlet UILabel *OfferBatteryLabel;

@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;

@property (strong, nonatomic) IBOutlet UILabel *zonghe;

@property (strong, nonatomic) IBOutlet UIImageView *star;

@end
@implementation GKBusInfoCell

-(void)setNeedsLayout{
    [super setNeedsLayout];
//    self.userImageV.layer.cornerRadius=self.userImageV.image.size.width/2;
//    self.userImageV.image=[UIImage imageNamed:@"consult_doctor_icon"];
}
-(void)setHidden:(BOOL)hidden{
//    _hidden = hidden;
//    self.noCommentLabel.hidden = hidden;
}

@end
