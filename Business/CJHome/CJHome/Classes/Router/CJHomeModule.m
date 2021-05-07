//
//  CJHomeModule.m
//  CJHome
//
//  Created by lele8446 on 2018/10/22.
//  Copyright © 2018 lele8446. All rights reserved.
//

#import "CJHomeModule.h"
#import <CJRouter.h>
#import <UIKit/UIKit.h>

@implementation CJHomeModule

+ (void)load {
    [CJModuleManager registerModuleClass:self.class];
}

#pragma mark - CJModuleProtocol @required
+ (instancetype)sharedInstance {
    static CJHomeModule *share = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        share = [[CJHomeModule alloc] init];
    });
    return share;
}

/// 组件的初始化配置方法
- (void)setup {
    //在此处执行组件初始化时需进行的基础配置
    //注：该方法是在主线程调用的，如果是进行网络请求及其他比较耗时的操作需要另外注意，可以将其放到异步线程

}

#pragma mark - CJModuleProtocol @optional
#pragma mark - 登录业务模块的回调方法
- (void)login_updateUserInfo {
    NSLog(@"%@ --- %@ 更新用户信息成功",[self class],NSStringFromSelector(_cmd));
}
- (void)login_loginSuccess {
    NSLog(@"%@ --- %@ 登录成功",[self class],NSStringFromSelector(_cmd));
}

#pragma mark - application life cycle
/*
 * 可在此实现application系列方法，AppDelegate中会对进行相应调用
 *
 * 注：需要使用时打开对应方法，编写自身逻辑代码即可
 */
///** APP进程已启动*/
//- (BOOL)application:(UIApplication *)application willFinishLaunchingWithOptions:(nullable NSDictionary *)launchOptions {return YES;}
///** APP启动完成，准备运行*/
//- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(nullable NSDictionary *)launchOptions {return YES;}
///** APP载入完成*/
//- (void)applicationDidFinishLaunching:(UIApplication*)application {}
///** APP进入活跃期*/
//- (void)applicationDidBecomeActive:(UIApplication *)application {}
///** APP进入非活跃期*/
//- (void)applicationWillResignActive:(UIApplication *)application {}
///** APP进入后台*/
//- (void)applicationDidEnterBackground:(UIApplication *)application {}
///** APP即将进入前台*/
//- (void)applicationWillEnterForeground:(UIApplication *)application {}
///** APP即将被销毁*/
//- (void)applicationWillTerminate:(UIApplication *)application {}
///** 被第三方打开 version >= iOS 9.0 */
//- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url options:(NSDictionary<UIApplicationOpenURLOptionsKey,id> *)options {return YES;}


@end
