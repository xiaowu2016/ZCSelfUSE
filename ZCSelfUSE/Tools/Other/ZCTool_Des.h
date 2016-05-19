//
//  ZCTool_Des.h
//  ZCSelfUSE
//
//  Created by zhangchao on 16/5/19.
//  Copyright © 2016年 zhangchao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CommonCrypto/CommonCrypto.h>

@interface ZCTool_Des : NSObject
/**
 *  3DES-ECB加解密报文
 *
 *  @param data                需要加解密的报文
 *  @param encryptOrDecrypt    kCCEncrypt加密 kCCDecrypt解密
 *  @param encryptOrDecryptKey 加解密使用的Key
 *
 *  @return 加解密后的结果
 */
+ (NSData *)TripleDES:(NSData *)data encryptOrDecrypt:(CCOperation)encryptOrDecrypt encryptOrDecryptKey:(NSData *)encryptOrDecryptKey;
@end
