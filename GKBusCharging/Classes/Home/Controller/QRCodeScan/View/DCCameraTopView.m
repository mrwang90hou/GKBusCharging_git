//
//  DCCameraTopView.m
//  STOExpressDelivery
//
//  Created by mrwang90hou on 2019/9/26.
//Copyright © 2019年 STO. All rights reserved.
//

#import "DCCameraTopView.h"

// Controllers

// Models

// Views

// Vendors

// Categories

// Others

@interface DCCameraTopView ()

/* 左边Item */
@property (strong , nonatomic)UIButton *leftItemButton;
/* 右边Item */
@property (strong , nonatomic)UIButton *rightItemButton;
/* 右边第二个Item */
@property (strong , nonatomic)UIButton *rightRItemButton;

@property (nonatomic,strong) UILabel *titleLabel;


@end

@implementation DCCameraTopView

#pragma mark - Intial
- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        
        [self setUpUI];
    }
    return self;
}
- (void)setUpUI
{
    self.backgroundColor = [UIColor clearColor];
    
    self.leftItemButton = ({
        UIButton * button = [UIButton new];
        [button setImage:[UIImage imageNamed:@"btn_back_white_normal"] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(leftButtonItemClick) forControlEvents:UIControlEventTouchUpInside];
        button;
    });
    
    _rightItemButton = ({
        UIButton * button = [UIButton new];
//        [button setImage:[UIImage imageNamed:@"starsq_sandbox-btn_camera_light"] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(rightButtonItemClick) forControlEvents:UIControlEventTouchUpInside];
        button;
    });
    
    _rightRItemButton = ({
        UIButton * button = [UIButton new];
//        [button setImage:[UIImage imageNamed:@"scan_photo_album"] forState:UIControlStateNormal];
        [button setTitle:@"相册" forState: UIControlStateNormal];
        [button setTintColor:[UIColor whiteColor]];
        [button addTarget:self action:@selector(rightRButtonItemClick) forControlEvents:UIControlEventTouchUpInside];
        button;
    });
    [self addSubview:_rightItemButton];
    [self addSubview:_rightRItemButton];
    [self addSubview:self.leftItemButton];
    
    //
    self.titleLabel = [[UILabel alloc]init];
    [self addSubview:_titleLabel];
    self.titleLabel.text = @"二维码/条码";
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    self.titleLabel.textColor = [UIColor whiteColor];
    
}

#pragma mark - 布局
- (void)layoutSubviews
{
    [super layoutSubviews];
    [self.leftItemButton mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(self.mas_top).offset(20);
        //        make.centerY.mas_equalTo(self).offset(K_HEIGHT_STATUSBAR/2);
        make.centerY.mas_equalTo(self);
        make.left.equalTo(self.mas_left).offset(DCMargin);
        make.height.equalTo(@35);
        make.width.equalTo(@35);
    }];
    
    [_rightItemButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.leftItemButton.mas_centerY);
        make.right.equalTo(self.mas_right).offset(-DCMargin);
        make.height.equalTo(@35);
        make.width.equalTo(@35);
    }];
    _rightItemButton.hidden = true;
    [_rightRItemButton mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.centerY.equalTo(self.leftItemButton.mas_centerY);
//        make.right.equalTo(_rightItemButton.mas_left).offset(-DCMargin);
//        make.height.equalTo(@35);
//        make.width.equalTo(@35);
        make.centerY.equalTo(self.leftItemButton.mas_centerY);
        make.right.equalTo(self.mas_right).offset(-DCMargin);
        make.height.equalTo(@35);
        make.width.equalTo(@60);
    }];
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.centerY.equalTo(self.leftItemButton.mas_centerY);
        make.height.equalTo(@35);
        make.width.equalTo(@150);
    }];
}


#pragma 自定义右边导航Item点击
- (void)rightButtonItemClick {
    !_rightItemClickBlock ? : _rightItemClickBlock();
}

#pragma 自定义左边导航Item点击
- (void)leftButtonItemClick {
    
    !_leftItemClickBlock ? : _leftItemClickBlock();
}

#pragma mark - 自定义右边第二个导航Item点击
- (void)rightRButtonItemClick
{
    !_rightRItemClickBlock ? : _rightRItemClickBlock();
}



@end
