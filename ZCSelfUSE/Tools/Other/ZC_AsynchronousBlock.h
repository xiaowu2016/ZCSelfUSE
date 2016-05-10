//
//  ZC_AsynchronousBlock.h
//  ZCSelfUSE
//
//  Created by zhangchao on 15/12/23.
//  Copyright © 2015年 zhangchao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

//作用是用来传递已经下载好的 image （传值用)
typedef void(^MyDownloadBlock)(UIImage *image);
//作用是用来传递已经解析出来的data (传回一个二进制数据对象)
typedef void(^MyAsynchronousBlock)(NSData *data);


@interface ZC_AsynchronousBlock : NSObject

/*
 根据url下载图片并且用block返回一个图片
 urlString  是图片地址
 passBlock: 用来传递图片
 */
+ (void)downloadImageWithURLString:(NSString *)urlString PassBlock:(MyDownloadBlock)passBlock;


/**
 *  异步POST方法，根据url解析得到二进制数据对象
 *
 *  @param urlString  数据的接口
 *  @param bodyString  请求的内容
 *  @param passBlock  用来传递Data对象
 */
+ (void)asynchronousPOSTWithURLString:(NSString *)urlString bodyString:(NSString *)bodyString PassBlock:(MyAsynchronousBlock)passBlock;


/**
 *  异步GET方法，根据url解析得到二进制数据对象
 *
 *  @param urlString 数据的接口
 *  @param passBlock 用来传递data对象
 */
+(void)asynchronousGETWithURLString:(NSString *)urlString PassBlock:(MyAsynchronousBlock)passBlock;

/**
 *  异步POST方法 根据传入的参数得到融云ToKen
 *
 *  @param urlString Url网址，融云官方提供
 *  @param appKey    融云上创建的应用AppKey
 *  @param appSecret 融云上创建的应用的AppSecret
 *  @param body      由用户名密码和用户头像生成的NSData数据(请求的内容)
 *  @param passBlock 用来传递data对象，通过BLOCK回调来得到ToKen
 */
+ (void)asynchronousPOSTWithURLString:(NSString *)urlString AppKey:(NSString *)appKey AppSecret:(NSString *)appSecret body:(NSData *)body PassBlock:(MyAsynchronousBlock)passBlock;

/**
 *  通过传入的字典来生成一个NSData数据
 *
 *  @param param 传入的字典对象
 *
 *  @return 需要的NSData对象
 */
+ (NSData *)httpBodyFromParamDictionary:(NSDictionary *)param;
@end
