//
//  ZCTool_Md5.h
//  ZCSelfUSE
//
//  Created by zhangchao on 16/5/19.
//  Copyright © 2016年 zhangchao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZCTool_Md5 : NSObject
/**
 *  MD5算法 32位
 *
 *  @param s 需要生成MD5的数据
 *
 *  @return MD5运算后的结果
 */
+ (NSString *)Md5:(NSData *)s;
@end
