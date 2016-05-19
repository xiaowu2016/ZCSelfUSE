//
//  NSString+ZC_Regex.h
//  ZCSelfUSE
//
//  Created by zhangchao on 16/1/16.
//  Copyright © 2016年 lanou3g. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (ZC_Regex)
/**
 *  判断输入的QQ号是否正确
 *
 *  @return YES/NO;
 */
- (BOOL)isQQ;
/**
 *  判断输入的性别字符串是否正确
 *
 *  @return YES/NO
 */
- (BOOL)isGender;
/**
 *  判断输入的手机号码是否正确
 *
 *  @return YES/NO
 */
- (BOOL)isPhoneNumber;
/**
 *  判断输入的邮箱是否正确
 *
 *  @return YES/NO
 */
- (BOOL)isEmail;
/**
 *  判断输入的年龄字符串是否正确
 *
 *  @return YES/NO
 */
- (BOOL)isAge;
/**
 *  通过传的正则表达式来判断字符串是否相符
 *
 *  @param aRegex 匹配字符串
 *
 *  @return YES/NO
 */
- (BOOL)getIsMatches:(NSString *)aRegex;
/**
 *  判断输入的身份证是否正确
 *
 *  @param sPaperId 身份证
 *
 *  @return YES/NO
 */
+ (BOOL)isValidateID:(NSString *)sPaperId;
@end
