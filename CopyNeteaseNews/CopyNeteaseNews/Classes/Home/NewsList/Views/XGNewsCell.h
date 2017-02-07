//
//  XGNewsCell.h
//  CopyNeteaseNews
//
//  Created by 小果 on 2017/2/8.
//  Copyright © 2017年 小果. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XGNewsCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *iconView;
@property (weak, nonatomic) IBOutlet UILabel *titleLab;

@property (weak, nonatomic) IBOutlet UILabel *sourceLab;
@property (weak, nonatomic) IBOutlet UILabel *replyLab;

@property (strong, nonatomic) IBOutletCollection(UIImageView) NSArray *extraIcon;

@end
