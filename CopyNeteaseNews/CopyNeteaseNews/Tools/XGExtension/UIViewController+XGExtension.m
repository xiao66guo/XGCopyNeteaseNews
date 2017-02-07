//
//  UIViewController+XGExtension.m
//  dsfa
//
//  Created by 小果 on 2017/2/7.
//  Copyright © 2017年 小果. All rights reserved.
//

#import "UIViewController+XGExtension.h"

@implementation UIViewController (XGExtension)

- (void)xg_addChildController:(UIViewController *)childController intoView:(UIView *)view  {
    
    [self addChildViewController:childController];
    
    [view addSubview:childController.view];
    
    [childController didMoveToParentViewController:self];
}

@end
