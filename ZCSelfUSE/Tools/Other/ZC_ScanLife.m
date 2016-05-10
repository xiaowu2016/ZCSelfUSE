//
//  ZC_ScanLife.m
//  ZCSelfUSE
//
//  Created by zhangchao on 15/12/30.
//  Copyright © 2015年 zhangchao. All rights reserved.
//

#import "ZC_ScanLife.h"

@implementation ZC_ScanLife
+(UIImage *)ScanLifeWithURLString:(NSString *)urlString{
    
    // 1.实例化二维码滤镜
    CIFilter *filter = [CIFilter filterWithName:@"CIQRCodeGenerator"];
    
    // 2.恢复滤镜的默认属性 (因为滤镜有可能保存上一次的属性)
    [filter setDefaults];
    
    // 3.将字符串转换成NSdata
    NSData *data = [urlString dataUsingEncoding:NSUTF8StringEncoding];
    
    // 4.通过KVC设置滤镜, 传入data, 将来滤镜就知道要通过传入的数据生成二维码
    [filter setValue:data forKey:@"inputMessage"];
    
    // 5.生成二维码
    CIImage *outputImage = [filter outputImage];
    
    UIImage *image = [UIImage imageWithCIImage:outputImage];
    
    // 返回二维码生成的图片
    return image;
}
@end
