//
//  XGChannelLabel.h
//  CopyNeteaseNews
//
//  Created by 小果 on 2017/2/8.
//  Copyright © 2017年 小果. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XGChannelLabel : UILabel
// 标签的标题
+ (instancetype)channelLabelWithTitle:(NSString *)title;

// 缩放的比例
@property (nonatomic, assign) float scale;

@end
