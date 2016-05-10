//
//  ZC_AsynchronousBlock.m
//  ZCSelfUSE
//
//  Created by zhangchao on 15/12/23.
//  Copyright © 2015年 zhangchao. All rights reserved.
//

#import "ZC_AsynchronousBlock.h"

@implementation ZC_AsynchronousBlock
+ (void)downloadImageWithURLString:(NSString *)urlString PassBlock:(MyDownloadBlock)passBlock
{
    //创建下载图片的任务
    NSURLSessionDownloadTask *downloadTask = [[NSURLSession sharedSession] downloadTaskWithURL:[NSURL URLWithString:urlString] completionHandler:^(NSURL * _Nullable location, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        //将得到的图片地址转换成二进制类型
        NSData *data = [NSData dataWithContentsOfURL:location];
        //将二进制类型的图片对象转换成图片
        UIImage *image = [UIImage imageWithData:data];
        dispatch_async(dispatch_get_main_queue(), ^{
            //利用passBlock传值
            passBlock(image);
        });
    }];
    [downloadTask resume];
    
}


//异步POST方法
+ (void)asynchronousPOSTWithURLString:(NSString *)urlString bodyString:(NSString *)bodyString PassBlock:(MyAsynchronousBlock)passBlock
{
    //1.创建URL
    NSURL *url = [NSURL URLWithString:urlString];
    //2.创建请求对象
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    //3.设置请求方式
    [request setHTTPMethod:@"POST"];
    //4.设置请求的内容
    NSData *bodyData = [bodyString dataUsingEncoding:NSUTF8StringEncoding];
    [request setHTTPBody:bodyData];
    //5.创建会话
    NSURLSession *session = [NSURLSession sharedSession];
    //6.创建数据处理的任务
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        NSData *da = data;
        dispatch_async(dispatch_get_main_queue(), ^{
            //利用passBlock传值
            passBlock(da);
        });
        
    }];
    [dataTask resume];
}

//异步GET方法
+(void)asynchronousGETWithURLString:(NSString *)urlString PassBlock:(MyAsynchronousBlock)passBlock
{
    //1.创建URL
    NSURL *url = [NSURL URLWithString:urlString];
    //5.创建会话
    NSURLSession *session = [NSURLSession sharedSession];
    //6.创建数据处理的任务
    NSURLSessionDataTask *dataTask = [session dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        NSData *da = data;
        dispatch_async(dispatch_get_main_queue(), ^{
            //利用passBlock传值
            passBlock(da);
        });
    }];
    [dataTask resume];
}

+ (void)asynchronousPOSTWithURLString:(NSString *)urlString AppKey:(NSString *)appKey AppSecret:(NSString *)appSecret body:(NSData *)body PassBlock:(MyAsynchronousBlock)passBlock
{
    //获取一个随机标志
    NSString * nonce = [NSString stringWithFormat:@"%d",arc4random()];
    //获取时间戳
    NSString * timestamp = [[NSString alloc] initWithFormat:@"%.0f",[NSDate timeIntervalSinceReferenceDate]];
    //创建URL
    NSURL *url = [NSURL URLWithString:urlString];
    //创建请求对象
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    //设置请求超时时间
    request.timeoutInterval = 10;
    
    //配置http header
    [request setValue:appKey forHTTPHeaderField:@"App-Key"];
    [request setValue:nonce forHTTPHeaderField:@"Nonce"];
    [request setValue:timestamp forHTTPHeaderField:@"Timestamp"];
    [request setValue:appSecret forHTTPHeaderField:@"appSecret"];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    //设置HTTPBody
    [request setHTTPBody:body];
    //设置请求方式
    [request setHTTPMethod:@"POST"];
    //创建会话
    NSURLSession *session = [NSURLSession sharedSession];
    //创建数据处理的任务
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        NSData *da = data;
        dispatch_async(dispatch_get_main_queue(), ^{
            //利用passBlock传值
            passBlock(da);
        });
    }];
    [dataTask resume];
}

/**
 *  通过传入的字典来生成一个NSData数据
 *
 *  @param param 传入的字典对象
 *
 *  @return 需要的NSData对象
 */
+ (NSData *)httpBodyFromParamDictionary:(NSDictionary *)param
{
    NSMutableString * data = [NSMutableString string];
    for (NSString * key in param.allKeys) {
        [data appendFormat:@"%@=%@&",key,param[key]];
    }
    return [[data substringToIndex:data.length-1] dataUsingEncoding:NSUTF8StringEncoding];
}
@end
