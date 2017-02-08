//
//  XGNewsListController.m
//  CopyNeteaseNews
//
//  Created by 小果 on 2017/2/7.
//  Copyright © 2017年 小果. All rights reserved.
//

#import "XGNewsListController.h"
#import "XGNewsListItem.h"
#import "XGNewsCell.h"
#import <UIImageView+WebCache.h>

// 选中新闻列表通知
NSString *const XGNewsListSelectedDocidNotification = @"XGNewsListSelectedDocidNotification";

static NSString *normalCellID = @"normalListCell";
static NSString *extraCellID = @"extraListCell";
static NSString *bigImageCellID = @"bigImageListCell";
static NSString *headerCellID = @"headerListCell";

@interface XGNewsListController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, weak) UITableView *tableView;

/**
 * 新闻列表数组
 */
@property (nonatomic, strong) NSMutableArray <XGNewsListItem *> *newsList;
@end

@implementation XGNewsListController

- (instancetype)initWithChannelID:(NSString *)channelID channelIndex:(NSInteger)index {
    if (self = [super initWithNibName:nil bundle:nil]) {
        _channelID = channelID;
        _channelIndex = index;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
   
    [self setupUI];
    [self loadData];
}

#pragma mark - 加载数据
- (void)loadData {
    // 体育频道：T1348649079062
    // 首页频道：T1348647853363
    // 娱乐频道：T1348648517839
    // 历史频道：T1368497029546
    [[XGNetworkManager shareManager] newsListWithChannel:_channelID start:0 completion:^(NSArray *array, NSError *error) {
//        NSLog(@"%@", array);
        
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
    [tab registerNib:[UINib nibWithNibName:@"XGNewsNormalCell" bundle:nil] forCellReuseIdentifier:normalCellID];
    [tab registerNib:[UINib nibWithNibName:@"XGNewsExtraCell" bundle:nil] forCellReuseIdentifier:extraCellID];
    [tab registerNib:[UINib nibWithNibName:@"XGNewsBigImageCell" bundle:nil] forCellReuseIdentifier:bigImageCellID];
    [tab registerNib:[UINib nibWithNibName:@"XGNewsHeaderCell" bundle:nil] forCellReuseIdentifier:headerCellID];
    
    // 设置表格的 contentInset
    tab.contentInset = UIEdgeInsetsMake(0, 0, 49, 0);

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
    
    // 根据模型来判断 CellID
    XGNewsListItem *model = _newsList[indexPath.row];
  
    NSString *cellID;
    if (model.hasHead) {
        cellID = headerCellID;
    } else if (model.imgType) {
        cellID = bigImageCellID;
    } else if (model.imgextra.count > 0) {
        cellID = extraCellID;
    } else {
        cellID = normalCellID;
    }
    
    XGNewsCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID forIndexPath:indexPath];
    // 设置数据
    cell.newsItem = model;
    
    return cell;
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    XGNewsListItem *model = _newsList[indexPath.row];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:XGNewsListSelectedDocidNotification object:model];
    
}
@end
