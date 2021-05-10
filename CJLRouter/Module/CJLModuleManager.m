//
//  CJLModuleManager.m
//  CJLRouter
//
//  Created by lele8446 on 2018/10/22.
//  Copyright © 2018 lele8446. All rights reserved.
//

#import "CJLModuleManager.h"
#import "NSObject+CJLRouter.h"

@interface CJLModuleManager ()
/** 记录已注册的组件模块 */
@property (nonatomic, strong) NSMutableDictionary *moduleDict;
@end
@implementation CJLModuleManager

+ (_Nonnull instancetype)manager {
    static CJLModuleManager *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[self alloc] init];
        instance.moduleDict = [NSMutableDictionary dictionary];
    });
    return instance;
}

+ (void)registerModuleClass:(Class<CJLModuleProtocol>)moduleClass {
    if (moduleClass) {
        NSMutableDictionary *moduleDict = [[self manager] moduleDict];
        NSString *name = NSStringFromClass(moduleClass);
        NSAssert(![moduleDict objectForKey:name], @"CJLRouter 当前module %@ 已注册，请检查！！",name);
        [moduleDict setObject:moduleClass forKey:name];
    }
}

+ (void)setupAllModules {
    NSArray *modules = [self allModuleClasses];
    for (Class moduleClass in modules) {
        [[moduleClass sharedInstance] setup];
    }
}

+ (NSArray *)allModuleClasses {
    return [[[self manager] moduleDict] allValues];
}

+ (void)checkAllModulesWithSelector:(SEL)selector arguments:(NSArray*)arguments {
    for (Class<CJLModuleProtocol> class in [self allModuleClasses]) {
        id<CJLModuleProtocol> module = [class sharedInstance];
        if ([module respondsToSelector:selector]) {
            [NSObject cjl_performTarget:module selector:selector withObjects:arguments];
        }
    }
}

@end
