//
//  NSObject+EasyKVO.m
//  MyComponents
//
//  Created by charls on 2017/6/29.
//  Copyright © 2017年 CharlsPrince. All rights reserved.
//

#import "NSObject+EasyKVO.h"
#import <objc/runtime.h>

static const char easy_observers_key;

const NSString * easy_objectKey = @"easy_object";
const NSString * easy_keyPathKey = @"easy_keyPath";
const NSString * easy_BlockKey = @"easy_block";

#define easy_OldKey  @"old"
#define easy_NewKey  @"new"

@interface NSObject ()

@property (nonatomic, strong) NSMutableArray *easy_Observers;

@end

@implementation NSObject (EasyKVO)

- (void)setEasy_Observers:(NSMutableArray *)easy_Observers {
    objc_setAssociatedObject(self, &easy_observers_key, easy_Observers, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSMutableArray *)easy_Observers {
    NSMutableArray *observers = objc_getAssociatedObject(self, &easy_observers_key);
    if (!observers) {
        observers = [NSMutableArray array];
        [self setEasy_Observers:observers];
    }
    return observers;
}

- (void)easy_addObserver:(NSObject *)object forKeyPath:(NSString *)keyPath easyBlock:(EasyBlock)block {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Method method1 = class_getInstanceMethod([self class], NSSelectorFromString(@"dealloc"));
        Method method2 = class_getInstanceMethod([self class], @selector(easy_dealloc));
        method_exchangeImplementations(method1, method2);
    });
    NSDictionary *observer = @{easy_objectKey: object, easy_keyPathKey: keyPath, easy_BlockKey: block};
    [self.easy_Observers addObject:observer];
    NSString *key = [NSString stringWithFormat:@"%lu", self.easy_Observers.count-1];
    [self addObserver:object forKeyPath:keyPath options:NSKeyValueObservingOptionOld | NSKeyValueObservingOptionNew context:(__bridge void * _Nullable)(key)];
}

- (void)easy_removeAllObservers {
    [self.easy_Observers enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [self easy_removeObserverForKeyPath:[obj objectForKey:easy_keyPathKey]];
    }];
}

- (void)easy_removeObserverForKeyPath:(NSString *)keyPath {
    if (!self.easy_Observers || self.easy_Observers.count == 0) return;
    [self.easy_Observers enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([[obj objectForKey:easy_keyPathKey] isEqualToString:keyPath]) {
            [self removeObserver:[obj objectForKey:easy_objectKey] forKeyPath:[obj objectForKey:easy_keyPathKey]];
            [self.easy_Observers removeObjectAtIndex:idx];
            [self easy_removeObserverForKeyPath:keyPath];
        }
    }];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    id oldValue = [change valueForKey:easy_OldKey];
    id newValue = [change valueForKey:easy_NewKey];
    NSObject *observed = object;
    NSString *key = (__bridge NSString *)(context);
    NSDictionary *observer = [observed.easy_Observers objectAtIndex:key.integerValue];
    EasyBlock block = [observer objectForKey:easy_BlockKey];
    if (block) {
        block(oldValue, newValue);
    }
}

- (void)easy_dealloc {
    [self easy_removeAllObservers];
    [self easy_dealloc];
}

@end
