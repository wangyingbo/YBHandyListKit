//
//  TestCollectionController.m
//  YBHandyTableViewDemo
//
//  Created by 迎博 on 2019/6/18.
//  Copyright © 2019 迎博. All rights reserved.
//

#import "TestCollectionController.h"
#import "TestCollectionModel.h"
#import "TestCollectionNibCell.h"
#import "YBHandyList.h"
#import <objc/runtime.h>

@interface TestCollectionController () <UIScrollViewDelegate,UICollectionViewDelegate,UICollectionViewDataSource>
@property (nonatomic, strong) UICollectionView *collectionView;
@end

@implementation TestCollectionController

#pragma mark - life cycle

- (void)dealloc {
    NSLog(@"释放：%@", self);
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"YBHandyCollection";
    [self.view addSubview:self.collectionView];
    
    [self loadData];
    
//    struct objc_method_description description;
//    description = protocol_getMethodDescription(@protocol(UICollectionViewDataSource), @selector(collectionView:canMoveItemAtIndexPath:), NO, YES);
//    BOOL result = (description.name != NULL && description.types != NULL);
}

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    self.collectionView.frame = self.view.bounds;
}

#pragma mark - private

- (void)loadData {
    
    // 🐶 用法和 UITableView 很像，这里就不过于具体了。
    
    // ① 模拟构建数据模型
    NSMutableArray *modelArray = [NSMutableArray array];
    for (int i = 0; i < 40; ++i) {
        TestCollectionModel *model = [TestCollectionModel new];
        model.text = [NSString stringWithFormat:@"第%d个", i];
        [modelArray addObject:model];
    }
    
    // ② 构建配置对象
    NSMutableArray *configArray = [NSMutableArray array];
    for (TestCollectionModel *model in modelArray) {
        YBHCollectionCellConfig *config = [YBHCollectionCellConfig new];
        config.model = model;
        config.cellClass = TestCollectionNibCell.self;
        [configArray addObject:config];
    }
    
    YBHCollectionHeaderFooterConfig *headerConfig = [YBHCollectionHeaderFooterConfig new];
    headerConfig.defaultSize = CGSizeMake(UIScreen.mainScreen.bounds.size.width, 44);
    headerConfig.headerFooterClass = UICollectionReusableView.self;
    
    // ③ 赋值并刷新
//    YBHCollectionSection *section = [YBHCollectionSection new];
//    section.minimumLineSpacing = 10;
//    section.minimumInteritemSpacing = 15;
//    section.inset = UIEdgeInsetsMake(10, 15, 15, 10);
//    section.header = headerConfig;
//    [section.rowArray addObjectsFromArray:configArray];
//    [self.collectionView.ybhc_sectionArray addObject:section];

    // ③ 3.1: 使用语法糖
    self.collectionView.ybhc_minimumLineSpacing = 10;
    self.collectionView.ybhc_minimumInteritemSpacing = 15;
    self.collectionView.ybhc_inset = UIEdgeInsetsMake(10, 15, 10, 15);
    self.collectionView.ybhc_header = headerConfig;
    [self.collectionView.ybhc_rowArray addObjectsFromArray:configArray];
    
    //可继承YBHandyCollectionIMP后，实例赋值ybhc_collectionIMP，来实现其余的delegate方法；也可以直接把想实现的代理方法在forward到当前类
    [self.collectionView forwardingTo:self];
    
    [self.collectionView reloadData];
}

#pragma mark - getter

- (UICollectionView *)collectionView {
    if (!_collectionView) {
        UICollectionViewFlowLayout *layout = UICollectionViewFlowLayout.new;
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        _collectionView.backgroundColor = UIColor.whiteColor;
        
//        layout.itemSize = CGSizeMake(60, 60);
//        layout.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
//        layout.minimumInteritemSpacing = 50;
//        layout.minimumLineSpacing = 50;
        //将该属性设置为 NO 来让 UICollectionViewFlowLayout 的布局属性有效。
//        _collectionView.ybhc_collectionIMP.enabledFlowLayoutProperties = YES;
    }
    return _collectionView;
}

#pragma mark - UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView willDisplayCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath {
    //NSLog(@"collectionView-响应了willDisplayCell");
}

#pragma mark - UICollectionViewDataSource

- (NSArray<NSString *> *)indexTitlesForCollectionView:(UICollectionView *)collectionView {
    NSLog(@"collectionView-响应了indexTitlesForCollectionView");
    return @[@"y"];
}

@end
