//
//  CJLRouter.h
//  CJLRouter
//
//  Created by lele8446 on 2018/10/22.
//  Copyright © 2018 lele8446. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CJLBundle.h"
#import "CJLModuleManager.h"
#import "NSObject+CJLRouter.h"

@interface CJLRouter : NSObject

/// 路由分类方法转发调用
/// @param SELname 分类方法名
+ (id)routerPerformSELname:(NSString *)SELname;

/// 路由分类方法转发调用
/// @param SELname 分类方法名
/// @param params 方法参数
+ (id)routerPerformSELname:(NSString *)SELname params:(NSArray *)params;

/// AppScheme路由URI调用
///
/// URI调用规范：scheme://[MediatorCategory]/[action]?[params]
/// 调用规范说明：路由scheme://路由分类模块说明/调用方法名？方法参数
/// 调用示例：   CJLRouter://login/updateUserName:sex:?name=user&sex=1
///
/// @param uri 调用uri字符串
+ (id)routerPerformWithUri:(NSString *)uri;

/// 设置路由appScheme（不设置默认为：CJLRouter://）
/// @param scheme 路由appScheme（格式：XXX://）
+ (void)setupAppScheme:(NSString *)scheme;

/// 路由appScheme（默认为：CJLRouter://）
+ (NSString *)appScheme;

@end
