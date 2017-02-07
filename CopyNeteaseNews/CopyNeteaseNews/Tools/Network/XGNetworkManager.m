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
        
        // 设置响应的数据格式
        instance.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html", nil];
    });
    return instance;
}

#pragma mark - 封装 AFN 网络请求
/**
 *  发起 GET 请求
 *
 *  @param URLString  URLString
 *  @param parameters 参数字典
 *  @param completion 完成回调
 */
- (void)GETRequest:(NSString *)URLString parameters:(NSDictionary *)parameters completion:(void(^)(id json, NSError *error))completion {
    [self GET:URLString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        completion(responseObject,nil);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"网络请求失败 %@",error);
        
        completion(nil, error);
    }];
}

#pragma mark - 加载新闻接口
- (void)newsListWithChannel:(NSString *)channel start:(NSInteger)start completion:(void (^)(NSArray *, NSError *))completion {
    
    NSString *urlString = [NSString stringWithFormat:@"list/%@/%zd-20.html",channel,start];
    
    [self GETRequest:urlString parameters:nil completion:^(id json, NSError *error) {
        // 使用频道作为 key 来获取数组
        NSArray *array = json[channel];
        
        completion(array, error);
    }];
}

@end
