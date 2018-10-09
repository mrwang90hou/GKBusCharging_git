//
//  GKCheckCodeCell.m
//  GKBusCharging
//
//  Created by L on 2018/7/3.
//  Copyright © 2018年 L. All rights reserved.
//

#import "GKCheckCodeCell.h"
@implementation GKCheckCodeCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        GKTextField * codeTF = [GKTextField new];
        [self addSubview:codeTF];
        MJWeakSelf;
        [codeTF mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.equalTo(weakSelf);
            make.left.mas_equalTo(weakSelf).with.offset(15);
            make.width.mas_equalTo(FixWidthNumber(234));
        }];
        codeTF.placeholder = @"输入短信验证码";
        [codeTF setLeftMargin:10];
        codeTF.backgroundColor = [UIColor whiteColor];
        codeTF.layer.borderColor = UIColorFromHex(0xE1E1E1).CGColor;
        codeTF.layer.borderWidth = .5;
        codeTF.layer.cornerRadius = 5;
        codeTF.layer.masksToBounds = YES;
        codeTF.font = GKMediumFont(16);
        self.codeTF = codeTF;
        codeTF.clearButtonMode = UITextFieldViewModeWhileEditing;

        GKButton * codeBtn = [GKButton new];
        [self addSubview:codeBtn];
        [codeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(FixWidthNumber(96));
            make.height.mas_equalTo(44);
            make.right.mas_equalTo(weakSelf).with.offset(-15);
            make.centerY.equalTo(weakSelf);
        }];
        [codeBtn setupCircleButtonWithRadius:5];
        self.codeBtn = codeBtn;
        [codeBtn setTitle:@"发送验证码" forState:UIControlStateNormal];
        codeBtn.titleLabel.font = GKMediumFont(14);
    }
    return self;
}
@end
