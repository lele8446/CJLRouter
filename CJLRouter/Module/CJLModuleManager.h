//
//  CJLModuleManager.h
//  CJLRouter
//
//  Created by lele8446 on 2018/10/22.
//  Copyright © 2018 lele8446. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CJLModuleProtocol.h"

#define CJLSafe(obj)    obj ? obj : [NSNull null]

@interface CJLModuleManager : NSObject

/* 业务组件需要提前向路由进行注册
 * 请在业务组件Module的 + (void)load 方法中进行注册
 * 注册示例：
 * + (void)load {
 *     [CJLModuleManager registerModuleClass:self.class];
 *  }
 */
/// @param moduleClass 业务组件Module类
+ (void)registerModuleClass:(Class<CJLModuleProtocol>)moduleClass;

/// 初始化所有已经向路由注册的业务组件Module
+ (void)setupAllModules;

/// 对所有已经向路由注册的业务组件Module进行方法转发
/// @param selector 转发方法名
/// @param arguments 方法参数
+ (void)checkAllModulesWithSelector:(SEL)selector arguments:(NSArray*)arguments;


@end
