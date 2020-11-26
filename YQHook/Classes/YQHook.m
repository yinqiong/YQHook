//
//  YQHook.m
//  YQHook
//
//  Created by Midas on 2020/11/26.
//  Copyright © 2020 YinQiong. All rights reserved.
//

#import "YQHook.h"

@implementation YQHook

+ (void)hookClassObject:(id)clsObject fromSelector:(SEL)fromSelector toSelector:(SEL)toSelector {
    
    if (clsObject == nil) {
        return;
    }
    Class class = [clsObject class];
    // 得到被替换类的实例方法
    Method fromMethod = class_getInstanceMethod(class, fromSelector);
    // 得到被替换类的实例方法
    Method toMethod = class_getInstanceMethod(class, toSelector);
    
    [self exchangeMethodWithClass:class fromSelector:fromSelector fromMethod:fromMethod toSelector:toSelector toMethod:toMethod];
    
}

+ (void)hookClass:(Class)cls fromSelector:(SEL)fromSelector toSelector:(SEL)toSelector {
    
    Class class = cls;
    // 得到被替换类的实例方法
    Method fromMethod = class_getClassMethod(class, fromSelector);
    // 得到被替换类的实例方法
    Method toMethod = class_getClassMethod(class, toSelector);
    
    [self exchangeMethodWithClass:class fromSelector:fromSelector fromMethod:fromMethod toSelector:toSelector toMethod:toMethod];
}

/// 方法交换
/// @param cls 类
/// @param fromMethod 原方法
/// @param toMethod 交换方法
+ (void)exchangeMethodWithClass:(Class)cls fromSelector:(SEL)fromSelector fromMethod:(Method)fromMethod toSelector:(SEL)toSelector toMethod:(Method)toMethod {
    Class class = cls;
    // class_addMethod 返回成功表示被替换的方法没实现，
    // 然后会通过 class_addMethod方法先实现；返回失败
    // 则表示被替换方法已存在，可以直接进行 IMP 指针交换
    if (class_addMethod(class, fromSelector, method_getImplementation(toMethod), method_getTypeEncoding(toMethod))) {
        // 进行方法替换
        class_replaceMethod(class, toSelector, method_getImplementation(fromMethod), method_getTypeEncoding(fromMethod));
    } else {
        // 交换 IMP 指针
        method_exchangeImplementations(fromMethod, toMethod);
    }
}



@end
