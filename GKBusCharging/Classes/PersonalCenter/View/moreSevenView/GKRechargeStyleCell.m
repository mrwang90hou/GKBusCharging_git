//
//  GKRechargeStyleCell.h
//  GKBusCharging
//
//  Created by 王宁 on 2018/10/5.
//  Copyright © 2018年 goockr. All rights reserved.
//

#import "GKRechargeStyleCell.h"

@interface GKRechargeStyleCell()
@end
@implementation GKRechargeStyleCell

-(void)setNeedsLayout{
    [super setNeedsLayout];
//    self.userImageV.layer.cornerRadius=self.userImageV.image.size.width/2;
//    self.userImageV.image=[UIImage imageNamed:@"consult_doctor_icon"];
//    self.detailsLabel.text = @"王宁";
}

//
//-(void)createCellWithDictionary:(NSDictionary *)dict withNoCommentFlag:(BOOL)flag{
//    if (dict[@"Name"] == nil || dict[@"Name"] == NULL ||[dict[@"Name"] isKindOfClass:[NSNull class]] || [[dict[@"Name"] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length]==0) {
//        self.scoreLabel.text = @"";
//    }else{
//        self.scoreLabel.text = dict[@"Name"];
//    }
//    if (dict[@"EvaluateContent"] == nil || dict[@"EvaluateContent"] == NULL ||[dict[@"EvaluateContent"] isKindOfClass:[NSNull class]] || [[dict[@"EvaluateContent"] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length]==0) {
//        self.evaluationDetailsLabel.text = @"";
//    }else{
//        self.evaluationDetailsLabel.text = dict[@"EvaluateContent"];
//    }
//    
//    if (dict[@"Score"]) {
//        self.goodRateImage.image = [UIImage imageNamed:[NSString stringWithFormat:@"five_star%@",dict[@"Score"]]];
//    }
//    
//    
//    if (flag) {
//        self.userImageV.hidden = YES;
//        self.scoreLabel.hidden = YES;
//        self.evaluationDetailsLabel.hidden = YES;
//        self.satifyImageV.hidden = YES;
//        self.goodRateImage.hidden = YES;
//        self.noCommentLabel.hidden = NO;
//    }else{
//        self.userImageV.hidden = NO;
//        self.scoreLabel.hidden = NO;
//        self.evaluationDetailsLabel.hidden = NO;
//        self.satifyImageV.hidden = NO;
//        self.goodRateImage.hidden = NO;
//        self.noCommentLabel.hidden = YES;
//    }
//    
//    
//    self.evaluationDetailsLabel.numberOfLines = 0;
//    self.labelHeight.constant = [dict[@"EvaluateContent"] sizeWithFont:[UIFont systemFontOfSize:11] constrainedToSize:CGSizeMake(320, MAXFLOAT) lineBreakMode:UILineBreakModeWordWrap].height+10;
//}
//- (void)awakeFromNib {
//    [super awakeFromNib];
    // Initialization code
//}
@end
