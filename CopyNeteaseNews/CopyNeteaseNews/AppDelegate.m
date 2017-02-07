//
//  AppDelegate.m
//  CopyNeteaseNews
//
//  Created by 小果 on 2017/2/7.
//  Copyright © 2017年 小果. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [self setupApperance];
    
    _window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    _window.backgroundColor = [UIColor whiteColor];
    
    Class cls = NSClassFromString(@"XGMainController");
    
    UIViewController *vc = cls.new;
    
    _window.rootViewController = vc;
    [_window makeKeyAndVisible];
    
    return YES;
}

#pragma mark - 设置外观 apperance 是一个协议，通常用来设置控件的全局的外观
/*
    从 iOS 5 开始，Apple 通过 UIApperance 协议规范了对许多 UIKit 控件定制的支持，所有遵循 UIApperance 的协议的控件通过定制都可以呈现各种外观，所以设置外观的动作要尽可能的早，通常设置外观的代码会出现在 APPDelegate 中
 */
- (void)setupApperance {
    // 设置 tabbar 的渲染的颜色  - 在后续的外观设置之后，UITabBar 的 tintColor 全部是指定的颜色
    [UITabBar appearance].tintColor = [UIColor xg_colorWithHex:0xDF0000];
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
