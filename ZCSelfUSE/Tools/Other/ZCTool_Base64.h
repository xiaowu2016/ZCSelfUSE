//
//  ZCTool_Base64.h
//  ZCSelfUSE
//
//  Created by zhangchao on 16/5/19.
//  Copyright © 2016年 zhangchao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZCTool_Base64 : NSObject
/**
 *  BASE64编码加密文本
 *
 *  @param text 需要加密的文本
 *
 *  @return 加密后的结果
 */
+ (NSString*)Encrypt:(NSData *)text;
/**
 *  BASE64编码解密文本
 *
 *  @param text 需要解密的文本
 *
 *  @return 解密后的结果
 */
+ (NSData*)Decrypt:(NSString *)text;
@end
