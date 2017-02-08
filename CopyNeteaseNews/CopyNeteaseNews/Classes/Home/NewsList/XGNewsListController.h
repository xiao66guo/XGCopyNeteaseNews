//
//  XGNewsListController.h
//  CopyNeteaseNews
//
//  Created by 小果 on 2017/2/7.
//  Copyright © 2017年 小果. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 *  该控制器用来显示每一个频道的新闻列表
 */
@interface XGNewsListController : UIViewController
/**
 *  频道的编号
 */
@property (nonatomic, strong, readonly) NSString *channelID;

/**
 *  频道的索引
 */
@property (nonatomic, assign, readonly) NSInteger channelIndex;

/**
 *  使用频道的编号和索引创建控制器
 */
- (instancetype)initWithChannelID:(NSString *)channelID channelIndex:(NSInteger)index;

@end
