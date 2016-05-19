//
//  ZCTool_SHA1.h
//  ZCSelfUSE
//
//  Created by zhangchao on 16/5/19.
//  Copyright © 2016年 zhangchao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZCTool_SHA1 : NSObject
/**
 *  SHA1算法 40位
 *
 *  @param data 需要生成SHA1的数据
 *
 *  @return SHA1运算后的结果
 */
+ (NSString *)Sha1:(NSData *)data;
@end
