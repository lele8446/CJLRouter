//
//  CJLRouter+CJHome
//  CJHome
//
//  Created by lele8446 on 2018/10/22.
//  Copyright © 2018 lele8446. All rights reserved.
//


#import "CJLRouter+CJHome.h"
#import "HomeViewController.h"
#import "CJHomeBundle.h"

@implementation CJLRouter (CJHome)

/// 首页模块Navigation
+ (UINavigationController *)home_homeNavigationCtr {
    UIViewController *home = [[HomeViewController alloc]init];
    UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:home];
    UITabBarItem *tabBarItem = [[UITabBarItem alloc]initWithTitle:@"首页" image:[CJHomeBundle cjl_imageNamed:@"home"] selectedImage:[CJHomeBundle cjl_imageNamed:@"home_sel"]];
    nav.tabBarItem = tabBarItem;
    return nav;
}
@end
