//
//  DCZuoWenRightButton.m
//  GFMapleLeaves
//
//  Created by mrwang90hou on 2019/9/10.
//  Copyright © 2019年 mrwang90hou. All rights reserved.
//

#import "DCZuoWenRightButton.h"

// Controllers

// Models

// Views

// Vendors

// Categories

// Others

@interface DCZuoWenRightButton ()



@end

@implementation DCZuoWenRightButton

#pragma mark - Intial
//- (instancetype)initWithFrame:(CGRect)frame {
//
//    self = [super initWithFrame:frame];
//    if (self) {
//    }
//    return self;
//}
//
- (void)layoutSubviews
{
    [super layoutSubviews];
//
//    //设置lable
//    self.titleLabel.dc_x = 0;
//    self.titleLabel.dc_centerY = self.dc_centerY;
//    [self.titleLabel sizeToFit];
//
//    //设置图片位置
//    self.imageView.dc_x = CGRectGetMaxX(self.titleLabel.frame) + 5;
//    self.imageView.dc_centerY = self.dc_centerY;
//    [self.imageView sizeToFit];
    
    
    CGRect titleF = self.titleLabel.frame;
    CGRect imageF = self.imageView.frame;
    
    titleF.origin.x = 0;
    self.titleLabel.frame = titleF;
    
    imageF.origin.x = CGRectGetMaxX(titleF) + 8;
    self.imageView.frame = imageF;

}
///**
// *  标题的位置
// *
// *  @param contentRect <#contentRect description#>
// *
// *  @return <#return value description#>
// */
//- (CGRect)titleRectForContentRect:(CGRect)contentRect{
//
//    CGRect rect;
//    rect.origin.x = 0;
//    rect.origin.y = self.frame.size.height / 2 - 10;
//    rect.size.height = 20;
//    rect.size.width = self.frame.size.width / 2 + 15;
//    return rect;
//}
///**
// *  图片的位置
// *
// *  @param contentRect <#contentRect description#>
// *
// *  @return <#return value description#>
// */
//- (CGRect)imageRectForContentRect:(CGRect)contentRect{
//
//    CGRect rect;
//    rect.origin.x = self.frame.size.width / 2 + 15;
//    rect.origin.y = self.frame.size.height / 2 - 10;
//
//    rect.size.height = self.frame.size.height/2;
//    rect.size.width = 10;
//    return rect;
//}
#pragma mark - Setter Getter Methods

@end
