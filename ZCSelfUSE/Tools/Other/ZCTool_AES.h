//
//  ZCTool_AES.h
//  ZCSelfUSE
//
//  Created by zhangchao on 16/5/19.
//  Copyright © 2016年 zhangchao. All rights reserved.
//

/**
 *  AES加密解密
 */

#import <Foundation/Foundation.h>

@interface ZCTool_AES : NSObject
/**
 *  加密
 *
 *  @param originalData 原始数据
 *  @param key  密钥
 *
 *  @return 返回加密后的数据
 */
+ (NSData *)AES256EncryptData:(NSData *)originalData WithKey:(NSString *)key;


/**
 *  解密数据
 *
 *  @param secretData 用于解密的数据
 *  @param key        密钥
 *
 *  @return 返回解密后的数据
 */
+ (NSData *)AES256DecryptData:(NSData *)secretData WithKey:(NSString *)key;
@end
