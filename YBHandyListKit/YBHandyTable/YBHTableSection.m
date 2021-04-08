//
//  YBHTableSection.m
//  YBHandyListDemo
//
//  Created by 迎博 on 2019/6/18.
//  Copyright © 2019 迎博. All rights reserved.
//

#import "YBHTableSection.h"

@interface YBHTableSection ()
@property (nonatomic, strong) NSMutableArray<id<YBHTableCellConfig>> *rowArray;
@end

@implementation YBHTableSection

- (NSMutableArray<id<YBHTableCellConfig>> *)rowArray {
    if (!_rowArray) {
        _rowArray = [NSMutableArray array];
    }
    return _rowArray;
}

@end
