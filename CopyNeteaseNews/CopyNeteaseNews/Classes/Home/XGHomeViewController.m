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
#import "XGNewsListItem.h"
#import "XGNewsListController.h"
#import "XGNewsDetailController.h"

extern NSString *const XGNewsListSelectedDocidNotification;

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
    // 隐藏导航控制器的导航条
    // a> 第一种方法：不好，因为边缘返回的手势没有了
    // self.navigationController.navigationBarHidden = YES;
    // b> 第二种方法：边缘手势会保留
    self.navigationController.navigationBar.hidden = YES;
    
    // 取消自动调整滚动视图的间距
    self.automaticallyAdjustsScrollViewInsets = NO;
    // 加载频道数据
    _channelList = [XGChannel channelList];
   
    [self setupUI];
    
    // 传递频道数据
    _channelView.channelList = _channelList;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didSelectedDocidDetail:) name:XGNewsListSelectedDocidNotification object:nil];
    
}

#pragma mark - 通知的监听方法
- (void)didSelectedDocidDetail:(NSNotification *)noti {
    XGNewsListItem *model = noti.object;
    
    // 创建目标控制器
    XGNewsDetailController *detailVC = XGNewsDetailController.new;
    detailVC.detailItem = model;
    // 隐藏底部tabbar
    detailVC.hidesBottomBarWhenPushed = YES;
    
    [self.navigationController pushViewController:detailVC animated:YES];
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - 设置界面
- (void)setupUI {
    
    self.view.backgroundColor = [UIColor whiteColor];
    // 创建 NavBar
    UINavigationBar *navBar = [[UINavigationBar alloc] init];
    [self.view addSubview:navBar];
    [navBar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(self.view);
        // 高度是 64 包含了状态栏的高度
        make.height.mas_equalTo(64);
    }];
    // 设置标题
    UINavigationItem *item  = [[UINavigationItem alloc] initWithTitle:@"网易新闻"];
    navBar.items = @[item];
    
    // 添加频道视图
    XGChannelView *channel = [XGChannelView loadChannelView];
    [self.view addSubview:channel];
    [channel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(navBar.mas_bottom);
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

    // 判断是否是当前选中的控制器，如果是就直接返回
    NSInteger idx = chaView.selectedIndex;
    if (_currentListV.channelIndex == idx) {
        NSLog(@"哈哈哈哈哈");
        return;
    }
    
    // 设置选中标签的显示比例
    [_channelView channelLabelWithIndex:idx scale:1.0];
    
    // 设置之前标签的显示比例
    [_channelView channelLabelWithIndex:_currentListV.channelIndex scale:0.0];
    
    // 设置列表控制器的内容
    XGNewsListController *lVC = [[XGNewsListController alloc] initWithChannelID:_channelList[idx].tid channelIndex:idx];
    
    // 设置分页控制器的视图
        // 选中的上一个频道的标签
    NSInteger direction = UIPageViewControllerNavigationDirectionForward;
    if (idx < _currentListV.channelIndex) {
        direction = UIPageViewControllerNavigationDirectionReverse;
    }
    [_pageViewController setViewControllers:@[lVC] direction:direction animated:YES completion:nil];
    
    // 记录当前的控制器
    _currentListV = lVC;
}

#pragma mark - 设置分页控制器
- (void)setupPageController {
    // 1、实例化控制器
    UIPageViewController *pageVC = [[UIPageViewController alloc] initWithTransitionStyle:UIPageViewControllerTransitionStyleScroll navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal options:nil];
    
    // 2、设置分页控制器的<子控制器 - 新闻列表控制器>
    XGNewsListController *listVC = [[XGNewsListController alloc] initWithChannelID:_channelList[0].tid channelIndex:0];
    // 记录当前的列表控制器
    _currentListV = listVC;
    
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
