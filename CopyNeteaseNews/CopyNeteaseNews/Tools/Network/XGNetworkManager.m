//
//  XGNetworkManager.m
//  CopyNeteaseNews
//
//  Created by 小果 on 2017/2/7.
//  Copyright © 2017年 小果. All rights reserved.
//

#import "XGNetworkManager.h"

@implementation XGNetworkManager

+ (instancetype)shareManager {
    static XGNetworkManager *instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        NSURL *baseURL = [NSURL URLWithString:@"http://c.m.163.com/nc/article/"];
        
        instance = [[self alloc] initWithBaseURL:baseURL];
    });
    return instance;
}
@end
