//
//  UIButton+XGExtension.h
//
//  Created by 小果 on 2017/2/7.
//  Copyright © 2017年 小果. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton (XGExtension)
/**
 *  创建文本按钮
 *
 *  @param title         文本
 *  @param fontSize      字体大小
 *  @param normalColor   默认颜色
 *  @param selectedColor 选中颜色
 *
 *  @return UIButton
 */
+ (instancetype)xg_textButton:(NSString *)title fontSize:(CGFloat)fontSize normalColor:(UIColor *)normalColor selectedColor:(UIColor *)selectedColor;
@end
