//
//  ZCTool_SHA1.m
//  ZCSelfUSE
//
//  Created by zhangchao on 16/5/19.
//  Copyright © 2016年 zhangchao. All rights reserved.
//

#import "ZCTool_SHA1.h"
#import <CommonCrypto/CommonDigest.h>

@implementation ZCTool_SHA1
//SHA1加签
+ (NSString *) Sha1:(NSData *)data//转换后的结果是可见字符
{
    uint8_t digest[CC_SHA1_DIGEST_LENGTH];
    CC_SHA1(data.bytes, (unsigned int)data.length, digest);
    NSMutableString *hash = [NSMutableString string];
    for (int i=0;i<CC_SHA1_DIGEST_LENGTH; i++) {
        [hash appendFormat:@"%02X",digest[i] ];
    }
    return hash;
}

@end
