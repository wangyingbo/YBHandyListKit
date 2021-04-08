//
//  YBHandyAction+Private.h
//  YBHandyListDemo
//
//  Created by yingbo5 on 2021/3/31.
//  Copyright © 2021 迎博. All rights reserved.
//

#import "YBHandyAction.h"

NS_ASSUME_NONNULL_BEGIN

#ifndef SafePerformSelectorLeakWarning
#define SafePerformSelectorLeakWarning(Stuff) \
    do { \
        _Pragma("clang diagnostic push") \
        _Pragma("clang diagnostic ignored \"-Warc-performSelector-leaks\"") \
        Stuff; \
        _Pragma("clang diagnostic pop") \
    } while (0)
#endif

@interface YBHandyAction ()
- (SEL)_removeUnderlineFromSelector:(SEL)selector;
- (BOOL)_shouldForwardSelector:(SEL)selector;
- (void)_enumerateDelegateExcuteSelector:(SEL)selector usingBlock:(void(^)(id delegate))block;
@end

NS_ASSUME_NONNULL_END
