//
//  NSString+ZC_Regex.m
//  RegularExpression
//
//  Created by zhangchao on 16/1/16.
//  Copyright © 2016年 lanou3g. All rights reserved.
//

#import "NSString+ZC_Regex.h"

#define KisEmail @"^([A-Z0-9a-z._]*)+(@[A-Z0-9a-z.]*)+(\\.[A-Z0-9a-z]{2,4})$"

@implementation NSString (ZC_Regex)
/**
 *  判断输入的QQ号是否正确
 *
 *  @return YES/NO;
 */
- (BOOL)isQQ
{
    return [self getIsMatches:@"^[1-9]\\d{4,10}$"];
}
/**
 *  判断输入的性别字符串是否正确
 *
 *  @return YES/NO
 */
- (BOOL)isGender
{
    return [self getIsMatches:@"^[男|女]$"];
}
/**
 *  判断输入的手机号码是否正确
 *
 *  @return YES/NO
 */
- (BOOL)isPhoneNumber
{
    return [self getIsMatches:@"^1[3|5|7|8]\\d{9}$"];
}
/**
 *  判断输入的邮箱是否正确
 *
 *  @return YES/NO
 */
- (BOOL)isEmail
{
    return [self getIsMatches:KisEmail];
}
/**
 *  判断输入的年龄字符串是否正确
 *
 *  @return YES/NO
 */
- (BOOL)isAge
{
    return [self getIsMatches:@"^[1-9]\\d{0,2}$"];
}
/**
 *  通过传的正则表达式来判断字符串是否相符
 *
 *  @param aRegex 匹配字符串
 *
 *  @return YES/NO
 */
- (BOOL)getIsMatches:(NSString *)aRegex
{
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",aRegex];
    return [predicate evaluateWithObject:self];
}
@end
