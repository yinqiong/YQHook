//
//  YQHook.h
//  YQHook
//
//  Created by Midas on 2020/11/26.
//  Copyright © 2020 YinQiong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <objc/runtime.h>

NS_ASSUME_NONNULL_BEGIN

@interface YQHook : NSObject

/// 实例方法 hook
/// @param clsObject 类实例
/// @param fromSelector 原方法
/// @param toSelector 交换的方法
+ (void)hookClassObject:(id)clsObject fromSelector:(SEL)fromSelector toSelector:(SEL)toSelector;

/// 类方法 hook
/// @param cls 类
/// @param fromSelector 原方法
/// @param toSelector 交换的方法
+ (void)hookClass:(Class)cls fromSelector:(SEL)fromSelector toSelector:(SEL)toSelector;


@end

NS_ASSUME_NONNULL_END
