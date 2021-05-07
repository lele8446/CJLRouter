//
//  CJBundle.M
//  CJRouter
//
//  Created by lele8446 on 2018/10/22.
//  Copyright © 2018 lele8446. All rights reserved.
//

#import "CJBundle.h"

@implementation CJBundle

//+ (NSBundle *)cj_bundle {
//    return [self cj_bundleWithName:@"CJ"];
//}

+ (NSBundle *)cj_bundleWithName:(NSString *)bundleName {
    if(bundleName.length == 0) {
        return nil;
    }
    NSString *path = [[NSBundle mainBundle] pathForResource:bundleName ofType:@"bundle"];
    return  [NSBundle bundleWithPath:path];
}

+ (NSBundle *)moduleBundle {
    if ([self respondsToSelector:@selector(cj_bundle)]) {
        return [self performSelector:@selector(cj_bundle)];
    }
    return [NSBundle mainBundle];
}

+ (UIImage *)cj_imageNamed:(NSString *)imageName {
    return [CJBundle cj_imageNamed:imageName inBundle:[self moduleBundle]];
}
+ (UIImage *)cj_imageNamed:(NSString *)imgaeName inBundle:(NSBundle *)bundle {
    if(![self warningFileName:imgaeName bundle:bundle sel:_cmd]) {
        return nil;
    }
    return [UIImage imageNamed:imgaeName inBundle:bundle compatibleWithTraitCollection:nil];
}

+ (UIView *)cj_viewWithXibFileName:(NSString *)fileName {
    return [CJBundle cj_viewWithXibFileName:fileName inBundle:[self moduleBundle]];
}
+ (UIView *)cj_viewWithXibFileName:(NSString *)fileName inBundle:(NSBundle *)bundle {
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


+ (UIViewController *)cj_viewControllerFromStoryboard:(NSString *)storyboardName viewControllerName:(NSString *)viewControllerName {
    if(viewControllerName.length == 0) {
        NSLog(@"========= CJRouter =========\n %@ viewControllerName不能为空",NSStringFromSelector(_cmd));
        return nil;
    }
    if(storyboardName.length == 0) {
        NSLog(@"========= CJRouter =========\n %@ storyboardName不能为空",NSStringFromSelector(_cmd));
        return nil;
    }
    return [[self cj_storyboardWithName:storyboardName] instantiateViewControllerWithIdentifier:viewControllerName];
}

+ (UIStoryboard *)cj_storyboardWithName:(NSString *)storyboardName {
    return [CJBundle cj_storyboardWithName:storyboardName inBundle:[self moduleBundle]];
}
+ (UIStoryboard *)cj_storyboardWithName:(NSString *)storyboardName inBundle:(NSBundle *)bundle {
    if(![self warningFileName:storyboardName bundle:bundle sel:_cmd]) {
        return nil;
    }
    return [UIStoryboard storyboardWithName:storyboardName bundle:bundle];
}

+ (UINib *)cj_nibWithName:(NSString *)nibName {
    return [CJBundle cj_nibWithNibName:nibName inBundle:[self moduleBundle]];
}
+ (UINib *)cj_nibWithNibName:(NSString *)nibName inBundle:(NSBundle *)bundle {
    if(![self warningFileName:nibName bundle:bundle sel:_cmd]) {
        return nil;
    }
    return [UINib nibWithNibName:nibName bundle:bundle];
}

+ (BOOL)warningFileName:(NSString *)fileName bundle:(NSBundle *)bundle sel:(SEL)sel {
    if (!bundle) {
        NSLog(@"========= CJRouter =========\n %@ bundle不存在",NSStringFromSelector(sel));
        return NO;
    }
    if (fileName.length == 0) {
        NSLog(@"========= CJRouter =========\n %@ 文件名不能为空",NSStringFromSelector(sel));
        return NO;
    }
    return YES;
}






@end
