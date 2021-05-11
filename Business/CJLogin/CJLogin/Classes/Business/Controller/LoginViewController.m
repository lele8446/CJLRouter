//
//  LoginViewController.m
//  CJLogin
//
//  Created by lele8446 on 2018/10/22.
//

#import "LoginViewController.h"
#import <CJLRouter.h>

@interface LoginViewController ()
@property (nonatomic, strong) UIActivityIndicatorView * activityIndicator;
@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor lightGrayColor];
    self.navigationItem.title = @"登录";

    if (@available(iOS 13.0, *)) {
        self.activityIndicator = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleLarge];
    } else {
        self.activityIndicator = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    }
    [self.view addSubview:self.activityIndicator];
    self.activityIndicator.frame = CGRectMake(0, 0, 100, 100);
    self.activityIndicator.center = self.view.center;
    self.activityIndicator.layer.cornerRadius = 5;
    self.activityIndicator.color = [UIColor whiteColor];
    self.activityIndicator.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.75];
    self.activityIndicator.hidesWhenStopped = YES;

    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(0, 0, 200, 50);
    button.center = CGPointMake(self.view.center.x,self.view.center.y+200);
    button.layer.cornerRadius = 5;
    button.backgroundColor = [[UIColor blueColor] colorWithAlphaComponent:0.5];
    [button setTitle:@"点击登录" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(login) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
}

- (void)login {
    [self.activityIndicator startAnimating];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.activityIndicator stopAnimating];
        [self.navigationController dismissViewControllerAnimated:YES completion:^{
            if (self.loginSuccessBlock) {
                self.loginSuccessBlock();
            }

            //向所有业务组件转发用户登录成功的消息
            [CJLModuleManager checkAllModulesWithSelector:NSSelectorFromString(@"login_loginSuccess") arguments:@[]];
        }];
    });
}

+ (void)loginFromController:(UIViewController *)viewController success:(void(^)(void))loginSuccessBlock {
    LoginViewController *login = [[LoginViewController alloc]init];
    login.loginSuccessBlock = loginSuccessBlock;
    UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:login];
    [viewController presentViewController:nav animated:YES completion:^{

    }];
}
@end
