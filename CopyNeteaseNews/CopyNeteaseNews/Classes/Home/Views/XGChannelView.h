//
//  XGChannelView.h
//  CopyNeteaseNews
//
//  Created by 小果 on 2017/2/8.
//  Copyright © 2017年 小果. All rights reserved.
//

#import <UIKit/UIKit.h>
@class XGChannel;
@interface XGChannelView : UIView
/**
 *  从 XIB 加载并返回频道视图
 */
+ (instancetype)loadChannelView;
/**
 *  频道的列表数组
 */
@property (nonatomic, strong) NSArray <XGChannel *> *channelList;

@end
