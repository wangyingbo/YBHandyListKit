//
//  WellKnownSayingThreeCellModel.h
//  YBHandyListDemo
//
//  Created by 迎博 on 2019/6/19.
//  Copyright © 2019 迎博. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YBHandyList.h"

NS_ASSUME_NONNULL_BEGIN

@interface WellKnownSayingThreeCellModel : NSObject <YBHTableCellConfig>

@property (nonatomic, copy) NSString *showName;

@property (nonatomic, copy) NSString *showComment;

@end

NS_ASSUME_NONNULL_END
