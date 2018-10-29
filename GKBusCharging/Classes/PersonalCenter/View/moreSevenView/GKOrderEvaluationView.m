//
//  GKOrderEvaluationView.m
//  STOExpressDelivery
//
//  Created by mrwang90hou on 2019/10/8.
//  Copyright © 2018年 goockr. All rights reserved.
//

#import "GKOrderEvaluationView.h"
// Models

// Views
#import "UIView+Toast.h"
// Vendors
#import <SVProgressHUD.h>
// Categories

// Others

@interface GKOrderEvaluationView ()

@property (strong, nonatomic) IBOutlet UIView *footerView;

@end

@implementation GKOrderEvaluationView
#pragma mark - Intial

//+ (instancetype)loadViewFromXib
//{
//    GCRightDeivceView *view=[[[NSBundle mainBundle] loadNibNamed:@"GCRightDeivceView" owner:self options:nil]lastObject];
//
//    return view;
//
//}
- (void)awakeFromNib
{
    [super awakeFromNib];
}

-(void)setNeedsLayout{
    [super setNeedsLayout];
    //    self.userImageV.layer.cornerRadius=self.userImageV.image.size.width/2;
    //    self.userImageV.image=[UIImage imageNamed:@"consult_doctor_icon"];
    
//    UIColor *bgColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"bus_information_bg"]];
//    [self setBackgroundColor:bgColor];
//    [self addSubview:self.headerView];
    
    
}
-(void)setHidden:(BOOL)hidden{
    //    _hidden = hidden;
    //    self.noCommentLabel.hidden = hidden;
}
#pragma mark - Setter Getter Methods

@end
