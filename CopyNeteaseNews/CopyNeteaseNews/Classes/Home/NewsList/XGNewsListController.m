//
//  XGNewsListController.m
//  CopyNeteaseNews
//
//  Created by 小果 on 2017/2/7.
//  Copyright © 2017年 小果. All rights reserved.
//

#import "XGNewsListController.h"
#import "XGNewsListItem.h"
#import "XGNewsNormalCell.h"
#import <UIImageView+WebCache.h>

static NSString *cellID = @"listCell";

@interface XGNewsListController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, weak) UITableView *tableView;

/**
 * 新闻列表数组
 */
@property (nonatomic, strong) NSMutableArray <XGNewsListItem *> *newsList;
@end

@implementation XGNewsListController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    [self setupUI];
    [self loadData];
}

#pragma mark - 加载数据
- (void)loadData {
    [[XGNetworkManager shareManager] newsListWithChannel:@"T1348649079062" start:0 completion:^(NSArray *array, NSError *error) {
        NSLog(@"%@", array);
        
        // 字典转模型
        NSArray *list = [NSArray yy_modelArrayWithClass:[XGNewsListItem class] json:array];
        
        // 设置新闻数组
        self.newsList = [NSMutableArray arrayWithArray:list];
        
        // 刷新表格
        [self.tableView reloadData];
    }];
}

#pragma mark - 设置界面
- (void)setupUI {
    UITableView *tab = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    
    [self.view addSubview:tab];
    
    [tab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    
    // 注册Cell
//    [tab registerClass:[UITableViewCell class] forCellReuseIdentifier:cellID];
    [tab registerNib:[UINib nibWithNibName:@"XGNewsNormalCell" bundle:nil] forCellReuseIdentifier:cellID];
    
    // 设置自动行高
    tab.estimatedRowHeight = 100;
    tab.rowHeight = UITableViewAutomaticDimension;
    
    tab.dataSource = self;
    tab.delegate = self;
    
    _tableView = tab;
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return _newsList.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    XGNewsNormalCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID forIndexPath:indexPath];
    
    // 取出模型并设置数据
    XGNewsListItem *model = _newsList[indexPath.row];
    
    cell.titleLab.text = model.title;
    cell.sourceLab.text = model.source;
    cell.replyLab.text = @(model.replyCount).description;
    
    NSURL *url = [NSURL URLWithString:model.imgsrc];
    [cell.iconView sd_setImageWithURL:url];
    
    return cell;
}

@end
