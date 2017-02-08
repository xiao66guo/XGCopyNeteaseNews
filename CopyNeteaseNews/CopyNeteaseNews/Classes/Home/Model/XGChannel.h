//
//  XGChannel.h
//  CopyNeteaseNews
//
//  Created by 小果 on 2017/2/8.
//  Copyright © 2017年 小果. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XGChannel : NSObject

/**
 *  频道 名称
 */
@property (nonatomic, copy) NSString *tname;

/**
 *  频道 ID
 */
@property (nonatomic, copy) NSString *tid;

/**
 *  返回加载的频道数组
 */
+ (NSArray *)channelList;
@end
