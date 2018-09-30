//
//  GKMeCell.m
//  Record
//
//  Created by L on 2018/7/2.
//  Copyright © 2018年 L. All rights reserved.
//

#import "GKMeCell.h"

@implementation GKMeCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        UIImageView * iconImageView = [UIImageView new];
        [self addSubview:iconImageView];
        MJWeakSelf;
        [iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(weakSelf).with.offset(15);
            make.centerY.equalTo(weakSelf);
            make.size.mas_equalTo(CGSizeMake(FixWidthNumber(24), FixWidthNumber(24)));
        }];
        self.iconImageView = iconImageView;
        
        UILabel * desLabel = [UILabel new];
        [self addSubview:desLabel];
        [desLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(iconImageView.mas_right).with.offset(10);
            make.centerY.equalTo(iconImageView);
            make.height.mas_equalTo(iconImageView);
            make.right.mas_equalTo(weakSelf).with.offset(-30);
        }];
        desLabel.font = GKMediumFont(16);
        desLabel.textColor = UIColorFromHex(0x262626);
        self.desLabel = desLabel;
        
        UILabel * endLabel = [UILabel new];
        [self addSubview:endLabel];
        [endLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(weakSelf);
            make.right.mas_equalTo(weakSelf).with.offset(-35);
            make.height.mas_equalTo(iconImageView);
//            make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH - 35 -95, 22));
        }];
//        endLabel.text = @"";
        endLabel.textColor = UIColorFromHex(0x999999);
        endLabel.font = GKFont(14);
        endLabel.textAlignment = NSTextAlignmentRight;
        self.endLabel = endLabel;
        
    }
    return self;
}
@end
