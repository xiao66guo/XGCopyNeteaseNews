//
//  XGNetworkManager.h
//  CopyNeteaseNews
//
//  Created by 小果 on 2017/2/7.
//  Copyright © 2017年 小果. All rights reserved.
//

#import <AFNetworking/AFNetworking.h>

@interface XGNetworkManager : AFHTTPSessionManager

+ (instancetype)shareManager;

/**
 *  加载新闻列表
 *
 *  @param channel    频道的字符串
 *  @param start      开始加载时的数字
 *  @param completion 加载完成时的回调
 *
 */
- (void)newsListWithChannel:(NSString *)channel start:(NSInteger)start completion:(void (^)(NSArray *array, NSError *error))completion;

/**
 *  使用 docid 加载新闻详情
 *
 *  @param docid      文档编号
 *  @param completion 完成回调
 */
- (void)newsDetailWithDocid:(NSString *)docid completion:(void (^)(NSDictionary *dict, NSError *error))completion;
@end
