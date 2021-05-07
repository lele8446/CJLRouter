//
//  CJLoginBundle.m
//  CJLogin
//
//  Created by lele8446 on 2018/10/22.
//  Copyright © 2018 lele8446. All rights reserved.
//

#import "CJLoginBundle.h"

@implementation CJLoginBundle

#pragma mark - CJBundleProtocol

/// 需要返回当前业务组件的bundle（默认bundle名与业务组件名称相同）
+ (NSBundle *)cj_bundle {
    return [self cj_bundleWithName:@"CJLogin"];
}

@end
