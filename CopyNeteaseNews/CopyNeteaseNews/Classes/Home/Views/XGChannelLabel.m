//
//  XGChannelLabel.m
//  CopyNeteaseNews
//
//  Created by 小果 on 2017/2/8.
//  Copyright © 2017年 小果. All rights reserved.
//

#import "XGChannelLabel.h"

#define kNormalSize 14
#define kSelectedSize 18

@implementation XGChannelLabel
+ (instancetype)channelLabelWithTitle:(NSString *)title {
    
    XGChannelLabel *lab = [self xg_labelWithText:title fontSize:kSelectedSize color:[UIColor blackColor]];
    
    lab.textAlignment = NSTextAlignmentCenter;
    lab.font = [UIFont systemFontOfSize:kNormalSize];
    [lab sizeToFit];
    
    return lab;
}

- (void)setScale:(float)scale {
    _scale = scale;
    
    float max = (float)kSelectedSize / kNormalSize;
    float min = 1;
    
    float sl = (max - 1) * scale + min;
    
    // 设置 label 的形变
    self.transform = CGAffineTransformMakeScale(sl, sl);
}

@end
