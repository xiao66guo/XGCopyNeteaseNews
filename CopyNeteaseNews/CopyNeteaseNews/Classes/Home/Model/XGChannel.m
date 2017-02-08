//
//  XGChannel.m
//  CopyNeteaseNews
//
//  Created by 小果 on 2017/2/8.
//  Copyright © 2017年 小果. All rights reserved.
//

#import "XGChannel.h"

@implementation XGChannel
- (NSString *)description {
    return [self yy_modelDescription];
}

+ (NSArray *)channelList {
    
    NSURL *url = [[NSBundle mainBundle] URLForResource:@"topic_news.json" withExtension:nil];
    NSData *data = [NSData dataWithContentsOfURL:url];
    NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:0 error:NULL];
    
    NSArray *array = dict[@"tList"];
    // 字典转模型
    NSArray *modelArray = [NSArray yy_modelArrayWithClass:[self class] json:array];
    
    return modelArray;
}

@end
