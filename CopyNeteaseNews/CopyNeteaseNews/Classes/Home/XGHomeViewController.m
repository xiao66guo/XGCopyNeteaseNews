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

@interface XGHomeViewController ()<UIPageViewControllerDataSource,UIPageViewControllerDelegate>
// 频道视图
@property (nonatomic, weak) XGChannelView *channelView;
// 分页控制器视图
@property (nonatomic, weak) UIPageViewController *pageViewController;
// 分页控制器内部的滚动视图
@property (nonatomic, weak) UIScrollView *pageScroll;
// 当前显示的列表控制器
@property (nonatomic, weak) XGNewsListController *currentListV;
// 将要显示的列表控制器
@property (nonatomic, weak) XGNewsListController *nextListV;
@end

@implementation XGHomeViewController{
    NSArray <XGChannel *>* _channelList;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // 取消自动调整滚动视图的间距
    self.automaticallyAdjustsScrollViewInsets = NO;
    // 加载频道数据
    _channelList = [XGChannel channelList];
   
    [self setupUI];
    
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
    
    // 添加监听的方法
    [channel addTarget:self action:@selector(didSelectedIndex:) forControlEvents:UIControlEventValueChanged];
    
    [self setupPageController];
}

#pragma mark - 监听频道标签被点击的方法
- (void)didSelectedIndex:(XGChannelView *)chaView {
    NSLog(@"选中的标签是：%zd",chaView.selectedIndex);
}

#pragma mark - 设置分页控制器
- (void)setupPageController {
    // 1、实例化控制器
    UIPageViewController *pageVC = [[UIPageViewController alloc] initWithTransitionStyle:UIPageViewControllerTransitionStyleScroll navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal options:nil];
    
    // 2、设置分页控制器的<子控制器 - 新闻列表控制器>
    XGNewsListController *listVC = [[XGNewsListController alloc] initWithChannelID:_channelList[0].tid channelIndex:0];
    [pageVC setViewControllers:@[listVC] direction:UIPageViewControllerNavigationDirectionForward animated:NO completion:nil];
    
    // 3、将分页控制器当作子控制器添加到当前的控制器
    [self addChildViewController:pageVC];
    
    // 4、添加视图，并完成自动布局 - 能保证穿透效果，又能保证末尾的 Cell 显示完整
    [self.view addSubview:pageVC.view];
    
    [pageVC.view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.channelView.mas_bottom);
        make.left.right.bottom.equalTo(self.view);
    }];
    
    // 5、完成对子控制器的添加
    [pageVC didMoveToParentViewController:self];
    
    // 6、设置数据源
    pageVC.dataSource = self;
    pageVC.delegate = self;
    
    _pageViewController = pageVC;
    if ([pageVC.view.subviews[0] isKindOfClass:[UIScrollView class]]) {
        _pageScroll = pageVC.view.subviews[0];
    }
}

#pragma mark - KVO 的监听方法
/**
 *  KVO 统一调用的监听方法
 *
 *  @param keyPath 监听 keyPath
 *  @param object  监听的对象,可以通过对象获的属性值
 *  @param change  监听变化
 *  @param context 上下文，通常传入 NULL
 */
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context {
//    NSLog(@"=====> %@",NSStringFromCGPoint(_pageScroll.contentOffset));
    
    CGFloat width = _pageScroll.bounds.size.width;
    CGFloat offsetX = ABS(_pageScroll.contentOffset.x - width);
    CGFloat scale = offsetX / width;
    
    // 根据索引调整频道标签的比例
    [_channelView channelLabelWithIndex:_currentListV.channelIndex scale:(1 - scale)];
    [_channelView channelLabelWithIndex:_nextListV.channelIndex scale:scale];
    
}

#pragma mark - UIPageViewControllerDelegate
// 即将展现下一个控制器
- (void)pageViewController:(UIPageViewController *)pageViewController willTransitionToViewControllers:(NSArray<XGNewsListController *> *)pendingViewControllers {
    
    // 记录当前显示的控制器和将要显示的控制器
    _currentListV = pageViewController.viewControllers[0];
    _nextListV = pendingViewControllers[0];
    
    // KVO 监听滚动视图
    [_pageScroll addObserver:self forKeyPath:@"contentOffset" options:0 context:NULL];
}

// 完成展现控制器的动画效果
- (void)pageViewController:(UIPageViewController *)pageViewController didFinishAnimating:(BOOL)finished previousViewControllers:(NSArray<UIViewController *> *)previousViewControllers transitionCompleted:(BOOL)completed {
    
    
    
    // 注销滚动视图的观察
    [_pageScroll removeObserver:self forKeyPath:@"contentOffset"];
}

#pragma mark - UIPageViewControllerDataSource
// 返回上一个视图控制器
- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(XGNewsListController *)viewController {
    
    // 获取当前控制器的频道的索引
    NSInteger indx = viewController.channelIndex;
    indx--;
    
    if (indx < 0) {
        NSLog(@"已到第一个频道了哦");
        return nil;
    }
    
    XGNewsListController *listV = [[XGNewsListController alloc] initWithChannelID:_channelList[indx].tid channelIndex:indx];
    
    return listV;
}

// 返回下一个视图控制器
- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(XGNewsListController *)viewController {
    // 获取当前控制器的频道的索引
    NSInteger indx = viewController.channelIndex;
    indx++;
    
    if (indx >= _channelList.count) {
        NSLog(@"已到最后一个频道了哦");
        return nil;
    }
    
    XGNewsListController *listV = [[XGNewsListController alloc] initWithChannelID:_channelList[indx].tid channelIndex:indx];
    
    return listV;
}
@end
