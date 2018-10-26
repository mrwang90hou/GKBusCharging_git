//
//  GKReturnGuideViewController.m
//  GKBusCharging
//
//  Created by 王宁 on 2018/10/22.
//  Copyright © 2018年 goockr. All rights reserved.
//


#import "GKReturnGuideViewController.h"


@interface GKReturnGuideViewController ()
/**
 背景 View
 */
@property (strong, nonatomic) IBOutlet UIView *step02View;
@property (strong, nonatomic) IBOutlet UIView *step03View;
/**
 链条
 */
@property (strong, nonatomic) IBOutlet UIImageView *guideLine03;
@property (strong, nonatomic) IBOutlet UIImageView *guideLine04;
/**
 圆点
 */
@property (strong, nonatomic) IBOutlet UIView *cicleView02;
@property (strong, nonatomic) IBOutlet UIView *cicleView03;
/**
 步骤图：stepImageView
 */
@property (strong, nonatomic) IBOutlet UIImageView *step02ImageView;
@property (strong, nonatomic) IBOutlet UIImageView *step03ImageView;
/**
 步骤 TitleLabel：
 */
@property (strong, nonatomic) IBOutlet UILabel *titleLabel02;
@property (strong, nonatomic) IBOutlet UILabel *titleLabel03;


/**
 步骤DetailTF：
 */
@property (strong, nonatomic) IBOutlet UITextView *stepTF02;
@property (strong, nonatomic) IBOutlet UITextView *stepTF03;


/**
 充电状态
 */
@property (nonatomic,assign) Boolean chargingStatusBool;

@end

@implementation GKReturnGuideViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"使用指南";
    [self setUI];
}
-(void)setUI{
    //设置边框宽度及颜色
    self.step02View.layer.borderColor = RGB(255, 221, 146).CGColor;
    self.step02View.layer.borderWidth = 1;
    self.step03View.layer.borderColor = RGB(255, 221, 146).CGColor;
    self.step03View.layer.borderWidth = 1;
    
    self.cicleView02.layer.cornerRadius = 50;
    self.cicleView03.layer.cornerRadius = 50;
    
    
    
    self.cicleView02.layer.masksToBounds = YES;
    self.cicleView02.layer.cornerRadius = 12;
    self.cicleView03.layer.masksToBounds = YES;
    self.cicleView03.layer.cornerRadius = 12;
    
//    self.pointView.layer.cornerRadius = 11; //设置圆形的程度
//    self.pointView.layer.masksToBounds = YES; //设置是否切圆
//    self.pointView.layer.borderColor = [[UIColor greenColor]CGColor]; //设置圆周围的颜色
//    self.pointView.layer.borderWidth = 2; //设置圆环的粗细宽度

    //设置相对布局位置
    [self.step02View mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.view).offset(K_HEIGHT_NAVBAR+10);
        make.right.mas_equalTo(self.view).offset(-20);
        make.left.mas_equalTo(self.view).offset(20);
        make.height.mas_equalTo((ScreenH-K_HEIGHT_NAVBAR*2)/3);
    }];
    [self.step03View mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.step02View.mas_bottom).offset(10);
        make.left.right.equalTo(self.step02View);
        make.height.mas_equalTo(self.step02View);
    }];
    [self.guideLine03 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.step02View.mas_bottom).offset(-12);
        make.left.mas_equalTo(self.step02View.mas_left).offset(20);
        make.size.mas_equalTo(CGSizeMake(10, 34));
    }];
    [self.guideLine04 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.step02View.mas_bottom).offset(-12);
        make.right.mas_equalTo(self.step02View.mas_right).offset(-20);
        make.size.mas_equalTo(CGSizeMake(10, 34));
    }];
    
    
    //设置引导图的相对位置及针对于 iPhone5的自适应
    [self.step02ImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.step02View);
        make.centerX.mas_equalTo(self.view).offset(ScreenW/4);
        make.size.mas_equalTo(K_IPHONE_5 ? CGSizeMake(110, 125):CGSizeMake(148, 168));
    }];
    
    [self.step03ImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.step03View);
        make.centerX.mas_equalTo(self.view).offset(-ScreenW/4);
        make.size.mas_equalTo(K_IPHONE_5 ? CGSizeMake(80, 140):CGSizeMake(90, 157));
    }];
    
    [self.cicleView02 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(25, 25));
        //        make.center.equalTo(self.step01View);
        make.left.equalTo(self.step02View.mas_left).offset(30);
        make.bottom.equalTo(self.step02View.mas_centerY).offset(-self.step02View.bounds.size.height/4);
    }];
    
    [self.cicleView03 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(25, 25));
        //        make.center.equalTo(self.step01View);
        make.left.equalTo(self.step03View.mas_centerX);
        make.bottom.equalTo(self.step03View.mas_centerY).offset(-self.step02View.bounds.size.height/4);
    }];
    //TitleLabel布局
    self.titleLabel02.bounds = CGRectMake(self.cicleView02.center.x, self.cicleView02.center.y, 60, 24);
    self.titleLabel03.bounds = CGRectMake(self.cicleView03.center.x, self.cicleView03.center.y, 60, 24);

    [self.titleLabel02 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.cicleView02.mas_left).offset(25/2-2);
        make.top.mas_equalTo(self.cicleView02.mas_top).offset(25/2-2);
        make.size.mas_equalTo(CGSizeMake(60, 24));
    }];
    [self.titleLabel03 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.cicleView03.mas_left).offset(25/2-2);
        make.top.mas_equalTo(self.cicleView03.mas_top).offset(25/2-2);
        make.size.mas_equalTo(CGSizeMake(60, 24));
    }];
    [self.stepTF02 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.titleLabel02).offset(-4);
        make.top.mas_equalTo(self.titleLabel02.mas_bottom).offset(-4);
        make.size.mas_equalTo(CGSizeMake(126, 80));
    }];
    [self.stepTF03 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.titleLabel03).offset(-4);
        make.top.mas_equalTo(self.titleLabel03.mas_bottom).offset(-4);
        make.size.mas_equalTo(CGSizeMake(126, 80));
    }];
}
@end
