//
//  XGNewsCell.h
//  CopyNeteaseNews
//
//  Created by 小果 on 2017/2/8.
//  Copyright © 2017年 小果. All rights reserved.
//

#import <UIKit/UIKit.h>
@class  XGNewsListItem;
@interface XGNewsCell : UITableViewCell

/**
 *  新闻模型
 */
@property (nonatomic, strong) XGNewsListItem *newsItem;

@end
