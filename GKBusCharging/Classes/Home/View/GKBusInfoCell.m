
//
//  GKBusInfoCell.m
//  GKBusCharging
//
//  Created by 王宁 on 2018/9/29.
//  Copyright © 2018年 goockr. All rights reserved.
//

#import "GKBusInfoCell.h"

@interface GKBusInfoCell()

@end
@implementation GKBusInfoCell

-(void)setNeedsLayout{
    [super setNeedsLayout];
//    self.userImageV.layer.cornerRadius=self.userImageV.image.size.width/2;
//    self.userImageV.image=[UIImage imageNamed:@"consult_doctor_icon"];
    
//    UIColor *bgColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"bus_information_bg"]];
//    [self.myView setBackgroundColor:bgColor];
    self.myView.layer.masksToBounds = YES;
    self.myView.layer.cornerRadius = 8;
}


-(void)setModel:(GKBusListModel *)model{
    _model  = model;
    if (model) {
        self.busCardNumberLabel.text = model.busNumber;
        self.busLinesNumberLabel.text = model.busName;
        self.scoreLabel.text = model.score;
        [self.offerBatteryLabel setHidden:[model.allowLend intValue]-1];
    }
}
@end
