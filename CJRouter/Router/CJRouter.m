//
//  CJRouter.h
//  CJRouter
//
//  Created by lele8446 on 2018/10/22.
//  Copyright © 2018 lele8446. All rights reserved.
//

#import "CJRouter.h"

static NSString *CJRouterAppScheme = nil;
@interface CJRouter ()

@end

@implementation CJRouter

#pragma mark - 路由分类方法转发调用
+ (id)routerPerformSELname:(NSString *)SELname {
    return [self routerPerformSELname:SELname params:nil];
}

+ (id)routerPerformSELname:(NSString *)SELname params:(NSArray *)params {
    NSArray *rangeList = [SELname componentsSeparatedByString:@":"];
    NSInteger paramCount = rangeList.count-1;
    if(paramCount != params.count) {
        NSLog(@"========= CJRouter =========\n'%@' 入参个数 %@ 与所需参数个数 %@ 不符, ",SELname,@(paramCount),@(params.count));
        return nil;
    }
    id rs = [NSObject cj_performTarget:self selector:NSSelectorFromString(SELname) withObjects:params];
    return rs;
}

#pragma mark - 路由URL调用
/// 路由URL调用
///
/// URI调用规范：scheme://[MediatorCategory]/[action]?[params]
/// 调用规范说明：路由scheme://路由分类模块说明/调用方法名？方法参数
/// 调用示例：   CJRouter://login/updateUserName:sex:?name=user&sex=1
///
/// @param uri 调用uri字符串
+ (id)routerPerformWithUri:(NSString *)uri {
    if (uri.length == 0) {
        NSLog(@"========= CJRouter =========\n 路由URL调用方法不存在");
        return nil;
    }
    NSURL *url = CJRouterURLWithUriStr(uri);

    NSURLComponents *urlComponents = [[NSURLComponents alloc] initWithString:url.absoluteString];
    NSString *actionName = [urlComponents.path stringByReplacingOccurrencesOfString:@"/" withString:@""];
    NSArray *rangeList = [actionName componentsSeparatedByString:@":"];
    //uri 调用请求参数
    NSArray *queryItems = urlComponents.queryItems;
    
    if((rangeList.count-1) != queryItems.count) {
        NSLog(@"========= CJRouter =========\n 路由URL调用方法'%@' 入参个数 %@ 与所需参数个数 %@ 不符, ",actionName,@(queryItems.count),@(rangeList.count));
        return nil;
    }
    
    NSMutableArray *params = [NSMutableArray array];
    for (NSURLQueryItem *item in queryItems) {
        [params addObject:item.value];
    }
    return [self routerPerformSELname:actionName params:params];
}

#pragma mark - 路由 scheme 配置
+ (void)setupAppScheme:(NSString *)scheme {
    NSAssert(([scheme isKindOfClass:[NSString class]] && scheme.length>0), @"+cj_setupAppScheme: 路由scheme配置错误！当前scheme : %@",scheme);
    NSAssert(([scheme hasSuffix:@"://"]), @"+cj_setupAppScheme: 路由scheme必须以@\"://\"结尾！当前scheme : %@",scheme);
    CJRouterAppScheme = scheme;
}

+ (NSString *)appScheme {
    if (CJRouterAppScheme.length == 0) {
        return @"CJRouter://";
    }
    return CJRouterAppScheme;
}

/// URI路由跳转快速获取跳转路由方法的NSURL
/// @param UriStr NSString
FOUNDATION_EXPORT NSURL *CJRouterURLWithUriStr(NSString *UriStr) {
    NSString *appScheme = [CJRouter appScheme];
    if (![UriStr hasPrefix:appScheme]) {
        UriStr = [NSString stringWithFormat:@"%@%@",appScheme,UriStr];
    }
    NSURL *url = [NSURL URLWithString:UriStr];
    return url;
}

@end
