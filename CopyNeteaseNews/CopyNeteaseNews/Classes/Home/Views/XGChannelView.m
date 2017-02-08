//
//  XGChannelView.m
//  CopyNeteaseNews
//
//  Created by 小果 on 2017/2/8.
//  Copyright © 2017年 小果. All rights reserved.
//

#import "XGChannelView.h"

@interface XGChannelView ()
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@end

@implementation XGChannelView

+ (instancetype)loadChannelView {
    
    UINib *nib = [UINib nibWithNibName:@"XGChannelView" bundle:nil];
    
    return [nib instantiateWithOwner:nil options:nil].lastObject;
}


@end
