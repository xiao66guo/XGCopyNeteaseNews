//
//  NSString+XGBase64.h
//
//  Created by 小果 on 2017/2/7.
//  Copyright © 2017年 小果. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (XGBase64)

/// 对当前字符串进行 BASE 64 编码，并且返回结果
- (NSString *)xg_base64Encode;

/// 对当前字符串进行 BASE 64 解码，并且返回结果
- (NSString *)xg_base64Decode;

@end
