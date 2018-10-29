//
//  GKPriceEvaluationView.m
//  STOExpressDelivery
//
//  Created by mrwang90hou on 2019/10/8.
//  Copyright © 2018年 goockr. All rights reserved.
//

#import "GKPriceEvaluationView.h"
#import "AppDelegate.h"
// Controllers
//#import "DCHandPickViewController.h"
//#import "DCBeautyMessageViewController.h"
//#import "DCMediaListViewController.h"
//#import "DCBeautyShopViewController.h"
#import "GKNavigationController.h"
#import "GKHomeViewController.h"
#import "HYBStarEvaluationView.h"
// Models

// Views
#import "UIView+Toast.h"
// Vendors
#import <SVProgressHUD.h>
// Categories

// Others

@interface GKPriceEvaluationView ()<DidChangedStarDelegate>

@property (strong, nonatomic) IBOutlet UIView *footerView;


@end

@implementation GKPriceEvaluationView
#pragma mark - Intial
- (void)awakeFromNib
{
    [super awakeFromNib];
    
    [self setUpBase];
}


#pragma mark - initialize
- (void)setUpBase
{
    _starView = [[HYBStarEvaluationView alloc]initWithFrame:CGRectMake(120, 80, 125, 22) numberOfStars:5 isVariable:YES];
    _starView.actualScore = 0;
    _starView.fullScore = 5;
    _starView.delegate = self;
    [self.footerView addSubview:_starView];
    [_starView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.footerView);
        if (K_IPHONE_5) {
            make.centerY.equalTo(self.footerView.mas_centerY).offset(10);
        }else{
            make.top.equalTo(self.footerView.mas_centerY).offset(10);
        }
        make.height.equalTo(@(22));
        make.width.equalTo(@120);
    }];
    self.starIsChanged = false;
    //已完成评价
    UILabel *completedEvaluationLabel= [[UILabel alloc]init];
    [completedEvaluationLabel setText:@"已完成评价"];
    [completedEvaluationLabel setTextColor:RGBA(255, 204, 35, 1)];
    [completedEvaluationLabel setFont:GKFont(12)];
    completedEvaluationLabel.textAlignment = NSTextAlignmentCenter;
    [self.footerView addSubview:completedEvaluationLabel];
    [completedEvaluationLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.bottom.equalTo(self.footerView);
//        make.centerX.equalTo(self.starView);
        make.size.mas_equalTo(CGSizeMake(70, 17));
    }];
    [completedEvaluationLabel setHidden:true];
    self.completedEvaluationLabel = completedEvaluationLabel;
    
}

- (IBAction)cheackDetails:(id)sender {
//    [[NSNotificationCenter defaultCenter] postNotificationName:@"cheackDetails" object:nil];
}
#pragma mark - 设置初始数据

//- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
//    NSLog(@"这次星级为 %f",_starView.actualScore);
//}

- (void)didChangeStar {
    NSLog(@"这次星级为 %f",_starView.actualScore);
    //星级评价变动
    self.starIsChanged = true;
    self.actualScore = _starView.actualScore;
    [[NSNotificationCenter defaultCenter] postNotificationName:@"starIsChanged" object:nil];
}





#pragma mark - Setter Getter Methods

@end
