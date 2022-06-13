//
//  DKMethodHooking.h
//  DKKit
//
//  Created by admin on 2022/6/9.
//

#import <Foundation/Foundation.h>
#import <objc/message.h>
#import <objc/runtime.h>

@interface DKMethodsHooking : NSObject

/// 生成的方法名每次都不一样, 包含随机数
/// @param selector selector description
+ (SEL)swizzledSelectorForSelector:(SEL)selector;

/// 生成的 selector 每次都一样, 不包含随机数
/// @param selector selector description
+ (SEL)swizzledConstantSelectorForSelector:(SEL)selector;

/// class 是否只能响应 selector, 但是没有实现
/// @param selector selector description
/// @param cls class
+ (BOOL)instanceRespondsButDoesNotImplementSelector:(SEL)selector
                                            onClass:(Class)cls;

/// 使用 block 交换方法实现
/// @param originalSelector 原方法
/// @param cls class
/// @param block block description
/// @param swizzledSelector 新方法
+ (void)replaceImplementationOfKnownSelector:(SEL)originalSelector
                                     onClass:(Class)cls
                                   withBlock:(id)block
                            swizzledSelector:(SEL)swizzledSelector;

/// 使用 block 交换方法实现 (可自定义 methodDescription, 如果方法没有实现, 使用 undefinedBlock)
/// @param originalSelector 原方法
/// @param swizzledSelector 新方法
/// @param cls class
/// @param methodDescription methodDescription description
/// @param implementationBlock implementationBlock description
/// @param undefinedBlock undefinedBlock description
+ (void)replaceImplementationOfSelector:(SEL)originalSelector
                           withSelector:(SEL)swizzledSelector
                               forClass:(Class)cls
                  withMethodDescription:(struct objc_method_description)methodDescription
                    implementationBlock:(id)implementationBlock
                         undefinedBlock:(id)undefinedBlock;

@end

