//
//  ZCAsyncTransformSync.h
//  icfcc
//
//  Created by zhangchao on 16/8/22.
//  Copyright © 2016年 zhangchao. All rights reserved.
//

#import <Foundation/Foundation.h>

#define dispatch_async_ZC(block)\
if([NSThread mainThread]){\
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), block);\
} else {\
    block();\
}

@interface OutObj : NSObject
@property (nonatomic,assign) BOOL status;
@property (nonatomic,strong) id obj;
@end

typedef void (^ZCBlock)(NSCondition *condition,OutObj *outObj);

@interface ZCAsyncTransformSync : NSObject
+ (OutObj *)wait:(ZCBlock)block;
+ (OutObj *)waitUntil:(NSTimeInterval)interval block:(ZCBlock)block;
@end
