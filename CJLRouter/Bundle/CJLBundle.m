//
//  CJLBundle.m
//  CJLRouter
//
//  Created by lele8446 on 2018/10/22.
//  Copyright © 2018 lele8446. All rights reserved.
//

#import "CJLBundle.h"

@implementation CJLBundle

//+ (NSBundle *)cjl_bundle {
//    return [self cjl_bundleWithName:@"CJL"];
//}

+ (NSBundle *)cjl_bundleWithName:(NSString *)bundleName {
    if(bundleName.length == 0) {
        return nil;
    }
    NSString *path = [[NSBundle mainBundle] pathForResource:bundleName ofType:@"bundle"];
    return  [NSBundle bundleWithPath:path];
}

+ (NSBundle *)moduleBundle {
    if ([self respondsToSelector:@selector(cjl_bundle)]) {
        return [self performSelector:@selector(cjl_bundle)];
    }
    return [NSBundle mainBundle];
}

+ (UIImage *)cjl_imageNamed:(NSString *)imageName {
    return [CJLBundle cjl_imageNamed:imageName inBundle:[self moduleBundle]];
}
+ (UIImage *)cjl_imageNamed:(NSString *)imgaeName inBundle:(NSBundle *)bundle {
    if(![self warningFileName:imgaeName bundle:bundle sel:_cmd]) {
        return nil;
    }
    return [UIImage imageNamed:imgaeName inBundle:bundle compatibleWithTraitCollection:nil];
}

+ (UIView *)cjl_viewWithXibFileName:(NSString *)fileName {
    return [CJLBundle cjl_viewWithXibFileName:fileName inBundle:[self moduleBundle]];
}
+ (UIView *)cjl_viewWithXibFileName:(NSString *)fileName inBundle:(NSBundle *)bundle {
    if(![self warningFileName:fileName bundle:bundle sel:_cmd]) {
        return nil;
    }
    //如果没有国际化，则直接去对应bundle下读取文件
    UIView *xibView = [[bundle loadNibNamed:fileName owner:nil options:nil] lastObject];
    if(!xibView) {
        //文件国际化之后，所有的bundle的文件资源都在base的目录下
        xibView = [[[NSBundle bundleWithPath:[bundle pathForResource:@"Base" ofType:@"lproj"]] loadNibNamed:fileName owner:nil options:nil] lastObject];
    }
    return xibView;
}


+ (UIViewController *)cjl_viewControllerFromStoryboard:(NSString *)storyboardName viewControllerName:(NSString *)viewControllerName {
    if(viewControllerName.length == 0) {
        NSLog(@"========= CJLRouter =========\n %@ viewControllerName不能为空",NSStringFromSelector(_cmd));
        return nil;
    }
    if(storyboardName.length == 0) {
        NSLog(@"========= CJLRouter =========\n %@ storyboardName不能为空",NSStringFromSelector(_cmd));
        return nil;
    }
    return [[self cjl_storyboardWithName:storyboardName] instantiateViewControllerWithIdentifier:viewControllerName];
}

+ (UIStoryboard *)cjl_storyboardWithName:(NSString *)storyboardName {
    return [CJLBundle cjl_storyboardWithName:storyboardName inBundle:[self moduleBundle]];
}
+ (UIStoryboard *)cjl_storyboardWithName:(NSString *)storyboardName inBundle:(NSBundle *)bundle {
    if(![self warningFileName:storyboardName bundle:bundle sel:_cmd]) {
        return nil;
    }
    return [UIStoryboard storyboardWithName:storyboardName bundle:bundle];
}

+ (UINib *)cjl_nibWithName:(NSString *)nibName {
    return [CJLBundle cjl_nibWithNibName:nibName inBundle:[self moduleBundle]];
}
+ (UINib *)cjl_nibWithNibName:(NSString *)nibName inBundle:(NSBundle *)bundle {
    if(![self warningFileName:nibName bundle:bundle sel:_cmd]) {
        return nil;
    }
    return [UINib nibWithNibName:nibName bundle:bundle];
}

+ (BOOL)warningFileName:(NSString *)fileName bundle:(NSBundle *)bundle sel:(SEL)sel {
    if (!bundle) {
        NSLog(@"========= CJLRouter =========\n %@ bundle不存在",NSStringFromSelector(sel));
        return NO;
    }
    if (fileName.length == 0) {
        NSLog(@"========= CJLRouter =========\n %@ 文件名不能为空",NSStringFromSelector(sel));
        return NO;
    }
    return YES;
}






@end
