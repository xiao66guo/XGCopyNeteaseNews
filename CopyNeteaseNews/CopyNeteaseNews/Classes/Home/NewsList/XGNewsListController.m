//
//  XGNewsListController.m
//  CopyNeteaseNews
//
//  Created by 小果 on 2017/2/7.
//  Copyright © 2017年 小果. All rights reserved.
//

#import "XGNewsListController.h"
#import "XGNetworkManager.h"
static NSString *cellID = @"listCell";
@interface XGNewsListController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, weak) UITableView *tableView;
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
    [tab registerClass:[UITableViewCell class] forCellReuseIdentifier:cellID];
    
    tab.dataSource = self;
    tab.delegate = self;
    
    _tableView = tab;
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 20;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID forIndexPath:indexPath];
    
    cell.textLabel.text = @(indexPath.row).description;
    
    return cell;
}

@end
