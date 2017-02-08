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
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    NSLog(@"接收到的模型：%@",_detailItem);
    [self loadData];
}

- (void)loadData {
    [[XGNetworkManager shareManager] newsDetailWithDocid:_detailItem.docid completion:^(NSDictionary *dict, NSError *error) {
        NSLog(@"%@",dict);
    }];
}
@end
