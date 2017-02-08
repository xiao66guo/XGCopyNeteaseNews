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
    
    // 向 scrollView 中添加频道的控件
    for (XGChannel *channel in channelList) {
        // 频道标签
        XGChannelLabel *channelLab = [XGChannelLabel channelLabelWithTitle:channel.tname];
        
        [_scrollView addSubview:channelLab];
    }
}
@end
