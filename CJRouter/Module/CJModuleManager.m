//
//  CJModuleManager.h
//  CJRouter
//
//  Created by lele8446 on 2018/10/22.
//  Copyright © 2018 lele8446. All rights reserved.
//

#import "CJModuleManager.h"
#import "NSObject+CJRouter.h"

@interface CJModuleManager ()
/** 记录已注册的组件模块 */
@property (nonatomic, strong) NSMutableDictionary *moduleDict;
@end
@implementation CJModuleManager

+ (_Nonnull instancetype)manager {
    static CJModuleManager *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[self alloc] init];
        instance.moduleDict = [NSMutableDictionary dictionary];
    });
    return instance;
}

+ (void)registerModuleClass:(Class<CJModuleProtocol>)moduleClass {
    if (moduleClass) {
        NSMutableDictionary *moduleDict = [[self manager] moduleDict];
        NSString *name = NSStringFromClass(moduleClass);
        NSAssert(![moduleDict objectForKey:name], @"CJRouter 当前module %@ 已注册，请检查！！",name);
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
    for (Class<CJModuleProtocol> class in [self allModuleClasses]) {
        id<CJModuleProtocol> module = [class sharedInstance];
        if ([module respondsToSelector:selector]) {
            [NSObject cj_performTarget:module selector:selector withObjects:arguments];
        }
    }
}

@end
