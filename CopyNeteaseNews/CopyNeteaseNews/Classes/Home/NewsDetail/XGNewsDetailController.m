//
//  XGNewsDetailController.m
//  CopyNeteaseNews
//
//  Created by 小果 on 2017/2/8.
//  Copyright © 2017年 小果. All rights reserved.
//

#import "XGNewsDetailController.h"
#import "XGNewsListItem.h"
@interface XGNewsDetailController ()
@property (nonatomic, strong) UIWebView *webView;
@end

@implementation XGNewsDetailController

- (void)loadView {
    _webView = [UIWebView new];
    self.view = _webView;
    
    // 创建 NavBar
    UINavigationBar *navBar = [[UINavigationBar alloc] init];
    [self.view addSubview:navBar];
    [navBar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(self.view);
        // 高度是 64 包含了状态栏的高度
        make.height.mas_equalTo(64);
    }];
    // 设置标题
    UINavigationItem *item  = [[UINavigationItem alloc] initWithTitle:@"详情"];
    navBar.items = @[item];
    // 设置返回按钮
    item.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:self action:@selector(back)];
    
    // 设置 contentInset
    _webView.scrollView.contentInset = UIEdgeInsetsMake(44, 0, 0, 0);
}

#pragma mark - 返回按钮的方法
- (void)back {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self loadData];
}

- (void)loadData {
    [[XGNetworkManager shareManager] newsDetailWithDocid:_detailItem.docid completion:^(NSDictionary *dict, NSError *error) {
        
        NSString *body = dict[@"body"];
        NSArray *img = dict[@"img"];
        NSArray *video = dict[@"video"];
        
        // 循环遍历 img 的数组，查找 body 中 ref 的位置，如果找到使用 src 替换对应的图片内容
        for (NSDictionary *dict in img) {
            // 取出 ref 的内容
            NSString *ref = dict[@"ref"];
            // 在body中查找出 ref 的位置
            NSRange range = [body rangeOfString:ref];
            // 判断是否找到
            if (range.location == NSNotFound) {
                continue;
            }
            // 替换 body 中range 对应的内容
            NSString *imgStr = [NSString stringWithFormat:@"<img src=\"%@\" />",dict[@"src"]];
            body = [body stringByReplacingCharactersInRange:range withString:imgStr];
        }
        
        // 循环遍历 video 数组
        for (NSDictionary *dict in video) {
            // 取出 ref 的内容
            NSString *ref = dict[@"ref"];
            // 在body中查找出 ref 的位置
            NSRange range = [body rangeOfString:ref];
            // 判断是否找到
            if (range.location == NSNotFound) {
                continue;
            }
            // 替换 body 中 rang 对应的位置
            NSString *videoStr = [NSString stringWithFormat:@"<video src=\"%@\" />",dict[@"mp4_url"]];
            body = [body stringByReplacingCharactersInRange:range withString:videoStr];
        }
        // 将 css 字符串拼接在 body 的前面
        body = [[self cssString] stringByAppendingString:body];
        
        [self.webView loadHTMLString:body baseURL:nil];
    }];
}

- (NSString *)cssString {
    NSString *path = [[NSBundle mainBundle] pathForResource:@"news.css" ofType:nil];
    
    return [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:NULL];
}

@end
