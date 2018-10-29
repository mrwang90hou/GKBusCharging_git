//
//  GKWithdrawalViewController.m
//  GKBusCharging
//
//  Created by L on 2018/10/29.
//  Copyright © 2018年 goockr. All rights reserved.
//

#import "GKWithdrawalViewController.h"
@interface GKWhithdrawalViewController()

@property (nonatomic,strong) UILabel *priceLabel;
@property (nonatomic,strong) UILabel *priceTimeLabel;
@property (nonatomic,assign) int priceProgress;

@end
@implementation GKWhithdrawalViewController
-(void)viewDidLoad{
    [super viewDidLoad];
    self.title = @"提现进度";
    [self.view setBackgroundColor:TABLEVIEW_BG];
    //记录当进度的数字
    self.priceProgress = 2;
    [self setUI];
}

-(void)setUI{
    //headerView
    UIView *headerView = [[UIView alloc]init];
    [self.view addSubview:headerView];
    [headerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.view.mas_top).offset(K_HEIGHT_NAVBAR+15);
        make.left.right.equalTo(self.view);
        make.height.mas_equalTo(ScreenH/4);
    }];
//    money_present_progress_bg
    //UIImageView
    UIImageView *uiImageView = [[UIImageView alloc]initWithImage:SETIMAGE(@"money_present_progress_bg")];
    [headerView addSubview:uiImageView];
    [uiImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(headerView);
    }];
    //priceLabel
    UILabel *priceLabel = [[UILabel alloc]init];
    [priceLabel setText:@"￥3000"];
    [priceLabel setFont:GKFont(32)];
    [priceLabel setTextColor:BUTTONMAINCOLOR];
    priceLabel.textAlignment = NSTextAlignmentCenter;
    [headerView addSubview:priceLabel];
    [priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(headerView.mas_centerY).offset(-10);
        make.centerX.equalTo(headerView);
        make.size.mas_equalTo(CGSizeMake(300, 45));
    }];
    self.priceLabel = priceLabel;
    //Label01
    UILabel *Label01 = [[UILabel alloc]init];
    [Label01 setText:@"提现金额"];
    [Label01 setFont:GKFont(14)];
    [Label01 setTextColor:TEXTMAINCOLOR];
    Label01.textAlignment = NSTextAlignmentCenter;
    [headerView addSubview:Label01];
    [Label01 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(headerView.mas_centerY).offset(5);
        make.centerX.equalTo(headerView);
        make.size.mas_equalTo(CGSizeMake(80, 20));
    }];
    //Label02
    UILabel *Label02 = [[UILabel alloc]init];
    [Label02 setText:@"预计1-5个工作日"];
    [Label02 setFont:GKFont(11)];
    [Label02 setTextColor:TEXTGRAYCOLOR];
    Label02.textAlignment = NSTextAlignmentCenter;
    [headerView addSubview:Label02];
    [Label02 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(headerView.mas_bottom).offset(-ScreenH/4/6);
        make.centerX.equalTo(headerView);
        make.size.mas_equalTo(CGSizeMake(140, 16));
    }];


    //footerView
    UIView *footerView = [[UIView alloc]init];
    [footerView setBackgroundColor:[UIColor whiteColor]];
    [self.view addSubview:footerView];
    [footerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(headerView.mas_bottom).offset(10);
        make.left.right.bottom.equalTo(self.view);
    }];

    //footerTopView
    UIView *footerTopView = [[UIView alloc]init];
    [footerTopView setBackgroundColor:[UIColor whiteColor]];
    [footerView addSubview:footerTopView];
    [footerTopView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(footerView);
        make.left.right.equalTo(footerView);
        make.height.mas_equalTo(44);
    }];
    //priceTimeLabel
    UILabel *priceTimeLabel = [[UILabel alloc]init];
    [priceTimeLabel setText:@"2018/09/08  13:20"];
    [priceTimeLabel setFont:GKFont(11)];
    [priceTimeLabel setTextColor:TEXTGRAYCOLOR];
    priceTimeLabel.textAlignment = NSTextAlignmentCenter;
    [footerTopView addSubview:priceTimeLabel];
    [priceTimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(footerTopView);
        make.right.mas_equalTo(footerTopView).offset(-10);
        make.size.mas_equalTo(CGSizeMake(120, 16));
    }];
    //footerLastView
    UIView *footerLastView = [[UIView alloc]init];
    [footerView addSubview:footerLastView];
    [footerLastView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(footerTopView.mas_bottom).offset(15);
        make.left.right.bottom.equalTo(self.view);
    }];
    
    /*标记序号*/
    UIImageView *image01 = [[UIImageView alloc]initWithImage:SETIMAGE(@"icon_money_present_progress_2") highlightedImage:SETIMAGE(@"icon_money_present_progress_1")];
    UIImageView *image02 = [[UIImageView alloc]initWithImage:SETIMAGE(@"icon_money_present_progress_2") highlightedImage:SETIMAGE(@"icon_money_present_progress_1")];
    UIImageView *image03 = [[UIImageView alloc]initWithImage:SETIMAGE(@"icon_money_present_progress_2") highlightedImage:SETIMAGE(@"icon_money_present_progress_1")];
    UIImageView *lineImage01 = [[UIImageView alloc]initWithImage:SETIMAGE(@"icon_money_present_progress_line_2") highlightedImage:SETIMAGE(@"icon_money_present_progress_line_1")];
    UIImageView *lineImage02 = [[UIImageView alloc]initWithImage:SETIMAGE(@"icon_money_present_progress_line_2") highlightedImage:SETIMAGE(@"icon_money_present_progress_line_1")];
    [footerLastView addSubview:image01];
    [footerLastView addSubview:image02];
    [footerLastView addSubview:image03];
    [footerLastView addSubview:lineImage01];
    [footerLastView addSubview:lineImage02];
    [image01 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(footerLastView.mas_top).offset(10);
        make.left.mas_equalTo(footerLastView.mas_left).offset(15);
        make.size.mas_equalTo(CGSizeMake(20, 20));
    }];
    [lineImage01 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(image01);
        make.top.mas_equalTo(image01.mas_bottom);
        make.size.mas_equalTo(CGSizeMake(1, K_IPHONE_5?55:66));
    }];
    [image02 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(lineImage01.mas_bottom);
        make.left.equalTo(image01);
        make.size.equalTo(image01);
    }];
    [lineImage02 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(image02);
        make.top.mas_equalTo(image02.mas_bottom);
        make.size.equalTo(lineImage01);
    }];
    [image03 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(lineImage02.mas_bottom);
        make.left.equalTo(image01);
        make.size.equalTo(image01);
    }];
    /*序号内容*/
    UILabel *numberLabel01 = [[UILabel alloc]init];
    UILabel *numberLabel02 = [[UILabel alloc]init];
    UILabel *numberLabel03 = [[UILabel alloc]init];
    /*messageView*/
    UIView *messageView01 = [[UIView alloc]init];
    UIView *messageView02 = [[UIView alloc]init];
    UIView *messageView03 = [[UIView alloc]init];
    
    NSArray *arrLabel = @[numberLabel01,numberLabel02,numberLabel03];
    NSArray *arrImage = @[image01,image02,image03];
    NSArray *arrLineImage = @[lineImage01,lineImage02];
    NSArray *arrMessageView = @[messageView01,messageView02,messageView03];
    for (int i=1;i<=3;i++) {
        UILabel *label = [arrLabel objectAtIndex:i-1];
        UIImageView *iamgeView = [arrImage objectAtIndex:i-1];
        UIView *messageView = [arrMessageView objectAtIndex:i-1];
        [footerLastView addSubview:messageView];
        [iamgeView addSubview:label];
        label.textAlignment = NSTextAlignmentCenter;
        [label setText:[NSString stringWithFormat:@"%d",i]];
        [label setFont:GKFont(11)];
        [label setTextColor:[UIColor whiteColor]];
//        [iamgeView setHighlighted:YES];
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(iamgeView);
            make.size.mas_equalTo(CGSizeMake(6, 16));
        }];
        [messageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(iamgeView.mas_right).offset(15);
            make.right.equalTo(self.view);
            make.centerY.equalTo(iamgeView);
            make.height.mas_equalTo(K_IPHONE_5?44:55);
        }];
//        [messageView setBackgroundColor:[UIColor redColor]];
    }
    /*TitleLabel 和 detailLabel */
//    UILabel *titleLabel01,*titleLabel02,*titleLabel03;
//    UILabel *detailLabel01,*detailLabel02,*detailLabel03;
//    NSArray *arrTitleLabel = @[titleLabel01,titleLabel02,titleLabel03];
//    NSArray *arrDetailLabel = @[detailLabel01,detailLabel02,detailLabel03];
//    for (int i=1;i<=3;i++) {
//        UILabel *titleLaebl = [arrTitleLabel objectAtIndex:i-1];
//    }
    NSArray *arrTitleLabelText = @[@"提交成功", @"处理中", @"提现成功"];
    NSArray *arrDetailLabelText = @[@"申请提交成功。", @"请耐心等待。", @"已经成功提现，预计1-5个工作日内到账。"];
    for (int i = 0; i < 3; i++) {
        UILabel *titleLabel = [[UILabel alloc]init];
        UILabel *detailLabel = [[UILabel alloc]init];
        UIView *messageView = [arrMessageView objectAtIndex:i];
        
        [titleLabel setText:[arrTitleLabelText objectAtIndex:i]];
        [detailLabel setText:[arrDetailLabelText objectAtIndex:i]];
        [titleLabel setFont:GKFont(14)];
        [detailLabel setFont:GKFont(11)];
        [titleLabel setTextColor:TEXTMAINCOLOR];
        [detailLabel setTextColor:TEXTGRAYCOLOR];
        [messageView addSubview:titleLabel];
        [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.centerY.mas_equalTo(messageView.mas_centerY).offset(-K_IPHONE_5?44:55/4);
//            make.centerY.mas_equalTo(-K_IPHONE_5?44:55/4);
//            make.top.mas_equalTo(messageView.mas_top).offset(K_IPHONE_5?44:55/4);
            make.bottom.mas_equalTo(messageView.mas_centerY);
            make.left.equalTo(messageView);
            make.size.mas_equalTo(CGSizeMake(ScreenW-20, 20));
        }];
        [messageView addSubview:detailLabel];
        [detailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.centerY.mas_equalTo(messageView.mas_centerY).offset(K_IPHONE_5?44:55/4);
            //            make.centerY.mas_equalTo(-messageView.bounds.size.height/4*3);
            make.top.mas_equalTo(messageView.mas_centerY).offset(K_IPHONE_5?5:8);
            make.left.equalTo(messageView);
            make.size.mas_equalTo(CGSizeMake(ScreenW-20, 16));
        }];
    }
    /*当前进度情况 的 变化*/
    for (int i = 0; i < self.priceProgress; i++) {
        UIImageView *image = [arrImage objectAtIndex:i];
        [image setHighlighted:true];
        if (i == self.priceProgress-1) {
            break;
        }
        UIImageView *lineImage = [arrLineImage objectAtIndex:i];
        [lineImage setHighlighted:YES];
        NSLog(@"i = %d",i);
    }
}

@end
