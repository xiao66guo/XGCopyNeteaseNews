//
//  XGNewsCell.m
//  CopyNeteaseNews
//
//  Created by 小果 on 2017/2/8.
//  Copyright © 2017年 小果. All rights reserved.
//

#import "XGNewsCell.h"
#import "XGNewsListItem.h"
#import <UIImageView+WebCache.h>
@interface XGNewsCell ()

@property (weak, nonatomic) IBOutlet UIImageView *iconView;

@property (weak, nonatomic) IBOutlet UILabel *titleLab;

@property (weak, nonatomic) IBOutlet UILabel *sourceLab;

@property (weak, nonatomic) IBOutlet UILabel *replyLab;

@property (strong, nonatomic) IBOutletCollection(UIImageView) NSArray *extraIcon;

@end
@implementation XGNewsCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setNewsItem:(XGNewsListItem *)newsItem {
    _newsItem = newsItem;
    
    // 设置数据
    _titleLab.text = newsItem.title;
    _sourceLab.text = newsItem.source;
    _replyLab.text = @(newsItem.replyCount).description;
    
    NSURL *url = [NSURL URLWithString:newsItem.imgsrc];
    [_iconView sd_setImageWithURL:url];
    
    // 设置多图cell（如果不是多图就不会进入这个循环）
    NSInteger idnx = 0;
    for (NSDictionary *dict in newsItem.imgextra) {
        // 获取 URL 的字符串
        NSURL *url = [NSURL URLWithString:dict[@"imgsrc"]];
        
        [_extraIcon[idnx++] sd_setImageWithURL:url];
    }

    
}

@end
