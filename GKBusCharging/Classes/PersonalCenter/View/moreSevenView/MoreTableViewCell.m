//
//  MoreTableViewCell.m
//  UItableview Cell的点击
//
//  Created by apple on 28/2/17.
//  Copyright © 2017年 mark. All rights reserved.
//

#import "MoreTableViewCell.h"

#import "UITextView+STAutoHeight.h"
@interface MoreTableViewCell ()
//@property (nonatomic,strong) UITextView *contentTV;

@end

@implementation MoreTableViewCell

//- (void)awakeFromNib {
//    [super awakeFromNib];
//    // Initialization code
//}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    // Configure the view for the selected state
}

- (void)setCellModel:(DDCellModel *)cellModel{

     _cellModel = cellModel;
    
//    self.textLabel.text = cellModel.title;
//    self.detailTextLabel.text = cellModel.title;
    self.contentTV.text = cellModel.title;
    
    
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        
        UITextView *contentTV = [[UITextView alloc]initWithFrame:CGRectMake(0, 0, ([UIScreen mainScreen].bounds.size.width), self.bounds.size.height)];
        [self addSubview:contentTV];
        
        contentTV.font = [UIFont systemFontOfSize:14];
        contentTV.textColor = [UIColor grayColor];
        [contentTV setEditable:NO];
        
        contentTV.isAutoHeightEnable = YES;
//        contentTV.font = [UIFont systemFontOfSize:15];
//        contentTV.text = @"测试一下我是自适应高度的TextView";
//        contentTV.st_placeHolder = @"请输入您的信息";
//        contentTV.st_maxHeight = 200;
        contentTV.layer.borderWidth = .6;
        contentTV.layer.borderColor = [UIColor lightGrayColor].CGColor;
        contentTV.backgroundColor = [UIColor whiteColor];
        contentTV.st_lineSpacing = 5;
        contentTV.textViewHeightDidChangedHandle = ^(CGFloat textViewHeight) {
            
        };
        
        
        
        
        
        self.contentTV = contentTV;
        
    }
    return self;
}

@end
