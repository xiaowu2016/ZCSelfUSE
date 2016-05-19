//
//  ZCTool_Des.m
//  ZCSelfUSE
//
//  Created by zhangchao on 16/5/19.
//  Copyright © 2016年 zhangchao. All rights reserved.
//

#import "ZCTool_Des.h"
#import "NSString+ZC_Tool.h"

@implementation ZCTool_Des
+ (NSData *)TripleDES:(NSData *)data encryptOrDecrypt:(CCOperation)encryptOrDecrypt encryptOrDecryptKey:(NSData *)encryptOrDecryptKey{
    const void *vplainText;
    size_t plainTextBufferSize;
    plainTextBufferSize = [data length];
    vplainText = [data bytes];
    CCCryptorStatus ccStatus;
    uint8_t *bufferPtr = NULL;
    size_t bufferPtrSize = 0;
    size_t movedBytes = 0;
    NSData * result =nil;//返回结果
    const void *vkey =NULL;//密钥
    bufferPtrSize = (plainTextBufferSize + kCCBlockSize3DES) & ~(kCCBlockSize3DES - 1);
    bufferPtr = malloc( bufferPtrSize * sizeof(uint8_t));
    memset((void *)bufferPtr, 0x0, bufferPtrSize);
    if ([encryptOrDecryptKey length]==16) {
        NSMutableData * keydata=[[NSMutableData alloc] init ];
        [keydata appendData:encryptOrDecryptKey];
        [keydata appendData:[NSString subdata:encryptOrDecryptKey start:0 length:8]];
        vkey=[keydata bytes];
    }
    else
        vkey= (const void *)[encryptOrDecryptKey bytes];
    ccStatus = CCCrypt(encryptOrDecrypt,
                       kCCAlgorithm3DES,
                       //kCCOptionPKCS7Padding | kCCOptionECBMode,
                       kCCOptionECBMode,
                       vkey,
                       kCCKeySize3DES,
                       nil,
                       vplainText,
                       plainTextBufferSize,
                       (void *)bufferPtr,
                       bufferPtrSize,
                       &movedBytes);
    NSString * errMsg=@"";
    if (ccStatus!=kCCSuccess) {
        switch (ccStatus) {
            case kCCParamError:
                errMsg=@"PARAM ERROR";
                break;
            case kCCBufferTooSmall:
                errMsg=@"BUFFER TOO SMALL";
                break;
            case kCCMemoryFailure:
                errMsg=@"MEMORY FAILURE";
                break;
            case kCCAlignmentError:
                errMsg=@"ALIGNMENT ERROR";
                break;
            case kCCDecodeError:
                errMsg=@"DECODE ERROR";
            case kCCUnimplemented:
                errMsg=@"UNIMPLEMENTED";
                break;
            default:
                errMsg=@"OTHER ERROR";
                break;
        }
        NSLog(@"%s:Error %@",__func__,errMsg);
        return nil;
    }
    result= [NSData dataWithBytes:(const void *)bufferPtr length:(NSUInteger)movedBytes];
    return result;
}
@end
