//
//  GKDetailCell.m
//  GKBusCharging
//
//  Created by L on 2018/7/2.
//  Copyright © 2018年 L. All rights reserved.
//

#import "GKDetailCell.h"

@implementation GKDetailCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        MJWeakSelf;
        UILabel * firstLabel = [UILabel new];
        [self addSubview:firstLabel];
        [firstLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(weakSelf).with.offset(15);
            make.centerY.equalTo(weakSelf);
            make.size.mas_equalTo(CGSizeMake(70, 22));
        }];
        firstLabel.text = @"用户昵称";
        firstLabel.textAlignment = NSTextAlignmentCenter;
        firstLabel.font = GKFont(16);
        firstLabel.textColor = UIColorFromHex(0x333333);
        self.firstLabel = firstLabel;
        
        UILabel * desLabel = [UILabel new];
        [self addSubview:desLabel];
        [desLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(weakSelf);
            make.right.mas_equalTo(weakSelf).with.offset(-35);
            make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH - 35 -95, 22));
        }];
        desLabel.text = @"天空很美";
        desLabel.textColor = UIColorFromHex(0x999999);
        desLabel.font = GKFont(14);
        desLabel.textAlignment = NSTextAlignmentRight;
        self.desLabel = desLabel;
    }
    return self;
}
@end
