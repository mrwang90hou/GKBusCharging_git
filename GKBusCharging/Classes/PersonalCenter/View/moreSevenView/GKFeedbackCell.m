//
//  GKFeedbackCell.m
//  GKBusCharging
//
//  Created by L on 2018/10/25.
//  Copyright © 2018年 goockr. All rights reserved.
//

#import "GKFeedbackCell.h"

@interface GKFeedbackCell ()

@end

@implementation GKFeedbackCell

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
//    self.backgroundColor = Main_Color;
    
    self.gridImageView = [[UIImageView alloc] init];
    self.gridImageView.contentMode = UIViewContentModeScaleAspectFill;
//    [self.gridImageView setImage:[UIImage imageNamed:@"icon_personal_center_app_down"]];
    [self addSubview:self.gridImageView];
    
    self.titleTV = [[UITextView alloc] init];
    self.titleTV.font = PFR15Font;
    self.titleTV.editable = NO;
    self.titleTV.selectable = NO;
    self.backgroundColor = [UIColor clearColor];
    self.titleTV.userInteractionEnabled = NO;
//    self.titleTV.textAlignment = NSTextAlignmentCenter;
    [self contentSizeToFit];
    
//    self.automaticallyAdjustsScrollViewInsets = NO;
//    CGSize  size = [desc sizeWithFont:[UIFont systemFontOfSize:14] constrainedToSize:CGSizeMake(240, 2000) lineBreakMode:UILineBreakModeWordWrap];
////    然后需要定义UITextView的numberoflines为0，即不做行数的限制。如下：
//    [self.titleTV setNumberOfLines:0];
//    [self.titleTV setFrame:CGRectMake(40, 135, 240, size.height+10)];
//    [self.titleTV setText:desc];

//    UITextView *textView = [[UITextView alloc] init];
//    [self addSubview:textView];
//    textView.frame = CGRectMake(0, 0, 100, 100); // 自己随便定义
//    textView.font = [UIFont systemFontOfSize:17.0]; // 设置字体大小
//    CGFloat fontCapHeight = textView.font.capHeight; // 文字大小所占的高度
//    CGFloat topMargin = 10; // 跟顶部的间距
//    textView.contentInset = UIEdgeInsetsMake(-textView.frame.size.height*0.5 + fontCapHeight + topMargin, 0, 0, 0);
//
    [self addSubview:self.titleTV];

}

- (void)layoutSubviews
{
    [super layoutSubviews];
    [self.gridImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        [make.right.mas_equalTo(self.mas_right)setOffset:-DCMargin];
        if (iphone5) {
            make.size.mas_equalTo(CGSizeMake(38, 38));
        }else{
            make.size.mas_equalTo(CGSizeMake(45, 45));
        }
        make.centerY.equalTo(self);
    }];
    
    [self.titleTV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self);
        if (iphone5) {
            [make.left.mas_equalTo(self.mas_left)setOffset:DCMargin];
            make.size.mas_equalTo(CGSizeMake(ScreenW/4+DCMargin, 60));
        }else{
            [make.left.mas_equalTo(self.mas_left)setOffset:2*DCMargin];
            make.size.mas_equalTo(CGSizeMake(ScreenW/4, 60));
        }
    }];
    
    //解决 UITextView垂直居中的问题
    CGFloat fontCapHeight = self.titleTV.font.capHeight; // 文字大小所占的高度
//    CGFloat topMargin = 10; // 跟顶部的间距
    self.titleTV.contentInset = UIEdgeInsetsMake(-self.titleTV.frame.size.height*0.5 + fontCapHeight, 0, 0, 0);
    
}
- (void)contentSizeToFit
{
    //先判断一下有没有文字（没文字就没必要设置居中了）
    if([self.titleTV.text length]>0)
    {
        //titleTV的contentSize属性
        CGSize contentSize = self.titleTV.contentSize;
        //titleTV的内边距属性
        UIEdgeInsets offset;
        CGSize newSize = contentSize;
        
        //如果文字内容高度没有超过titleTV的高度
        if(contentSize.height <= self.titleTV.frame.size.height)
        {
            //titleTV的高度减去文字高度除以2就是Y方向的偏移量，也就是titleTV的上内边距
            CGFloat offsetY = (self.titleTV.frame.size.height - contentSize.height)/2;
            offset = UIEdgeInsetsMake(offsetY, 0, 0, 0);
        }
        else          //如果文字高度超出titleTV的高度
        {
            newSize = self.titleTV.frame.size;
            offset = UIEdgeInsetsZero;
            CGFloat fontSize = 18;
            
            //通过一个while循环，设置titleTV的文字大小，使内容不超过整个titleTV的高度（这个根据需要可以自己设置）
            while (contentSize.height > self.titleTV.frame.size.height)
            {
                [self.titleTV setFont:[UIFont fontWithName:@"Helvetica Neue" size:fontSize--]];
                contentSize = self.titleTV.contentSize;
            }
            newSize = contentSize;
        }
        
        //根据前面计算设置titleTV的ContentSize和Y方向偏移量
        [self.titleTV setContentSize:newSize];
        [self.titleTV setContentInset:offset];
        
    }
}
@end
