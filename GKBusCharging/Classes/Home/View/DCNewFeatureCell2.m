//
//   DCNewFeatureCell2.m
//  GFMapleLeaves
//
//  Created by mrwang90hou on 2019/9/20.
//  Copyright © 2019年 mrwang90hou. All rights reserved.
//

#import "DCNewFeatureCell2.h"
#import "GKPriceEvaluationView.h"
#import "GKReturnGuideView02.h"
#import "Masonry.h"
@interface  DCNewFeatureCell2()


/* button */
@property (strong , nonatomic)UIButton *hideButton;

@property (nonatomic,strong) GKPriceEvaluationView *priceEvaluationView;
@property (nonatomic,strong) GKReturnGuideView02 *returnGuideView02;
@end


@implementation  DCNewFeatureCell2

#pragma mark - super
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        UIView *bgView = [[UIView alloc]init];
        //设置边框宽度及颜色
        bgView.layer.borderColor = RGB(255, 221, 146).CGColor;
        bgView.layer.borderWidth = 1;
        bgView.layer.cornerRadius = 12;
        //        [bgView setBackgroundColor:[UIColor redColor]];
        [self addSubview:bgView];
        [bgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(self).offset(-15);
            make.left.mas_equalTo(self.mas_left).offset(15);
            make.right.mas_equalTo(self.mas_right).offset(-15);
            make.height.mas_equalTo(K_IPHONE_5 ? 155:190);
        }];
        UIView *cicleView01 = [[UIView alloc]init];
        //        cicleView01.layer.cornerRadius = 50;
        cicleView01.layer.masksToBounds = YES;
        cicleView01.layer.cornerRadius = 12;
        [cicleView01 setBackgroundColor:RGB(255, 221, 146)];
        [bgView addSubview:cicleView01];
        [cicleView01 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(25, 25));
            make.left.mas_equalTo(bgView.mas_centerX);
            make.bottom.equalTo(bgView.mas_centerY).offset(-bgView.bounds.size.height/4);
        }];
        UIImageView *stepImageView01 = [[UIImageView alloc]init];
        [stepImageView01 setImage:SETIMAGE(@"guide_return_2")];
        [bgView addSubview:stepImageView01];
        
        UILabel *titleLabel01 = [[UILabel alloc]init];
        [titleLabel01 setText:@"第二步"];
        [titleLabel01 setFont:GKFont(17)];
        [bgView addSubview:titleLabel01];
        UITextView *stepTF01 = [[UITextView alloc]init];
        [stepTF01 setText:@"轻拉1cm，缓缓收回充电线。"];
        [stepTF01 setFont:GKFont(14)];
        [bgView addSubview:stepTF01];
        
        [stepImageView01 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(bgView);
            make.centerX.mas_equalTo(bgView).offset(-ScreenW/4);
            make.size.mas_equalTo(K_IPHONE_5 ? CGSizeMake(80, 140):CGSizeMake(90, 157));
        }];
        //TitleLabel布局
        titleLabel01.bounds = CGRectMake(cicleView01.center.x, cicleView01.center.y, 60, 24);
        
        [titleLabel01 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(cicleView01.mas_left).offset(25/2-2);
            make.top.mas_equalTo(cicleView01.mas_top).offset(25/2-2);
            make.size.mas_equalTo(CGSizeMake(60, 24));
        }];
        [stepTF01 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(titleLabel01).offset(-4);
            make.top.mas_equalTo(titleLabel01.mas_bottom).offset(-4);
            make.size.mas_equalTo(CGSizeMake(126, 80));
        }];
    }
    return self;
}


@end
