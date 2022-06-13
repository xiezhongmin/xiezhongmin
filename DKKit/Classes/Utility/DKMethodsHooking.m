//
//  DKMethodHooking.m
//  DKKit
//
//  Created by admin on 2022/6/9.
//

#import "DKMethodsHooking.h"
#import "DKKitMacro.h"

@implementation DKMethodsHooking

+ (SEL)swizzledSelectorForSelector:(SEL)selector
{
    return NSSelectorFromString([NSString stringWithFormat:@"_duke_swizzle_%x_%@", arc4random(), NSStringFromSelector(selector)]);
}

+ (SEL)swizzledConstantSelectorForSelector:(SEL)selector
{
    return NSSelectorFromString([NSString stringWithFormat:@"_duke_swizzle_%@", NSStringFromSelector(selector)]);
}

+ (BOOL)instanceRespondsButDoesNotImplementSelector:(SEL)selector
                                            onClass:(Class)cls
{
    if ([cls instancesRespondToSelector:selector]) {
        unsigned int numMethods = 0;
        Method *methods = class_copyMethodList(cls, &numMethods);
        
        BOOL implementsSelector = NO;
        for (int idx = 0; idx < numMethods; idx++) {
            SEL methodSelector = method_getName(methods[idx]);
            if (selector == methodSelector) {
                implementsSelector = YES;
                break;
            }
        }
        
        free(methods);
        
        if (!implementsSelector) {
            return YES;
        }
    }
    
    return NO;
}

+ (void)replaceImplementationOfKnownSelector:(SEL)originalSelector onClass:(Class)cls withBlock:(id)block swizzledSelector:(SEL)swizzledSelector
{
    // This method is only intended for swizzling methods that are know to exist on the class.
    // Bail if that isn't the case.
    Method originalMethod = class_getInstanceMethod(cls, originalSelector);
    if (!originalMethod) {
        return;
    }
    
    IMP implementation = imp_implementationWithBlock(block);
    BOOL ret = class_addMethod(cls, swizzledSelector, implementation, method_getTypeEncoding(originalMethod));
    if (!ret) {
        DKLogError(@"class_addMethod failed, %@:%@ -> %@", NSStringFromClass(cls), NSStringFromSelector(originalSelector), NSStringFromSelector(swizzledSelector));
    }
    
    Method newMethod = class_getInstanceMethod(cls, swizzledSelector);
    method_exchangeImplementations(originalMethod, newMethod);
}

+ (void)replaceImplementationOfSelector:(SEL)originalSelector
                           withSelector:(SEL)swizzledSelector
                               forClass:(Class)cls
                  withMethodDescription:(struct objc_method_description)methodDescription
                    implementationBlock:(id)implementationBlock
                         undefinedBlock:(id)undefinedBlock
{
    if ([self instanceRespondsButDoesNotImplementSelector:originalSelector onClass:cls]) {
        return;
    }

    IMP implementation = imp_implementationWithBlock((id)([cls instancesRespondToSelector:originalSelector] ? implementationBlock : undefinedBlock));

    Method oldMethod = class_getInstanceMethod(cls, originalSelector);
    const char *types = methodDescription.types;
    if (oldMethod) {
        if (!types) {
            types = method_getTypeEncoding(oldMethod);
        }
        
        class_addMethod(cls, swizzledSelector, implementation, methodDescription.types);
        Method newMethod = class_getInstanceMethod(cls, swizzledSelector);
        method_exchangeImplementations(oldMethod, newMethod);
    } else {
        if (!types) {
            // Some protocol method descriptions don't have .types populated
            // Set the return type to void and ignore arguments
            types = "v@:";
        }
        class_addMethod(cls, originalSelector, implementation, methodDescription.types);
    }
}

@end
