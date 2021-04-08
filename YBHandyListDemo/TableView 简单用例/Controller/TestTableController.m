//
//  TestTableController.m
//  YBHandyTableViewDemo
//
//  Created by 迎博 on 2019/4/11.
//  Copyright © 2019 迎博. All rights reserved.
//

#import "TestTableController.h"
#import "TestTableModel.h"
#import "TestTableCell.h"
#import "TestTableNibCell.h"
#import "TestTableNibCellConfig.h"
#import "TestTableNibHeader.h"
#import "YBHandyList.h"

@interface TestTableController () <TestTableNibCellDelegate,UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@end

@implementation TestTableController

#pragma mark - life cycle

- (void)dealloc {
    NSLog(@"释放：%@", self);
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"YBHandyTable";
    [self.view addSubview:self.tableView];
    [self loadData];
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    self.tableView.frame = self.view.bounds;
}

#pragma mark - private

- (void)loadData {
    
    // ① 模拟构建数据模型
    NSMutableArray *modelArray = [NSMutableArray array];
    for (int i = 0; i < 40; ++i) {
        TestTableModel *model = [TestTableModel new];
        model.text = [NSString stringWithFormat:@"第%d个", i];
        [modelArray addObject:model];
    }
    
    // ② 构建配置对象
    //使用默认实现的配置对象（能满足大部分需求）
    NSMutableArray *configArray = [NSMutableArray array];
    for (TestTableModel *model in modelArray) {
        YBHTableCellConfig *config = [YBHTableCellConfig new];
        config.model = model;
        config.cellClass = TestTableCell.self;
        [configArray addObject:config];
    }
    
    //使用自定义的配置对象（此处拓展一个代理用于 cell 事件传递到当前 UIViewController）
    TestTableNibCellConfig *customConfig = [TestTableNibCellConfig new];
    customConfig.cellClass = TestTableNibCell.self;
    customConfig.title = @"拓展的配置对象";
    customConfig.delegate = self;   //拓展的代理（当然也可以用闭包来传递）
    [configArray insertObject:customConfig atIndex:0];
    
    //添加一个高度 100 的 header
    YBHTableHeaderFooterConfig *headerConfig = [YBHTableHeaderFooterConfig new];
    headerConfig.defaultHeight = 100;
    headerConfig.headerFooterClass = TestTableNibHeader.self;
    
    // ③ 赋值并刷新
//    YBHTableSection *section = [YBHTableSection new];
//    section.header = headerConfig;
//    [section.rowArray addObjectsFromArray:configArray];
//    [self.tableView reloadDataWithSectionArray:@[section]];
    
    // ③ 3.1: 使用语法糖
    self.tableView.ybht_header = headerConfig;
    //[self.tableView.ybht_rowArray addObjectsFromArray:configArray];
    [self.tableView reloadDataWithRowArray:configArray.copy];
    
    //可继承YBHandyTableIMP创建子类后，新建实例赋值ybht_tableIMP，来实现其余的delegate方法；也可以直接把想实现的代理方法在forward到当前类
    [self.tableView forwardingTo:self];
    
    [self.tableView reloadData];
}

#pragma mark - <TestTableNibCellDelegate>

- (void)testTableNibCell:(TestTableNibCell *)cell clickSeeMoreButton:(UIButton *)button {
    NSLog(@"点击了 See More 按钮");
}

#pragma mark - getter

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.backgroundColor = [UIColor whiteColor];
        _tableView.tableFooterView = [UIView new];
        _tableView.estimatedRowHeight = 44;
        _tableView.estimatedSectionFooterHeight = 0;
        _tableView.estimatedSectionHeaderHeight = 0;
    }
    return _tableView;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"tableView-响应了willDisplayCell");
}

#pragma mark - UITableViewDataSource

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"tableView-响应了canEditRowAtIndexPath");
    return NO;
}


@end
