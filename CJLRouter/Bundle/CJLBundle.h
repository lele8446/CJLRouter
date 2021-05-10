//
//  CJLBundle.h
//  CJLRouter
//
//  Created by lele8446 on 2018/10/22.
//  Copyright © 2018 lele8446. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

/*
* CJLBundle 子类默认遵循 CJLBundleProtocol 协议，并实现cjl_bundle方法，用于返回当前业务组件的bundle
*/
@protocol CJLBundleProtocol <NSObject>
@required
/// 返回业务组件的bundle（bundle名称默认与组件module名称相同）
+(NSBundle *)cjl_bundle;
@end

@interface CJLBundle : NSBundle

/// 根据自定义名称初始化NSBundle
/// @param bundleName bundle名称
+ (NSBundle *)cjl_bundleWithName:(NSString *)bundleName;

/// 从自定义bundle中读取图片
/// @param imageName 图片名称
+ (UIImage *)cjl_imageNamed:(NSString *)imageName;

/// 从自定义bundle中读取通过xib绘制的view
/// @param fileName view对应的xib名称
+ (UIView *)cjl_viewWithXibFileName:(NSString *)fileName;

/// 从自定义bundle中，通过Storyboard读取viewController
/// @param storyboardName Storyboard名
/// @param viewControllerName viewController名
+ (UIViewController *)cjl_viewControllerFromStoryboard:(NSString *)storyboardName viewControllerName:(NSString *)viewControllerName;

/// 从自定义bundle中读取Storyboard
/// @param storyboardName Storyboard名
+ (UIStoryboard *)cjl_storyboardWithName:(NSString *)storyboardName;

/// 从自定义bundle中读取nib
/// @param nibName nib名
+ (UINib *)cjl_nibWithName:(NSString *)nibName;
@end
