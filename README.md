# CJLRouter
组件化开发解决方案，可用于解耦业务模块，支持分类方法调用以及AppScheme路由两种调用方式



### pod管理

```shell
pod 'CJLRouter'
```

路由引用

```objc
#import <CJLRouter.h>

/// 路由分类方法转发调用
/// @param SELname 分类方法名
+ (id)routerPerformSELname:(NSString *)SELname;

/// AppScheme路由URI调用
/// URI调用规范：scheme://[MediatorCategory]/[action]?[params]
/// 调用规范说明：路由scheme://路由分类模块说明/调用方法名？方法参数
/// 调用示例：   CJLRouter://login/updateUserName:sex:?name=user&sex=1
///
/// @param uri 调用uri字符串
+ (id)routerPerformWithUri:(NSString *)uri;
```



### 业务组件生成

下载业务组件 [模板初始化脚本](https://lele8446infoq.oss-cn-shenzhen.aliyuncs.com/%E7%BB%84%E4%BB%B6%E5%8C%96/CJLRouterModule.py.zip)，打开终端进入脚本所在目录进行组件模块初始化

初次运行请先执行  **chmod 777  Rename.py** 指令，对脚本赋予可执行指令

```shell
# CJLRouterModule.py [组件模块名称]
./CJLRouterModule.py ModuleName
```



### 使用说明

执行Rename.py脚本后，组件模块的**Router**文件夹下将自动生成以下相关文件

#### 路由分类
```objc
CJLRouter+ModuleName.h
CJLRouter+ModuleName.m
```

用于声明当前组件可供外部调用的通信接口，接口方法的明名格式为：+ 当前模块名_方法名

当前组件对外接口示例：

```objc
+ (UIViewController *)login_loginViewController;//获取登录页面Controller
+ (BOOL)login_updateUserName:(NSString *)name;//更新用户名
```

其他组件调用：

```objc
//1、路由分类方法转发调用
UIViewController *loginVC = [CJLRouter routerPerformSELname:@"login_loginViewController"];
BOOL result = [CJLRouter routerPerformSELname:@"login_updateUserName:" params:@[@"username"]];

//2、AppScheme路由URI调用
BOOL result = [CJLRouter routerPerformWithUri:@"CJLRouter://login/login_updateUserName:?name=username"];
```

#### 组件Module管理
```objc
ModuleNameModule.h
ModuleNameModule.m
```

业务组件生命周期管理以及组件间消息通信管理类

1. 默认自动在 +load 方法中向CJLModuleManager进行注册
2. 必须实现 CJLModuleProtocol 协议方法：+sharedInstance，-setup
3. 在程序启动时会自动触发 -setup 方法，请在该方法内进行组件相关初始化及配置。
4. 根据实际业务需求，在适当的地方通过 CJLModuleManager 触发消息广播。
5. 根据实际业务需求，有选择的实现 CJLModuleProtocol 协议方法。

示例：APP生命周期管理

```objc
//APPDelegate.m 内进行消息广播
- (void)applicationDidEnterBackground:(UIApplication *)application {
    //告知所有实现-applicationDidEnterBackground:的业务组件Module，程序进入后台
    [CJLModuleManager checkAllModulesWithSelector:_cmd arguments:@[CJLSafe(application)]];
    //在此执行主工程在进入后台时的操作...
}
```

 ModuleNameModule.m ，业务组件响应对应方法

```objc
- (void)applicationDidEnterBackground:(UIApplication *)application {
    //接收到了程序进入后台通知
    //在此执行当前组件进入后台时的业务操作...
}
```

#### 组件资源管理
```objc
ModuleNameBundle.h
ModuleNameBundle.m
```

声明当前业务组件资源Bundle，遵循`CJLBundleProtocol`协议，必须实现 **+cjl_bundle** 方法，用于返回当前组件Bundle，默认bundle名与业务组件名称相同

```objc
/// 需要返回当前业务组件的bundle（默认bundle名与业务组件名称相同）
+ (NSBundle *)cjl_bundle {
    return [self cjl_bundleWithName:@"ModuleName"];
}
```

