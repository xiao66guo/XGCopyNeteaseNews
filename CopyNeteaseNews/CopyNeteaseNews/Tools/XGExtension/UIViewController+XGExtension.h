//
//  UIViewController+XGExtension.h
//  dsfa
//
//  Created by 小果 on 2017/2/7.
//  Copyright © 2017年 小果. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (XGExtension)

/**
 * 在当前视图控制器中添加子控制器，将子控制器的视图添加到 view 中
 *
 * @param childController 要添加的子控制器
 * @param view            要添加到的视图
 */
- (void)xg_addChildController:(UIViewController *)childController intoView:(UIView *)view;

@end
