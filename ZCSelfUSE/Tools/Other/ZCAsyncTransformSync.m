//
//  ZCAsyncTransformSync.m
//  icfcc
//
//  Created by zhangchao on 16/8/22.
//  Copyright © 2016年 zhangchao. All rights reserved.
//

#import "ZCAsyncTransformSync.h"

@implementation OutObj
@end

@implementation ZCAsyncTransformSync
+ (OutObj *)wait:(ZCBlock)block
{
    NSCondition * condition=[[NSCondition alloc]init];
    OutObj * outObj = [[OutObj alloc]init];
    [condition lock];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        block(condition,outObj);
    });
    [condition wait];
    [condition unlock];
    return outObj;
}

+ (OutObj *)waitUntil:(NSTimeInterval)interval block:(ZCBlock)block
{
    NSDate * untilDate=[NSDate dateWithTimeInterval:interval sinceDate:[NSDate date]];
    NSCondition * condition = [[NSCondition alloc]init];
    OutObj * outObj = [[OutObj alloc]init];
    [condition lock];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        block(condition,outObj);
    });
    [condition waitUntilDate:untilDate];
    [condition unlock];
    return outObj;
}
@end
