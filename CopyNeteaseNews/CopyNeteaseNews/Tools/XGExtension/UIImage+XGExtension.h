//
//  UIImage+XGExtension.h
//
//  Created by 小果 on 2017/2/7.
//  Copyright © 2017年 小果. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (XGExtension)

/**
 *  返回一张可以随意拉伸但不变形的图片
 */
+(UIImage *)xg_resizedImage:(NSString *)name;

/**
 *  返回一张加水印的图片
 *
 *  @param bg   被加水印的图片
 *  @param logo 即将添加的图片
 *
 *  @return 制作完毕的水印图片
 */

+(instancetype)xg_waterImageWithBackground:(NSString *)bg logo:(NSString *)logo;
/**
 *  返回带边框的圆环形图
 *
 *  @param name        图片的名字
 *  @param borderWidth 圆环的线宽
 *  @param borderColor 圆环的颜色
 *
 *  @return 带边框的圆形图
 */
+ (instancetype)xg_circleImageWithName:(NSString *)name borderWidth:(CGFloat)borderWidth borderColor:(UIColor *)borderColor;

/**
 *  返回截屏的view
 *
 *  @param view 要截取的view
 *
 *  @return 截屏后的图片
 */
+ (instancetype)xg_captureWithView:(UIView *)view;

/// 根据当前图像，和指定的尺寸，异步生成圆角图像并且返回
- (void)xg_cornerImageWithSize:(CGSize)size fillColor:(UIColor *)fillColor completion:(void (^)(UIImage *image))completion;

@end
