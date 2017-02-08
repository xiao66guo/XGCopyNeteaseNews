//
//  XGHomeViewController.m
//  CopyNeteaseNews
//
//  Created by 小果 on 2017/2/7.
//  Copyright © 2017年 小果. All rights reserved.
//

#import "XGHomeViewController.h"
#import "XGChannelView.h"
#import "XGChannel.h"

#import "XGNewsListController.h"

@interface XGHomeViewController ()
// 频道视图
@property (nonatomic, weak) XGChannelView *channelView;
@end

@implementation XGHomeViewController{
    NSArray <XGChannel *>* _channelList;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
   
    [self setupUI];
    // 加载频道数据
    _channelList = [XGChannel channelList];
    
    // 传递频道数据
    _channelView.channelList = _channelList;
    
}

#pragma mark - 设置界面
- (void)setupUI {
    
    self.view.backgroundColor = [UIColor xg_randomColor];
    // 添加频道视图
    XGChannelView *channel = [XGChannelView loadChannelView];
    [self.view addSubview:channel];
    [channel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_topLayoutGuideBottom);
        make.right.left.equalTo(self.view);
        make.height.mas_equalTo(38);
    }];
    
    _channelView = channel;
    
    [self setupPageController];
}

#pragma mark - 设置分页控制器
- (void)setupPageController {
    // 1、实例化控制器
    UIPageViewController *pageVC = [[UIPageViewController alloc] initWithTransitionStyle:UIPageViewControllerTransitionStyleScroll navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal options:nil];
    
    // 2、设置分页控制器的<子控制器 - 新闻列表控制器>
    XGNewsListController *listVC = XGNewsListController.new;
    [pageVC setViewControllers:@[listVC] direction:UIPageViewControllerNavigationDirectionForward animated:NO completion:nil];
    
    // 3、将分页控制器当作子控制器添加到当前的控制器
    [self addChildViewController:pageVC];
    
    // 4、添加视图，并完成自动布局 - 能保证穿透效果，又能保证末尾的 Cell 显示完整
    [self.view addSubview:pageVC.view];
    
    [pageVC.view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.channelView.mas_bottom);
        make.left.right.bottom.equalTo(self.view);
//        make.bottom.equalTo(self.view).offset(-49);
    }];
    
    // 5、完成对子控制器的添加
    [pageVC didMoveToParentViewController:self];
}
@end
