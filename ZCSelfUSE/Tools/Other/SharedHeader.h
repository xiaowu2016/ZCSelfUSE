//
//  用来创建单例的宏
//  ZCSelfUSE
//
//  Created by zhangchao on 16/5/16.
//  Copyright © 2016年 zhangchao. All rights reserved.
//

// @interface
#define singleton_interface(className) \
+ (className *)shared##className;


// @implementation
#define singleton_implementation(className) \
static className *instance; \
+ (instancetype)allocWithZone:(NSZone *)zone \
{ \
    static dispatch_once_t onceToken; \
    dispatch_once(&onceToken, ^{ \
        if(instance == nil) \
        { \
            instance = [super allocWithZone:zone]; \
        } \
    }); \
    return instance; \
} \
+ (className *)shared##className \
{ \
    static dispatch_once_t onceToken; \
    dispatch_once(&onceToken, ^{ \
        if(instance == nil) \
        { \
            instance = [[self alloc] init]; \
        } \
    }); \
    return instance; \
}

/* SharedHeader_h */
