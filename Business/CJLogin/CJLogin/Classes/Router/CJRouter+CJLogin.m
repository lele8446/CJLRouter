//
//  CJRouter+CJLogin
//  CJLogin
//
//  Created by lele8446 on 2018/10/22.
//  Copyright © 2018 lele8446. All rights reserved.
//


#import "CJRouter+CJLogin.h"
#import "MeViewController.h"
#import "CJLoginBundle.h"
#import "LoginViewController.h"

@implementation CJRouter (CJLogin)

/// 我的模块Navigation
+ (UINavigationController *)login_meNavigationCtr {
    UIViewController *me = [[MeViewController alloc]init];
    UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:me];
    UITabBarItem *tabBarItem = [[UITabBarItem alloc]initWithTitle:@"首页" image:[CJLoginBundle cj_imageNamed:@"me"] selectedImage:[CJLoginBundle cj_imageNamed:@"me_sel"]];
    nav.tabBarItem = tabBarItem;
    return nav;
}

+ (void)login_loginFromController:(UIViewController *)viewController success:(void(^)(void))loginSuccessBlock {
    [LoginViewController loginFromController:viewController success:loginSuccessBlock];
}
@end
