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
        
        NSString *body = dict[@"body"];
        NSArray *img = dict[@"img"];
        NSArray *video = dict[@"video"];
        
        NSLog(@"=====%@",body);
        NSLog(@"%@",img);NSLog(@"******%@",video);
        
        // 追加图片数据
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
        
        [self.webView loadHTMLString:body baseURL:nil];
    }];
}
@end
