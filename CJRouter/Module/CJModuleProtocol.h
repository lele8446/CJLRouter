//
//  CJModuleProtocol.h
//  CJRouter
//
//  Created by lele8446 on 2018/10/22.
//  Copyright © 2018 lele8446. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

/// 组件消息广播协议
@protocol CJModuleProtocol <UIApplicationDelegate, NSObject>
@required
/// 组件模块必须实现单例方法
+ (instancetype)sharedInstance;

/// 组件模块必须实现初始化
- (void)setup;

@optional
@end
