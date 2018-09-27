//
//  GKUpDownButton.m
//  GFMapleLeaves
//
//  Created by mrwang90hou on 2019/9/15.
//  Copyright © 2019年 mrwang90hou. All rights reserved.
//

#import "GKUpDownButton.h"

// Controllers

// Models

// Views

// Vendors

// Categories

// Others


@interface GKUpDownButton ()



@end

@implementation GKUpDownButton
#pragma mark - Intial
-(void)setUp
{
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    [self setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self setUp];
    }
    return self;
}
- (void)awakeFromNib
{
    [super awakeFromNib];
    [self setUp];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.imageView.dc_centerX = self.dc_width * 0.5;
    self.imageView.dc_centerY  =  self.dc_height * 0.3;
    
    [self.titleLabel sizeToFit];
    self.titleLabel.dc_centerX = self.dc_width * 0.5;
//    self.titleLabel.dc_y  =  self.imageView.dc_bottom + self.dc_height * 0.12;
    self.titleLabel.dc_y  =  self.imageView.dc_bottom;
}



@end
