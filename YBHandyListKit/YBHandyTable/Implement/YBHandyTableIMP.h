//
//  YBHandyTableIMP.h
//  YBHandyList
//
//  Created by 迎博 on 2019/6/18.
//  Copyright © 2019 迎博. All rights reserved.
//

#import "YBHTableSection.h"
#import "YBHTCommonInfo.h"
#import "YBHandyAction.h"

NS_ASSUME_NONNULL_BEGIN

/**
 代理实现类，可以直接抽出来作为 UITableView 的 delegate 和 dataSource，若想实现更多的代理方法，继承于该类在子类中拓展就行了。
 */
@interface YBHandyTableIMP : NSObject <UITableViewDataSource, UITableViewDelegate>

/** 数据源 */
@property (nonatomic, strong) NSMutableArray<YBHTableSection *> *sectionArray;

/** 公共信息对象，将会下发到 Cell/Header/Footer */
@property (nonatomic, strong) YBHTCommonInfo *commonInfo;

/**处理转发delegate事件*/
@property (nonatomic, strong, readonly) YBHandyAction *handyAction;

@end

NS_ASSUME_NONNULL_END
