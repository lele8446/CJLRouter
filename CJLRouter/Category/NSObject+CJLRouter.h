//
//  NSObject+CJLRouter.h
//  CJLRouter
//
//  Created by lele8446 on 2018/10/22.
//  Copyright © 2018 lele8446. All rights reserved.
//

#import <Foundation/Foundation.h>

#if (DEBUG)
    #define NSLog(...) do {                        \
        NSLog(__VA_ARGS__);                        \
    } while (0)
#else
    #define NSLog(...)
#endif

@interface NSObject (CJLRouter)

+ (id)cjl_performTarget:(id)target selector:(SEL)selector withObjects:(NSArray *)objects;

@end
