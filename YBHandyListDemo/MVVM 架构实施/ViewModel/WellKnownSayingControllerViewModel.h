//
//  WellKnownSayingControllerViewModel.h
//  YBHandyListDemo
//
//  Created by 迎博 on 2019/6/19.
//  Copyright © 2019 迎博. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WellKnownSayingModel.h"
#import "WellKnownSayingOneCellModel.h"
#import "WellKnownSayingTwoCellModel.h"
#import "WellKnownSayingThreeCellModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface WellKnownSayingControllerViewModel : NSObject

/// 开始网络请求
- (void)startRequestWithSuccess:(void(^)(NSArray<WellKnownSayingModel *> *modelArray))success;

@end

NS_ASSUME_NONNULL_END
