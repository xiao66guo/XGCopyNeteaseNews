//
//  NSString+XGPath.m
//  dsfa
//
//  Created by 小果 on 2017/2/7.
//  Copyright © 2017年 小果. All rights reserved.
//

#import "NSString+XGPath.h"

@implementation NSString (XGPath)

+ (NSString *)xg_documentPath
{
    return [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
}

+ (NSString *)xg_cachePath
{
    return [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
}

+ (NSString *)xg_tempPath
{
    return NSTemporaryDirectory();
}

- (NSString *)xg_appendDocumentPath
{
    return [[NSString xg_documentPath] stringByAppendingPathComponent:self];
}

- (NSString *)xg_appendCachePath
{
    return [[NSString xg_cachePath] stringByAppendingPathComponent:self];
}

- (NSString *)xg_appendTempPath
{
    return [[NSString xg_tempPath] stringByAppendingPathComponent:self];
}

@end
