//
//  CJBundle.h
//  CJRouter
//
//  Created by lele8446 on 2018/10/22.
//  Copyright © 2018 lele8446. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

/*
* CJBundle 子类默认遵循 CJBundleProtocol 协议，并实现cj_bundle方法，用于返回当前业务组件的bundle
*/
@protocol CJBundleProtocol <NSObject>
@required
/// 返回业务组件的bundle（bundle名称默认与组件module名称相同）
+(NSBundle *)cj_bundle;
@end

@interface CJBundle : NSBundle

/// 根据自定义名称初始化NSBundle
/// @param bundleName bundle名称
+ (NSBundle *)cj_bundleWithName:(NSString *)bundleName;

/// 从自定义bundle中读取图片
/// @param imageName 图片名称
+ (UIImage *)cj_imageNamed:(NSString *)imageName;

/// 从自定义bundle中读取通过xib绘制的view
/// @param fileName view对应的xib名称
+ (UIView *)cj_viewWithXibFileName:(NSString *)fileName;

/// 从自定义bundle中，通过Storyboard读取viewController
/// @param storyboardName Storyboard名
/// @param viewControllerName viewController名
+ (UIViewController *)cj_viewControllerFromStoryboard:(NSString *)storyboardName viewControllerName:(NSString *)viewControllerName;

/// 从自定义bundle中读取Storyboard
/// @param storyboardName Storyboard名
+ (UIStoryboard *)cj_storyboardWithName:(NSString *)storyboardName;

/// 从自定义bundle中读取nib
/// @param nibName nib名
+ (UINib *)cj_nibWithName:(NSString *)nibName;
@end
