//
//  YBHCollectionHeaderFooterConfig.m
//  YBHandyListDemo
//
//  Created by 迎博 on 2019/6/18.
//  Copyright © 2019 迎博. All rights reserved.
//

#import "YBHCollectionHeaderFooterConfig.h"

@implementation YBHCollectionHeaderFooterConfig

#pragma mark - <YBHCollectionHeaderFooterConfig>

- (Class<YBHCollectionHeaderFooterProtocol>)ybhc_headerFooterClass {
    return self.headerFooterClass;
}

- (id)ybhc_model {
    return self.model;
}

- (CGSize)ybhc_defaultSize {
    return self.defaultSize;
}

- (NSString *)ybhc_headerFooterReuseIdentifier {
    return self.headerFooterReuseIdentifier;
}

@end
