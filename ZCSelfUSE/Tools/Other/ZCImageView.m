//
//  ZCImageView.m
//  ZCSelfUSE
//
//  Created by zhangchao on 16/4/18.
//  Copyright © 2016年 icfcc. All rights reserved.
//

#import "ZCImageView.h"

#define SuppressPerformSelectorLeakWarning(Stuff) \
do { \
_Pragma("clang diagnostic push") \
_Pragma("clang diagnostic ignored \"-Warc-performSelector-leaks\"") \
Stuff; \
_Pragma("clang diagnostic pop") \
} while (0)

@implementation ZCImageView
-(void)MyTarget:(id)target Action:(SEL)action{
    
    _target = target;
    _action  = action;
    
}


-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    if ([_target respondsToSelector:_action]) {
        SuppressPerformSelectorLeakWarning([_target performSelector:_action withObject:self]);
    }
}

@end
