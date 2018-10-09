//
//  GKCountrySelectCell.m
//  GKBusCharging
//
//  Created by L on 2018/7/4.
//  Copyright © 2018年 L. All rights reserved.
//

#import "GKCountrySelectCell.h"

@implementation GKCountrySelectCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        UIView * countryView = [UIView new];
        [self addSubview:countryView];
        MJWeakSelf;
        [countryView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.mas_equalTo(weakSelf);
            make.left.mas_equalTo(weakSelf).with.offset(15);
            make.right.mas_equalTo(weakSelf).with.offset(-15);
        }];
        countryView.backgroundColor = [UIColor whiteColor];
        countryView.layer.borderColor = UIColorFromHex(0xE1E1E1).CGColor;
        countryView.layer.borderWidth = .5;
        countryView.layer.cornerRadius = 5;
        countryView.layer.masksToBounds = YES;
        
        UILabel * countryNameLabel = [UILabel new];
        [countryView addSubview:countryNameLabel];
        [countryNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.mas_equalTo(countryView);
            make.left.mas_equalTo(countryView).with.offset(10);
            make.width.mas_equalTo(FixWidthNumber(115*2));
        }];
        countryNameLabel.text = @"中国";
        countryNameLabel.textColor = UIColorFromHex(0x2C2C2C);
        countryNameLabel.font = GKBlodFont(16);
        countryNameLabel.textAlignment = NSTextAlignmentLeft;
        self.countryNameLabel = countryNameLabel;
        
        UILabel * countryCodeLabel = [UILabel new];
        [countryView addSubview:countryCodeLabel];
        [countryCodeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.equalTo(countryNameLabel);
            make.right.mas_equalTo(countryView).with.offset(-FixWidthNumber(35));
            make.width.mas_equalTo(60);
        }];
        countryCodeLabel.textAlignment = NSTextAlignmentRight;
        countryCodeLabel.textColor = countryNameLabel.textColor;
        countryCodeLabel.text = @"+86";
        countryCodeLabel.font = countryNameLabel.font;
        self.countryCodeLabel = countryCodeLabel;
        
        UIImageView * arrowImageView = [UIImageView new];
        [countryView addSubview:arrowImageView];
        [arrowImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(countryView);
            make.right.mas_equalTo(countryView).with.offset(-15);
            make.size.mas_equalTo(CGSizeMake(10, 10));
        }];
        arrowImageView.contentMode = UIViewContentModeScaleAspectFit;
        arrowImageView.image = [UIImage imageNamed:@"btn_area_code_pull_down"];
        
        UIButton * countryBtn = [UIButton new];
        [countryView addSubview:countryBtn];
        [countryBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.right.bottom.equalTo(countryView);
        }];
        self.countryBtn = countryBtn;
    }
    return self;
}
@end
