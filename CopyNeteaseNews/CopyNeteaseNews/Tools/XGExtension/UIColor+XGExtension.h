//
//  UIColor+XGExtension.h
//
//  Created by 小果 on 2017/2/7.
//  Copyright © 2017年 小果. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (XGExtension)

/**
 使用 16 进制数字创建颜色，例如 0xFF0000 创建红色
 
 @param hex 16 进制无符号32位整数
 
 @return 颜色
 */
+ (instancetype)xg_colorWithHex:(uint32_t)hex;

/**
 生成随机颜色
 
 @return 随机颜色
 */
+ (instancetype)xg_randomColor;

/**
 使用 R / G / B 数值创建颜色
 
 @param red   red
 @param green green
 @param blue  blue
 
 @return 颜色
 */
+ (instancetype)xg_colorWithRed:(uint8_t)red green:(uint8_t)green blue:(uint8_t)blue;

@end

