//
//  UIImageView+XG_WebImage.h
//  CopyNeteaseNews
//
//  Created by 小果 on 2017/2/8.
//  Copyright © 2017年 小果. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImageView (XG_WebImage)

/**
 *  使用 URLString 设置网络图片
 */
- (void)xg_setImageWithURLString:(NSString *)urlString;

@end
