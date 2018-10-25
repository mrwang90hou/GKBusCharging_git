//
//  UIButton+GKUpDownButton.h
//  GKBusCharging
//
//  Created by L on 2018/9/27.
//  Copyright © 2018年 goockr. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton (GKUpDownButton)
/**
 *  按钮边框设置
 *
 *  @param r
 *  @param g
 *  @param b
 *  @param alpha
 *  @param width
 */
-(void)setBorderR:(CGFloat)r G:(CGFloat)g B:(CGFloat)b alpha:(CGFloat)alpha width:(CGFloat)width;

- (void)resizedImageWithOrdinaryName:(NSString *)Ordinaryname HighlightName:(NSString *)HighlightName;

-(void)setButtonTitleAndImage:(NSString*)Normal Highlighted:(NSString*)Highlighted title:(NSString*)title;

-(void)setButtonBackgroundImage:(NSString*)Normal title:(NSString*)title;

-(void)setTitleAndFontAndColor:(UIColor*)color Title:(NSString*)title font:(CGFloat)font;

-(void)setTitleColor:(UIColor*)color Title:(NSString*)title font:(CGFloat)font backgroundColor:(UIColor*)backgroundColor;

-(UIButton*)getBianKuangAndTitle:(NSString*)Title R:(CGFloat)r G:(CGFloat)g B:(CGFloat)b alpha:(CGFloat)alpha width:(CGFloat)width;

-(void)setTitleAndFontAndNColor:(UIColor*)NColor HColor:(UIColor*)HColor Title:(NSString*)title font:(CGFloat)font;

@end
