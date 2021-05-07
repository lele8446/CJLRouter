//
//  LoginViewController.h
//  CJLogin
//
//  Created by lele8446 on 2018/10/22.
//

#import <UIKit/UIKit.h>

@interface LoginViewController : UIViewController
@property (nonatomic, copy) void(^loginSuccessBlock)(void);

+ (void)loginFromController:(UIViewController *)viewController success:(void(^)(void))loginSuccessBlock;
@end
