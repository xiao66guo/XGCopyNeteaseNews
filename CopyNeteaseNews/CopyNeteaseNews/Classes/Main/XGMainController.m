//
//  XGMainController.m
//  CopyNeteaseNews
//
//  Created by 小果 on 2017/2/7.
//  Copyright © 2017年 小果. All rights reserved.
//

#import "XGMainController.h"

@interface XGMainController ()

@end

@implementation XGMainController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self addChildViewControllers];
}

#pragma mark - 添加子控制器
- (void)addChildViewControllers {
    // 设置tabbar字体颜色
    self.tabBar.tintColor = [UIColor xg_colorWithHex:0xDF0000];
    
    NSArray *array = @[@{@"clsName":@"UIViewController",@"title":@"新闻",@"imageName":@"news"},
                       @{@"clsName":@"UIViewController",@"title":@"阅读",@"imageName":@"reader"},
                       @{@"clsName":@"UIViewController",@"title":@"视频",@"imageName":@"media"},
                       @{@"clsName":@"UIViewController",@"title":@"话题",@"imageName":@"bar"},
                       @{@"clsName":@"UIViewController",@"title":@"我",@"imageName":@"me"}
                       ];
    
    NSMutableArray *arrayM = [NSMutableArray array];
    
    for (NSDictionary *dict in array) {
        [arrayM addObject:[self childViewControllerWithDict:dict]];
    }
    
    self.viewControllers = arrayM.copy;
}

#pragma mark - 创建子控制器的方法
- (UIViewController *)childViewControllerWithDict:(NSDictionary *)dict {
    // 创建控制器
    NSString *clsName = dict[@"clsName"];
    Class cls = NSClassFromString(clsName);
    
    // 断言，如果传入的类名为空，则提示
    NSAssert(cls != nil, @"传入的类名错误");
    // 创建控制器
    UIViewController *vc = cls.new;
    
    // 设置标题
    vc.title = dict[@"title"];
    
    // 设置图片
    NSString *iconName = [NSString stringWithFormat:@"tabbar_icon_%@_normal",dict[@"imageName"]];
    vc.tabBarItem.image = [UIImage imageNamed:iconName];
    // 高亮图片
    NSString *lightIconName = [NSString stringWithFormat:@"tabbar_icon_%@_highlight",dict[@"imageName"]];
    vc.tabBarItem.selectedImage = [[UIImage imageNamed:lightIconName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:vc];
    
    return nav;
}
@end
