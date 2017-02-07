//
//  UILabel+XGExtension.h
//
//  Created by 小果 on 2017/2/7.
//  Copyright © 2017年 小果. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UILabel (XGExtension)
/**
 *  创建文本标签
 *
 *  @param text     文本
 *  @param fontSize 字体大小
 *  @param color    颜色
 *
 *  @return UILabel
 */
+ (instancetype)xg_labelWithText:(NSString *)text fontSize:(CGFloat)fontSize color:(UIColor *)color;

@end
