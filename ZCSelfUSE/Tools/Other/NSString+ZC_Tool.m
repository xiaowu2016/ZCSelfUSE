//
//  NSString+ZC_Tool.m
//  ZCSelfUSE
//
//  Created by zhangchao on 16/5/18.
//  Copyright © 2016年 zhangchao. All rights reserved.
//

#import "NSString+ZC_Tool.h"

@implementation NSString (ZC_Tool)
//***汉字转拼音***/
+ (NSString *)transform:(NSString *)chinese{
    //将NSString装换成NSMutableString
    NSMutableString *pinyin = [chinese mutableCopy];
    //将汉字转换为拼音(带音标)
    CFStringTransform((__bridge CFMutableStringRef)pinyin, NULL, kCFStringTransformMandarinLatin, NO);
    //去掉拼音的音标
    CFStringTransform((__bridge CFMutableStringRef)pinyin, NULL, kCFStringTransformStripCombiningMarks, NO);
    //返回最近结果
    return pinyin;
}
//***16进制字符串转换为普通字符串***/
+ (NSString *)stringFromHexString:(NSString *)hexString { //
    char *myBuffer = (char *)malloc((int)[hexString length] / 2 + 1);
    bzero(myBuffer, [hexString length] / 2 + 1);
    for (int i = 0; i < [hexString length] - 1; i += 2) {
        unsigned int anInt;
        NSString * hexCharStr = [hexString substringWithRange:NSMakeRange(i, 2)];
        NSScanner * scanner = [[NSScanner alloc] initWithString:hexCharStr] ;
        [scanner scanHexInt:&anInt];
        myBuffer[i / 2] = (char)anInt;
    }
    NSString *unicodeString = [NSString stringWithCString:myBuffer encoding:4];
    free(myBuffer);
    return unicodeString;
}
//***普通字符串转换为16进制字符串***/
+ (NSString *)hexStringFromString:(NSString *)string{
    NSData *myD = [string dataUsingEncoding:NSUTF8StringEncoding];
    Byte *bytes = (Byte *)[myD bytes];
    //下面是Byte 转换为16进制。
    NSString *hexStr=@"";
    for(int i=0;i<[myD length];i++)
    {
        NSString *newHexStr = [NSString stringWithFormat:@"%x",bytes[i]&0xff];///16进制数
        if([newHexStr length]==1)
            hexStr = [NSString stringWithFormat:@"%@0%@",hexStr,newHexStr];
        else
            hexStr = [NSString stringWithFormat:@"%@%@",hexStr,newHexStr];
    }
    return hexStr;
}
//***数据转换为16进制字符串***/
+(NSString *)hexStringFromData:(NSData *)data{
    unsigned char * cc=(unsigned char*)[data bytes];
    NSString * hexStr=@"";
    for(int i=0;i<[data length];i++)
    {
        hexStr=[hexStr stringByAppendingString:[NSString stringWithFormat:@"%02X",cc[i]]];
    }
    return hexStr;
}
//***16进制字符串转换为数据***/
+(NSData *)dataFromHexString:(NSString*)hexString{
    if (hexString==nil||[hexString length]==0) {
        return nil;
    }
    char * myBuffer=(char *)malloc((int)[hexString length] / 2 + 1);
    bzero(myBuffer, [hexString length] / 2 + 1);
    for (int i = 0; i < [hexString length] - 1; i += 2) {
        unsigned int anInt;
        NSString * hexCharStr = [hexString substringWithRange:NSMakeRange(i, 2)];
        NSScanner * scanner = [[NSScanner alloc] initWithString:hexCharStr] ;
        [scanner scanHexInt:&anInt];
        myBuffer[i / 2] = (char)anInt;
    }
    NSMutableData * data=[NSMutableData dataWithBytes:myBuffer length:[hexString length]/2];
    free(myBuffer);
    return data;
}
//***取字符串从特定位置开始的特定长度的字串***/
+ (NSString *)substr:(NSString*)string start:(int)start length:(int)length{
    if (string.length<start+length) {
        return nil;
    }
    return [string substringWithRange:NSMakeRange(start, length)];
}
//***取字符串从指定位置开始到结束的子串***/
+ (NSString *)substr:(NSString*)string start:(int)start{
    if (string.length<start) {
        return nil;
    }
    return [string substringFromIndex:start];
}
//**取从指定位置开始的指定长度的数据,并转换字符串***/
+ (NSString *)subdataToString:(NSData *)data start:(int)start length:(int)length{
    NSData * sub=[NSString subdata:data start:start length:length] ;
    return [[NSString alloc]initWithData:sub encoding:NSUTF8StringEncoding];
}
//***从字符串中取得以指定字符串为分隔符的数组***/
+ (NSArray *)split:(NSString *)string token:(NSString *)token{
    return [string componentsSeparatedByString:token];
}
//***将字符串中的指定字符串替换为另一字符串****/
+ (NSString *)replace:(NSString *)string src:(NSString *)src replaceWith:(NSString *)replaceWith{
    return [string stringByReplacingOccurrencesOfString:src withString:replaceWith];
}
//***取得字符串中分隔符左边的字符串***/
+ (NSString *)removeright:(NSString *)string token:(NSString *)token{
    NSRange range=[string rangeOfString:token];
    if (range.location==NSNotFound) {
        return string;
    }
    return [string substringToIndex:range.location];
}
//***取得字符串中分隔符右边的字符串***/
+ (NSString *)removeleft:(NSString *)string token:(NSString *)token{
    NSRange range=[string rangeOfString:token];
    if (range.location==NSNotFound) {
        return string;
    }
    return [string substringFromIndex:range.location+range.length];
}
//***在字符串中取以指定字符串开始到指定字符串结束的字串***/
+ (NSString*)between:(NSString *)string begin:(NSString *)begin end:(NSString *)end{
    NSRange range_begin=[string rangeOfString:begin];
    if (range_begin.location!=NSNotFound) {
        NSString * right=[string substringFromIndex:range_begin.location+range_begin.length];
        NSRange range_end=[right rangeOfString:end];
        if (range_end.location!=NSNotFound) {
            NSString*ret=[right substringToIndex:range_end.location];
            return ret;
        }
    }
    return @"";
}
//***将以分为单位的字符串转换为以元为单位的字符串***/
+ (NSString *)FenToYuan:(NSString *)string{
    if (string==nil)
        return @"";
    long long int number = [string longLongValue];
    float f = number/100.0f;
    NSString * balance = [NSString stringWithFormat:@"%.2f", f];
    return balance;
}
//***判断字符串中是否包含指定字符串***/
+ (BOOL)containString:(NSString *)string sub:(NSString *)sub{
    NSRange range = [string rangeOfString:sub];
    return range.location != NSNotFound;
}
//***将字符串转换为C语言字符***/
+ (const char *)toCString:(NSString *)string{
    return [string cStringUsingEncoding:NSASCIIStringEncoding];
}
//***将C字符转换为OC字符串***/
+ (NSString *)toString:(const char *)cstring{
    NSString *string_content = [[NSString alloc] initWithCString:cstring
                                                        encoding:NSASCIIStringEncoding];
    return string_content;
}

//卡号每4个字节补空格
+ (NSString *)getPatternCardNumber:(NSString *)cardnumber{
    if (cardnumber==nil) {
        return nil;
    }
    //去空格
    cardnumber= [NSString replace:cardnumber src:@" " replaceWith:@""];
    NSMutableString * patternCardNumber=[[NSMutableString alloc]init];
    for (int i=0; i<cardnumber.length; i+=4) {
        int length=4;
        if (i+4>cardnumber.length) {
            length=(int)cardnumber.length-i;
        }
        [patternCardNumber appendString:[NSString substr:cardnumber start:i length:length]];
        [patternCardNumber appendString:@" "];
    }
    if ([patternCardNumber hasSuffix:@" "]) {
        cardnumber=[NSString substr:patternCardNumber start:0 length:(int)patternCardNumber.length-1];//去除最后一个空格
    }
    return cardnumber;
}
//***取从指定位置开始的指定长度的数据***/
+ (NSData *)subdata:(NSData *)data start:(int)start length:(int)length
{
    return [data subdataWithRange:NSMakeRange(start, length)];
}
//***取从指定位置开始到结束的数据***/
+ (NSData *)subdata:(NSData *)data start:(int)start{
    if (start>=data.length) {
        return nil;
    }
    return [data subdataWithRange:NSMakeRange(start, [data length]-start)];
}
@end
