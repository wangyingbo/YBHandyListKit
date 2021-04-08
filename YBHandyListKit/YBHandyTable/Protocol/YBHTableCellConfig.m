//
//  YBHTableCellConfig.m
//  YBHandyListDemo
//
//  Created by 迎博 on 2019/6/18.
//  Copyright © 2019 迎博. All rights reserved.
//

#import "YBHTableCellConfig.h"

@implementation YBHTableCellConfig

#pragma mark - life cycle

- (instancetype)init {
    self = [super init];
    if (self) {
        _defaultHeight = -1;
    }
    return self;
}

#pragma mark - <YBHTableCellConfig>

- (Class<YBHTableCellProtocol>)ybht_cellClass {
    return self.cellClass;
}

- (id)ybht_model {
    return self.model;
}

- (CGFloat)ybht_defaultHeight {
    return self.defaultHeight;
}

- (NSString *)ybht_cellReuseIdentifier {
    return self.cellReuseIdentifier;
}

@end
