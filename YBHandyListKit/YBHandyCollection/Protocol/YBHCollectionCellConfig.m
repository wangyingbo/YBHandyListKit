//
//  YBHCollectionCellConfig.m
//  YBHandyListDemo
//
//  Created by 迎博 on 2019/6/18.
//  Copyright © 2019 迎博. All rights reserved.
//

#import "YBHCollectionCellConfig.h"

@implementation YBHCollectionCellConfig

#pragma mark - <YBHCollectionCellConfig>

- (Class<YBHCollectionCellProtocol>)ybhc_cellClass {
    return self.cellClass;
}

- (id)ybhc_model {
    return self.model;
}

- (CGSize)ybhc_defaultSize {
    return self.defaultSize;
}

- (NSString *)ybhc_cellReuseIdentifier {
    return self.cellReuseIdentifier;
}

@end
