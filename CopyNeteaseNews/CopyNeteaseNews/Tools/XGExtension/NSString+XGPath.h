//
//  NSString+XGPath.h
//  dsfa
//
//  Created by 小果 on 2017/2/7.
//  Copyright © 2017年 小果. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (XGPath)

/** 文档目录 */
+ (NSString *)xg_documentPath;
/** 缓存目录 */
+ (NSString *)xg_cachePath;
/** 临时目录 */
+ (NSString *)xg_tempPath;

/**
 *  添加文档路径
 */
- (NSString *)xg_appendDocumentPath;
/**
 *  添加缓存路径
 */
- (NSString *)xg_appendCachePath;
/**
 *  添加临时路径
 */
- (NSString *)xg_appendTempPath;

@end
