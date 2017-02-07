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

@end
