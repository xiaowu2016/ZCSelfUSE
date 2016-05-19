//
//  NSString+ZC_Tool.h
//  ZCSelfUSE
//
//  Created by zhangchao on 16/5/18.
//  Copyright © 2016年 zhangchao. All rights reserved.
//

#import <Foundation/Foundation.h>

//此类主要是方便程序员编写代码，与其他语言的语法类似
//特殊的字符串转换

@interface NSString (ZC_Tool)
/**
 *  汉字转拼音
 *
 *  @param chinese 汉字
 *
 *  @return 拼音
 */
+ (NSString *)transform:(NSString *)chinese;
/**
 *  生成16位长的随机数字符串
 *
 *  @return 随机数字符串
 */
+ (NSString *)Rand16;
/**
 *  16进制字符串转为字符串
 *
 *  @param hexString 16进制字符串
 *
 *  @return 转换后的字符串
 */
+ (NSString *)stringFromHexString:(NSString *)hexString;
/**
 *  字符串转为16进制字符串
 *
 *  @param string 字符串
 *
 *  @return 转换后的字符串
 */
+ (NSString *)hexStringFromString:(NSString *)string;
/**
 *  数据转换为16进制字符串
 *
 *  @param data 数据
 *
 *  @return 转换后的字符串
 */
+ (NSString *)hexStringFromData:(NSData *)data;
/**
 *  16进制字符串转换为数据
 *
 *  @param hexString 16进制字符串
 *
 *  @return 转换后的数据
 */
+ (NSData *)dataFromHexString:(NSString *)hexString;
#pragma mark---subString的简化
/**
 *  取字符串从指定位置开始的指定长度的子串
 *
 *  @param string 字符串
 *  @param start  开始位置
 *  @param length 长度
 *
 *  @return 子串
 */
+ (NSString *)substr:(NSString *)string start:(int)start length:(int)length;
/**
 *  取字符串从指定位置开始到结束的子串
 *
 *  @param string 字符串
 *  @param start  开始位置
 *
 *  @return 子串
 */
+ (NSString *)substr:(NSString *)string start:(int)start;
/**
 *  取从指定位置开始的指定长度的数据,并转换字符串
 *
 *  @param data   主数据
 *  @param start  起始位置
 *  @param length 长度
 *
 *  @return 截取后数据转换的字符串
 */
+ (NSString *)subdataToString:(NSData *)data start:(int)start length:(int)length;
/**
 *  从字符串中取得以指定字符串为分隔符的数组
 *
 *  @param string 主字符串
 *  @param token  指定的分隔符
 *
 *  @return 被分隔开的字符串数组
 */
+ (NSArray *)split:(NSString *)string token:(NSString *)token;
/**
 *  将字符串中的指定字符串替换为另一字符串
 *
 *  @param string       主字符串
 *  @param src         指定字符串
 *  @param replaceWith 用来替换的字符串
 *
 *  @return 替换后的字符串
 */
+ (NSString *)replace:(NSString *)string src:(NSString *)src replaceWith:(NSString *)replaceWith;
/**
 *  取得字符串中分隔符左边的字符串
 *
 *  @param string 主字符串
 *  @param token  分隔符
 *
 *  @return 得到的字符串
 */
+ (NSString *)removeright:(NSString *)string token:(NSString *)token;
/**
 *  取得字符串中分隔符右边的字符串
 *
 *  @param string 主字符串
 *  @param token  分隔符
 *
 *  @return 得到的字符串
 */
+ (NSString *)removeleft:(NSString *)string token:(NSString *)token;
/**
 *  在字符串中取以指定字符串开始到指定字符串结束的子串
 *
 *  @param string 主字符串
 *  @param begin  起始字符串
 *  @param end    结束字符串
 *
 *  @return 得到的子串
 */
+ (NSString *)between:(NSString *)string begin:(NSString *)begin end:(NSString *)end;
/**
 *  将以分为单位的字符串转换为以元为单位的字符串
 *
 *  @param string 以分为单位的字符串
 *
 *  @return 以元为单位的字符串
 */
+ (NSString *)FenToYuan:(NSString *)string;
/**
 *  判断字符串中是否包含指定字符串
 *
 *  @param string 主字符串
 *  @param sub    指定字符串
 *
 *  @return YES/NO
 */
+ (BOOL)containString:(NSString *)string sub:(NSString *)sub;
/**
 *  将字符串转换为C语言字符
 *
 *  @param string 主字符串
 *
 *  @return C字符
 */
+ (const char *)toCString:(NSString *)string;
/**
 *  将C字符转换为OC字符串
 *
 *  @param cstring C字符
 *
 *  @return OC字符串
 */
+ (NSString *)toString:(const char *)cstring;
/**
 *  卡号每4个字节补空格
 *
 *  @param cardnumber 卡号
 *
 *  @return 加空格后的卡号
 */
+ (NSString *)getPatternCardNumber:(NSString *)cardnumber;
/**
 *  取从指定位置开始的指定长度的数据
 *
 *  @param data   主数据
 *  @param start  起始位置
 *  @param length 长度
 *
 *  @return 截取后的数据
 */
+ (NSData *)subdata:(NSData *)data start:(int)start length:(int)length;
/**
 *  取从指定位置开始到结束的数据
 *
 *  @param data  主数据
 *  @param start 起始位置
 *
 *  @return 截取后的数据
 */
+ (NSData *)subdata:(NSData *)data start:(int)start;
#pragma mark 关于时间
/**
 *  根据format指定格式【yyyy MM dd hh:mm:ss:SSS】生成当前时间
 *
 *  @param format 格式
 *
 *  @return 生成的时间字符串
 */
+ (NSString *)Now:(NSString *)format;
/**
 *  获取当前时间的毫秒字符串
 *
 *  @return 生成的时间字符串
 */
+ (NSString *)MillSeconds;
/**
 *  时间戳
 *
 *  @return 返回时间戳
 */
+ (NSString *)TimeSp;
#pragma mark file
/**
 *  读取指定路径文件内容
 *
 *  @param path 相对Document的路径
 *
 *  @return 文件的所有内容
 */
+ (NSData *)ReadFromDocumentPath:(NSString *)path;
/**
 *  在Document目录下写入文件
 *
 *  @param path    相对Document的路径
 *  @param content 需要写入的内容
 *
 *  @return 写入成功与否
 */
+ (BOOL)WriteToDocumentPath:(NSString *)path content:(NSData *)content;
/**
 *  在Document目录下写入文件
 *
 *  @param path    相对Document的路径
 *  @param content 需要写入的内容
 *
 *  @return 写入成功与否
 */
+ (BOOL)WriteStringToDocumentPath:(NSString *)path content:(NSString *)content;
/**
 *  删除Document目录下的文件
 *
 *  @param path 相对Document的路径
 *
 *  @return 删除是否成功
 */
+ (BOOL)RemoveFromDocumentPath:(NSString *)path;
/**
 *  在指定路径下写入内容
 *
 *  @param path    指定路径
 *  @param content 内容
 *
 *  @return 是否写入成功
 */
+ (BOOL)Write:(NSString *)path content:(NSData *)content;
/**
 *  判断指定文件是否存在
 *
 *  @param path 指定路径
 *
 *  @return 是否存在
 */
+ (BOOL)Exist:(NSString *)path;
/**
 *  删除指定路径文件
 *
 *  @param path 指定路径
 *
 *  @return 是否成功
 */
+ (BOOL)Remove:(NSString *)path;
/**
 *  获取目录下的所有文件
 *
 *  @param path 指定目录
 *
 *  @return 文件列表
 */
+ (NSArray *)GetFileList:(NSString *)path;
/**
 *  获取文件夹大小
 *
 *  @param folderPath 文件夹路径
 *
 *  @return 大小
 */
+ (float)folderSizeAtPath:(NSString *) folderPath;
/**
 *  获取文件大小
 *
 *  @param filePath 文件路径
 *
 *  @return 大小
 */
+ (float)fileSizeAtPath:(NSString *)filePath;
@end
