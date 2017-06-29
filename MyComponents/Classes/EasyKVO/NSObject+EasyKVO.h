//
//  NSObject+EasyKVO.h
//  MyComponents
//
//  Created by charls on 2017/6/29.
//  Copyright © 2017年 CharlsPrince. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/// 监听回调block
typedef void (^EasyBlock) (id oldValue, id newValue);

@interface NSObject (EasyKVO)

- (void)easy_addObserver:(NSObject * _Nonnull)object forKeyPath:(NSString * _Nonnull)keyPath easyBlock:(nullable EasyBlock)block;
- (void)easy_removeAllObservers;
- (void)easy_removeObserverForKeyPath:(nullable NSString *)keyPath;

@end

NS_ASSUME_NONNULL_END
