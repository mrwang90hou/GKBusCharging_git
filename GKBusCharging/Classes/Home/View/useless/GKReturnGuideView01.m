//
//  GKReturnGuideView01.m
//  GKBusCharging
//
//  Created by L on 2018/10/26.
//  Copyright © 2018年 goockr. All rights reserved.
//

//
//   GKReturnGuideView01.m
//  STOExpressDelivery
//
//  Created by mrwang90hou on 2019/10/8.
//  Copyright © 2018年 goockr. All rights reserved.
//

#import "GKReturnGuideView01.h"
@interface GKReturnGuideView01()
/**
 圆点
 */
@property (strong, nonatomic) IBOutlet UIView *cicleView01;
/**
 步骤图：stepImageView01
 */
@property (strong, nonatomic) UIImageView *stepImageView01;
/**
 步骤 titleLabel01：
 */
@property (strong, nonatomic) IBOutlet UILabel *titleLabel01;

/**
 步骤DetailTF：
 */
@property (strong, nonatomic) IBOutlet UITextView *stepTF01;
@end
@implementation  GKReturnGuideView01

#pragma mark - Intial
-(void)setNeedsLayout{
    [super setNeedsLayout];
    [self setUI];
}
-(UIImageView *)stepImageView01
{
    _stepImageView01 = [[UIImageView alloc]init];
    [self addSubview:_stepImageView01];
    [_stepImageView01 setImage:SETIMAGE(@"guide_return_1")];
    return _stepImageView01;
}

#pragma mark - initialize
- (void)setUI{
    //设置边框宽度及颜色
    self.layer.borderColor = RGB(255, 221, 146).CGColor;
    self.layer.borderWidth = 1;
//    self.cicleView01.layer.cornerRadius = 50;
    self.cicleView01.layer.masksToBounds = YES;
    self.cicleView01.layer.cornerRadius = 12;
    
    [self.stepImageView01 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.centerX.mas_equalTo(self).offset(-ScreenW/4);
        make.size.mas_equalTo(K_IPHONE_5 ? CGSizeMake(80, 140):CGSizeMake(90, 157));
    }];
    
    [self.cicleView01 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(25, 25));
        //        make.center.equalTo(self.step01View);
        make.left.equalTo(self.mas_centerX);
        make.bottom.equalTo(self.mas_centerY).offset(-self.bounds.size.height/4);
    }];
    //TitleLabel布局
    self.titleLabel01.bounds = CGRectMake(self.cicleView01.center.x, self.cicleView01.center.y, 60, 24);
    
    [self.titleLabel01 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.cicleView01.mas_left).offset(25/2-2);
        make.top.mas_equalTo(self.cicleView01.mas_top).offset(25/2-2);
        make.size.mas_equalTo(CGSizeMake(60, 24));
    }];
    [self.stepTF01 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.titleLabel01).offset(-4);
        make.top.mas_equalTo(self.titleLabel01.mas_bottom).offset(-4);
        make.size.mas_equalTo(CGSizeMake(126, 80));
    }];
    
}
#pragma mark - Setter Getter Methods

@end
