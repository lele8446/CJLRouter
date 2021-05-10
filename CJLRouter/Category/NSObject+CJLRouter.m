//
//  NSObject+CJLRouter.m
//  CJLRouter
//
//  Created by lele8446 on 2018/10/22.
//  Copyright © 2018 lele8446. All rights reserved.
//

#import "NSObject+CJLRouter.h"
#import <objc/runtime.h>

@implementation NSObject (CJLRouter)

+ (id)cjl_performTarget:(id)target selector:(SEL)selector withObjects:(NSArray *)objects {
    NSMethodSignature *signature = [target methodSignatureForSelector:selector];
    if (signature == nil) {
        NSLog(@"========= CJLRouter =========\n当前类：%@ 不存在转发方法: %@，请检查!!",target,NSStringFromSelector(selector));
        return nil;
    }
    if (target && [target respondsToSelector:selector]) {
        @try {
            NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:signature];
            invocation.target = target;
            invocation.selector = selector;
            
            NSInteger paramsCount = signature.numberOfArguments - 2;
            paramsCount = MIN(paramsCount, objects.count);
            for (NSInteger i = 0; i < paramsCount; i++) {
                id object = objects[i];
                if ([object isKindOfClass:[NSNull class]]) continue;
                [invocation setArgument:&object atIndex:i + 2];
            }
            
            // 调用方法
            [invocation invoke];
            
            //声明返回值变量
            id returnValue = nil;
            //获得返回值类型
            const char *returnType = signature.methodReturnType;
            //如果没有返回值，也就是消息声明为void，那么returnValue=nil
            if( !strcmp(returnType, @encode(void)) ){
                returnValue =  nil;
            } else if( !strcmp(returnType, @encode(id)) ){
                //如果返回值为对象，那么为变量赋值
                void *tempResultSet;
                [invocation getReturnValue:&tempResultSet];
                returnValue = (__bridge id)tempResultSet;
            } else{
                //如果返回值为普通类型NSInteger  BOOL
                //返回值长度
                NSUInteger length = [signature methodReturnLength];
                //根据长度申请内存
                void *buffer = (void *)malloc(length);
                //为变量赋值
                [invocation getReturnValue:buffer];
                if (CJLRouterIsStructType(returnType)) {
                    //TODO: 结构体处理
                }
                else{
                    if (!strcmp(returnType, @encode(char))) {
                        returnValue = [NSNumber numberWithChar:*((char*)buffer)];
                    }else if( !strcmp(returnType, @encode(int)) ){
                        returnValue = [NSNumber numberWithInt:*((int*)buffer)];
                    }else if( !strcmp(returnType, @encode(BOOL)) ) {
                        returnValue = [NSNumber numberWithBool:*((BOOL*)buffer)];
                    }else if( !strcmp(returnType, @encode(NSInteger))){
                        returnValue = [NSNumber numberWithInteger:*((NSInteger*)buffer)];
                    }else if( !strcmp(returnType, @encode(NSUInteger)) ){
                        returnValue = [NSNumber numberWithUnsignedInteger:*((NSUInteger*)buffer)];
                    }else if( !strcmp(returnType, @encode(short)) ){
                        returnValue = [NSNumber numberWithShort:*((short*)buffer)];
                    }else if( !strcmp(returnType, @encode(long)) ){
                        returnValue = [NSNumber numberWithLong:*((long*)buffer)];
                    }else if( !strcmp(returnType, @encode(long long)) ){
                        returnValue = [NSNumber numberWithLongLong:*((long long*)buffer)];
                    }else if( !strcmp(returnType, @encode(unsigned char)) ){
                        returnValue = [NSNumber numberWithUnsignedChar:*((unsigned char*)buffer)];
                    }else if( !strcmp(returnType, @encode(unsigned int)) ){
                        returnValue = [NSNumber numberWithUnsignedInt:*((unsigned int*)buffer)];
                    }else if( !strcmp(returnType, @encode(unsigned short)) ){
                        returnValue = [NSNumber numberWithUnsignedShort:*((unsigned short*)buffer)];
                    }else if( !strcmp(returnType, @encode(unsigned long)) ){
                        returnValue = [NSNumber numberWithUnsignedLong:*((unsigned long*)buffer)];
                    }else if( !strcmp(returnType, @encode(unsigned long long)) ){
                        returnValue = [NSNumber numberWithUnsignedLongLong:*((unsigned long long*)buffer)];
                    }else if( !strcmp(returnType, @encode(float)) ){
                        returnValue = [NSNumber numberWithFloat:*((float*)buffer)];
                    }else if( !strcmp(returnType, @encode(double)) ){
                        returnValue = [NSNumber numberWithDouble:*((double*)buffer)];
                    }
                }
                free(buffer);
            }
            return returnValue;
        } @catch (NSException *exception) {
            NSLog(@"========= CJLRouter =========\n target：%@ invoke转发方法: %@，失败!!\n exception: %@",target,NSStringFromSelector(selector),exception);
            return nil;
        }
    }
}

//判断是否为结构体
FOUNDATION_EXPORT BOOL CJLRouterIsStructType(const char *encoding) {
    return encoding[0] == _C_STRUCT_B;
}
@end
