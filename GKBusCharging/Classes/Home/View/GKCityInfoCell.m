
//
//  GKCityInfoCell.m
//  GKBusCharging
//
//  Created by 王宁 on 2018/9/29.
//  Copyright © 2018年 goockr. All rights reserved.
//

#import "GKCityInfoCell.h"

@interface GKCityInfoCell()

@end
@implementation GKCityInfoCell

-(void)setNeedsLayout{
    [super setNeedsLayout];
    self.myView.layer.masksToBounds = YES;
    self.myView.layer.cornerRadius = 6;
}

-(void)setModel:(GKCityListModel *)model{
    _model  = model;
    if (model) {
        self.cityNameLabel.text = model.cityName;
    }
}

- (void)setFrame:(CGRect)frame{
//    if (self.ifSetNewFrame != 0) {
        frame.origin.x += 10;
        frame.origin.y += 10;
        frame.size.height -= 10;
        frame.size.width -= 20;
        [super setFrame:frame];
//    }
}
//- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
//    [super setSelected:selected animated:animated];
//    // Configure the view for the selected state
//}
@end
