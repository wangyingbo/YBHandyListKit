//
//  YBHandyAction.m
//  YBHandyListDemo
//
//  Created by yingbo5 on 2021/3/30.
//  Copyright © 2021 迎博. All rights reserved.
//

#import "YBHandyAction.h"
#import <objc/runtime.h>
#import "YBHandyAction+Private.h"


@interface YBHandyAction ()
@property (nonatomic, strong) NSMutableSet *forwardDelegates;
//@property (nonatomic, strong) Protocol *actionProtocol;
@property (nonatomic, copy) NSArray<Protocol *> *protocols;
@end

@implementation YBHandyAction

- (instancetype)initWithProtocol:(Protocol *)protocol {
    if (self = [super init]) {
        _protocols = @[protocol];
    }
    return self;
}

- (instancetype)initWithProtocols:(NSArray<Protocol *> *)protocols {
    if (self = [super init]) {
        _protocols = protocols;
    }
    return self;
}

- (void)forwardingTo:(id)forwardDelegate {
    [self.forwardDelegates addObject:forwardDelegate];
}

- (void)removeForwarding:(id)forwardDelegate {
    [self.forwardDelegates removeObject:forwardDelegate];
}

- (BOOL)canForwarding {
    return self.protocols.count;
}

- (void)_enumerateDelegateExcuteSelector:(SEL)selector usingBlock:(void (^)(id _Nonnull))block {
    for (id delegate in self.forwardDelegates) {
        if ([delegate respondsToSelector:[self _removeUnderlineFromSelector:selector]]) {
            !block?:block(delegate);
        }
    }
}

#pragma mark - Forward Invocations

static inline bool selectorHasUnderline(SEL selector) {
    NSString *privateSel = NSStringFromSelector(selector);
    if ([privateSel hasPrefix:@"_"]) {
        return true;
    }
    return false;
}

- (SEL)_removeUnderlineFromSelector:(SEL)selector {
    SEL aSel = selector;
    if (selectorHasUnderline(selector)) {
        NSString *privateSel = NSStringFromSelector(selector);
        privateSel = [privateSel substringFromIndex:1];
        aSel = NSSelectorFromString(privateSel);
    }
    return aSel;
}

- (BOOL)_shouldForwardSelector:(SEL)selector {
    SEL aSel = [self _removeUnderlineFromSelector:selector];
    for (Protocol *p in self.protocols) {
        struct objc_method_description description;
        description = protocol_getMethodDescription(p, aSel, NO, YES);
        BOOL result = (description.name != NULL && description.types != NULL);
        if (result) {
            return result;
            break;
        }
    }
    return NO;
}

- (BOOL)respondsToSelector:(SEL)selector {
    if ([super respondsToSelector:selector]) {
        return YES;
    } else if ([self _shouldForwardSelector:selector]) {
        for (id delegate in self.forwardDelegates) {
            if ([delegate respondsToSelector:[self _removeUnderlineFromSelector:selector]]) {
                return YES;
            }
        }
    }
    return NO;
}

- (NSMethodSignature *)methodSignatureForSelector:(SEL)selector {
    SEL aSel = selector;
    NSMethodSignature *signature = [super methodSignatureForSelector:aSel];
    if (signature == nil) {
        for (id delegate in self.forwardDelegates) {
            if ([delegate respondsToSelector:aSel]) {
                signature = [delegate methodSignatureForSelector:aSel];
            }
        }
    }
    return signature;
}

- (void)forwardInvocation:(NSInvocation *)invocation {
    BOOL didForward = NO;
    
    if ([self _shouldForwardSelector:invocation.selector]) {
        for (id delegate in self.forwardDelegates) {
            if ([delegate respondsToSelector:invocation.selector]) {
                [invocation invokeWithTarget:delegate];
                didForward = YES;
                break;
            }
        }
    }
    
    if (!didForward) {
        [super forwardInvocation:invocation];
    }
}

#pragma mark - setter && getter
- (NSMutableSet *)forwardDelegates {
    if (!_forwardDelegates) {
        _forwardDelegates = ActionCreateNonRetainingMutableSet();
    }
    return _forwardDelegates;
}

FOUNDATION_STATIC_INLINE NSMutableSet* ActionCreateNonRetainingMutableSet(void) {
  return (__bridge_transfer NSMutableSet *)CFSetCreateMutable(nil, 0, nil);
}

@end
