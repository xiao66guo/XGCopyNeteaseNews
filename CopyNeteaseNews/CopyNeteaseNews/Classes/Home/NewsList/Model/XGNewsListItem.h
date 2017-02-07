//
//  XGNewsListItem.h
//  CopyNeteaseNews
//
//  Created by 小果 on 2017/2/7.
//  Copyright © 2017年 小果. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XGNewsListItem : NSObject

/**
 * 标题
 */
@property (nonatomic, copy) NSString *title;
/**
 * 新闻摘要
 */
@property (nonatomic, copy) NSString *digest;
/**
 * 图像 URL 地址
 */
@property (nonatomic, copy) NSString *imgsrc;
/**
 * 跟帖数量
 */
@property (nonatomic, assign) NSInteger replyCount;
/**
 * 来源
 */
@property (nonatomic, copy) NSString *source;

/**
 * 多图新闻的其余图片
 */
@property (nonatomic, strong) NSArray *imgextra;

@end
