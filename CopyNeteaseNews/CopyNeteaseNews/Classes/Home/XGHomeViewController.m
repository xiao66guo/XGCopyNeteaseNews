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

@interface XGHomeViewController ()

@end

@implementation XGHomeViewController{
    NSArray <XGChannel *>* _channelList;
}

- (void)viewDidLoad {
    [super viewDidLoad];
   
    [self setupUI];
    
    _channelList = [XGChannel channelList];
    NSLog(@"%@",_channelList);
    
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
    
}

@end
