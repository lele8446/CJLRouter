//
//  CJLoginModule.h
//  CJLogin
//
//  Created by lele8446 on 2018/10/22.
//  Copyright © 2018 lele8446. All rights reserved.
//

// 业务组件生命周期管理以及组件间消息通信管理类
// 1. 默认自动在 +load 方法中向CJLModuleManager对进行注册
// 2. 必须实现 CJLModuleProtocol 协议方法：+sharedInstance，-setup
// 3. 在程序启动时会自动触发 -setup 方法，请在该方法内进行组件所需初始化及配置。
// 5. 根据实际业务需求，在适当的地方通过 CJLModuleManager 触发消息广播。
// 6. 根据实际业务需求，有选择的实现 CJLModuleProtocol 协议方法。

/*
 示例：APP生命周期管理
 APPDelegate.m 内进行消息广播
 - (void)applicationDidEnterBackground:(UIApplication *)application {
    //告知所有实现-applicationDidEnterBackground:的业务组件Module，程序进入后台
    [CJLModuleManager checkAllModulesWithSelector:_cmd arguments:@[CJLSafe(application)]];
    //在此执行主工程在进入后台时的操作...
 }

 CJLoginModule.m [业务组件接收对应方法]:
 - (void)applicationDidEnterBackground:(UIApplication *)application {
    //接收到了程序进入后台通知
    //在此执行当前组件进入后台时的业务操作...
 }
 */


#import <Foundation/Foundation.h>
#import "CJLModuleProtocol.h"

@interface CJLoginModule : NSObject<CJLModuleProtocol>

@end
