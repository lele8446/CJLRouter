//
//  MeViewController.m
//  CJLogin
//
//  Created by lele8446 on 2018/10/22.
//

#import "MeViewController.h"
#import "LoginViewController.h"
#import <CJRouter.h>

@interface MeViewController ()

@end

@implementation MeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"我的";
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(0, 0, 100, 50);
    button.center = CGPointMake(self.view.center.x,self.view.center.y-10);
    button.layer.cornerRadius = 5;
    button.backgroundColor = [[UIColor blueColor] colorWithAlphaComponent:0.5];
    [button setTitle:@"登录" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(login) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    
    UIButton *button2 = [UIButton buttonWithType:UIButtonTypeCustom];
    button2.frame = CGRectMake(0, 0, 220, 50);
    button2.center = CGPointMake(self.view.center.x,self.view.center.y+220);
    button2.layer.cornerRadius = 5;
    button2.backgroundColor = [[UIColor blueColor] colorWithAlphaComponent:0.5];
    [button2 setTitle:@"更新用户信息" forState:UIControlStateNormal];
    [button2 addTarget:self action:@selector(login_updateUserInfo) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button2];
    
}

- (void)login {
    [LoginViewController loginFromController:self.navigationController success:nil];
}

- (void)login_updateUserInfo {
    
    __block UIActivityIndicatorView *activityIndicator = nil;
    if (@available(iOS 13.0, *)) {
        activityIndicator = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleLarge];
    } else {
        activityIndicator = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    }
    [self.view addSubview:activityIndicator];
    activityIndicator.frame = CGRectMake(0, 0, 100, 100);
    activityIndicator.center = self.view.center;
    activityIndicator.layer.cornerRadius = 5;
    activityIndicator.color = [UIColor whiteColor];
    activityIndicator.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.75];
    activityIndicator.hidesWhenStopped = YES;
    [activityIndicator startAnimating];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [activityIndicator stopAnimating];
        activityIndicator = nil;
        //向所有业务组件转发更新用户成功的消息
        [CJModuleManager checkAllModulesWithSelector:_cmd arguments:@[]];
    });
    
    
}


@end
