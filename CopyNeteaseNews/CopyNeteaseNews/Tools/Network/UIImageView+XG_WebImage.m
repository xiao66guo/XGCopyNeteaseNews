//
//  UIImageView+XG_WebImage.m
//  CopyNeteaseNews
//
//  Created by 小果 on 2017/2/8.
//  Copyright © 2017年 小果. All rights reserved.
//

#import "UIImageView+XG_WebImage.h"
#import <UIImageView+WebCache.h>

@implementation UIImageView (XG_WebImage)

- (void)xg_setImageWithURLString:(NSString *)urlString {
    
    NSURL *url = [NSURL URLWithString:urlString];
    
    if (url != nil) {
        [self sd_setImageWithURL:url];
    }
}

@end
