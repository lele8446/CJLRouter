//
//  CJMainAppDelegate.m
//  CJMain
//
//  Created by lele8446 on 2018/10/22.
//

#import "CJMainAppDelegate.h"
#import <CJLRouter.h>

#define App_Scheme  @"CJLRouterDemo://"

@implementation CJMainAppDelegate

/** APP进程已启动*/
- (BOOL)application:(UIApplication *)application willFinishLaunchingWithOptions:(nullable NSDictionary *)launchOptions {
    
    //设置当前app路由AppScheme
    [CJLRouter setupAppScheme:App_Scheme];
    //组件model初始化
    [CJLModuleManager setupAllModules];
    //向业务组件转发当前方法
    [CJLModuleManager checkAllModulesWithSelector:_cmd arguments:@[CJLSafe(application),CJLSafe(launchOptions)]];
    
    return YES;
}
/** APP启动完成，准备运行*/
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(nullable NSDictionary *)launchOptions {
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    [self.window makeKeyAndVisible];
    
    UITabBarController *tab = [UITabBarController new];
    //路由分类方法转发调用
    UINavigationController *homeNav = [CJLRouter routerPerformSELname:@"home_homeNavigationCtr"];
    
    //AppScheme路由URI调用
    NSString *uri = [NSString stringWithFormat:@"%@login/login_meNavigationCtr",App_Scheme];
    UINavigationController *meNav = [CJLRouter routerPerformWithUri:uri];
    
    [tab setViewControllers:@[homeNav,meNav] animated:YES];
    [[UIApplication sharedApplication].keyWindow setRootViewController:tab];
    
    [CJLModuleManager checkAllModulesWithSelector:_cmd arguments:@[CJLSafe(application),CJLSafe(launchOptions)]];
    return YES;
}
/** APP载入完成*/
- (void)applicationDidFinishLaunching:(UIApplication*)application {
    [CJLModuleManager checkAllModulesWithSelector:_cmd arguments:@[CJLSafe(application)]];
}
/** APP进入活跃期*/
- (void)applicationDidBecomeActive:(UIApplication *)application {
    [CJLModuleManager checkAllModulesWithSelector:_cmd arguments:@[CJLSafe(application)]];
}
/** APP进入非活跃期*/
- (void)applicationWillResignActive:(UIApplication *)application {
    [CJLModuleManager checkAllModulesWithSelector:_cmd arguments:@[CJLSafe(application)]];
}
/** APP进入后台*/
- (void)applicationDidEnterBackground:(UIApplication *)application {
    [CJLModuleManager checkAllModulesWithSelector:_cmd arguments:@[CJLSafe(application)]];
}
/** APP即将进入前台*/
- (void)applicationWillEnterForeground:(UIApplication *)application {
    [CJLModuleManager checkAllModulesWithSelector:_cmd arguments:@[CJLSafe(application)]];
}
/** APP即将被销毁*/
- (void)applicationWillTerminate:(UIApplication *)application {
    [CJLModuleManager checkAllModulesWithSelector:_cmd arguments:@[CJLSafe(application)]];
}
/** 被第三方打开 version >= iOS 9.0 */
- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url options:(NSDictionary<UIApplicationOpenURLOptionsKey,id> *)options {
    [CJLModuleManager checkAllModulesWithSelector:_cmd arguments:@[CJLSafe(application),CJLSafe(url),CJLSafe(options)]];
    return YES;
}

@end
