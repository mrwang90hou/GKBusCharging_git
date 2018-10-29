//
//  GKLayer+LayerColor.m
//  GKBusCharging
//
//  Created by L on 2018/10/29.
//  Copyright © 2018年 goockr. All rights reserved.
//

#import "CALayer+LayerColor.h"

@implementation CALayer (LayerColor)
- (void)setBorderColorFromUIColor:(UIColor *)color
{
    self.borderColor = color.CGColor;
}
@end
