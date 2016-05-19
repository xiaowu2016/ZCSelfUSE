//
//  ZCTool_Md5.m
//  ZCSelfUSE
//
//  Created by zhangchao on 16/5/19.
//  Copyright © 2016年 zhangchao. All rights reserved.
//

#import "ZCTool_Md5.h"
#import <CommonCrypto/CommonDigest.h>

@implementation ZCTool_Md5

+ (NSString *)Md5:(NSData *)data{//转换后的结果是可见字符
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5([data bytes],(unsigned int)[data length],result);
    NSMutableString * hash=[NSMutableString string];
    for(int i=0;i<CC_MD5_DIGEST_LENGTH;i++){
        [hash appendFormat:@"%02X",result[i]];
    }
    return hash;
}
@end
