//
//  UIScreen+XGExtension.m
//  dsfa
//
//  Created by 小果 on 2017/2/7.
//  Copyright © 2017年 小果. All rights reserved.
//

#import "UIScreen+XGExtension.h"

@implementation UIScreen (XGExtension)

+ (CGFloat)xg_screenWidth {
    return [UIScreen mainScreen].bounds.size.width;
}

+ (CGFloat)xg_screenHeight {
    return [UIScreen mainScreen].bounds.size.height;
}

+ (CGFloat)xg_scale {
    return [UIScreen mainScreen].scale;
}


@end
