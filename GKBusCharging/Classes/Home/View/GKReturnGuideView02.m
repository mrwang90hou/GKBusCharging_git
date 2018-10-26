//
//  GKReturnGuideView02.m
//  GKBusCharging
//
//  Created by L on 2018/10/26.
//  Copyright © 2018年 goockr. All rights reserved.
//

//
//   GKReturnGuideView02.m
//  STOExpressDelivery
//
//  Created by mrwang90hou on 2019/10/8.
//  Copyright © 2018年 goockr. All rights reserved.
//

#import "GKReturnGuideView02.h"
@interface GKReturnGuideView02()

/**
 圆点
 */
@property (strong, nonatomic) IBOutlet UIView *cicleView;
/**
 步骤图：stepImageView
 */
@property (strong, nonatomic) IBOutlet UIImageView *stepImageView;
/**
 步骤 TitleLabel：
 */
@property (strong, nonatomic) IBOutlet UILabel *titleLabel;

/**
 步骤DetailTF：
 */
@property (strong, nonatomic) IBOutlet UITextView *stepTF;
@end
@implementation  GKReturnGuideView02

#pragma mark - Intial
- (void)awakeFromNib
{
    [super awakeFromNib];
    [self setUI];
}
-(void)setNeedsLayout{
    [super setNeedsLayout];
    [self setUI];
}
-(void)setUI{
    //设置边框宽度及颜色
    self.layer.borderColor = RGB(255, 221, 146).CGColor;
    self.layer.borderWidth = 1;
    self.cicleView.layer.cornerRadius = 50;
    self.cicleView.layer.masksToBounds = YES;
//    self.cicleView.layer.cornerRadius = 12;
    //引导图片的大小设置
    BOOL isIphone5 = [UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size):NO;
    if (isIphone5) {
        self.stepImageView.frame = CGRectMake(0, 0, 60, 106);
    }else{
        self.stepImageView.frame = CGRectMake(0, 0, 70, 124);
    }
    //设置引导图的相对位置及针对于 iPhone5的自适应
    [self.stepImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.centerX.mas_equalTo(self).offset(-ScreenW/4);
        make.size.mas_equalTo(K_IPHONE_5 ? CGSizeMake(60, 106):CGSizeMake(70, 124));
    }];
  
    [self.cicleView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(25, 25));
        //        make.center.equalTo(self.step01View);
        make.left.equalTo(self.mas_centerX);
        make.bottom.equalTo(self.mas_centerY).offset(-self.bounds.size.height/4);
    }];
    //TitleLabel布局
    self.titleLabel.bounds = CGRectMake(self.cicleView.center.x, self.cicleView.center.y, 60, 24);
 
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self. cicleView.mas_left).offset(25/2-2);
        make.top.mas_equalTo(self. cicleView.mas_top).offset(25/2-2);
        make.size.mas_equalTo(CGSizeMake(60, 24));
    }];
    [self.stepTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self. titleLabel).offset(-4);
        make.top.mas_equalTo(self. titleLabel.mas_bottom).offset(-4);
        make.size.mas_equalTo(CGSizeMake(126, 80));
    }];
}
#pragma mark - Setter Getter Methods

@end
