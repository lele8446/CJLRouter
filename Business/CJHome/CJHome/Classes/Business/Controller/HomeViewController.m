//
//  HomeViewController.m
//  CJHome
//
//  Created by lele8446 on 2018/10/22.
//

#import "HomeViewController.h"
#import <CJLRouter.h>

@interface HomeViewController ()

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"首页";

    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 200, 50)];
    label.text = @"这是首页";
    label.textAlignment = NSTextAlignmentCenter;
    label.center = CGPointMake(self.view.center.x,self.view.center.y-50);
    [self.view addSubview:label];

    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(0, 0, 100, 50);
    button.layer.cornerRadius = 5;
    button.center = CGPointMake(self.view.center.x,self.view.center.y+50);
    button.backgroundColor = [[UIColor blueColor] colorWithAlphaComponent:0.5];
    [button setTitle:@"登录" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(login) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
}

- (void)login {
    void(^loginSuccess)(void) = ^(void){
        [self loginSuccess];
    };
    NSArray *params = @[self.navigationController,loginSuccess];
    [CJLRouter routerPerformSELname:@"login_loginFromController:success:" params:params];
}

- (void)loginSuccess {
    UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"登录成功" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:nil];
   [alert addAction:defaultAction];
   [self presentViewController:alert animated:YES completion:nil];
}

@end
