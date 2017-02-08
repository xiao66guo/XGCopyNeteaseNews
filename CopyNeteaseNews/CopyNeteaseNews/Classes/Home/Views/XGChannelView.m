//
//  XGChannelView.m
//  CopyNeteaseNews
//
//  Created by 小果 on 2017/2/8.
//  Copyright © 2017年 小果. All rights reserved.
//

#import "XGChannelView.h"
#import "XGChannel.h"
#import "XGChannelLabel.h"

@interface XGChannelView ()
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@end

@implementation XGChannelView

+ (instancetype)loadChannelView {
    
    UINib *nib = [UINib nibWithNibName:@"XGChannelView" bundle:nil];
    
    return [nib instantiateWithOwner:nil options:nil].lastObject;
}

- (void)setChannelList:(NSArray<XGChannel *> *)channelList {
    _channelList = channelList;
    
    // 初始化 lab 的数据
    CGFloat x = 20;
    CGFloat margin = 8;
    CGFloat height = _scrollView.bounds.size.height;
    
    // 向 scrollView 中添加频道的控件
    for (XGChannel *channel in channelList) {
        // 频道标签
        XGChannelLabel *channelLab = [XGChannelLabel channelLabelWithTitle:channel.tname];
        
        // 设置label的位置
        channelLab.frame = CGRectMake(x, 0, channelLab.bounds.size.width, height);
        // 用递增的方法设置其他label的位置
        x += channelLab.bounds.size.width + margin;
        
        [_scrollView addSubview:channelLab];
        
        // 设置 scrollView 滚动的条件
        _scrollView.contentSize = CGSizeMake(x, height);
        _scrollView.showsVerticalScrollIndicator = NO;
        _scrollView.showsHorizontalScrollIndicator = NO;
    }
}
@end
