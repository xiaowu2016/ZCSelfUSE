//
//  ImageUtil.m
//  ZCSelfUSE
//
//  Created by zhangchao on 16/6/2.
//  Copyright © 2016年 zhangchao. All rights reserved.
//

#import "ImageUtil.h"

@implementation ImageUtil
// 返回一个使用RGBA通道的位图上下文
static CGContextRef CreateRGBABitmapContext(CGImageRef image)
{
    CGContextRef context = NULL;
    CGColorSpaceRef colorSpace;
    //内存空间的指针，该内存空间的大小等于图像使用RGB通道所占用的字节数。
    void *bitmapData;
    int bitmapByteCount;
    int bitmapBytesPerRow;
    //获取横向的像素点的个数
    size_t pixelsWide = CGImageGetWidth(image);
    //纵向
    size_t pixelsHigh = CGImageGetHeight(image);
    //每一行的像素点占用的字节数，每个像素点的ARGB四个通道各占8个bit(0-255)的空间
    bitmapBytesPerRow = (int)(pixelsWide * 4);
    //计算整张图占用的字节数
    bitmapByteCount = (int)(bitmapBytesPerRow * pixelsHigh);
    //创建依赖于设备的RGB通道
    colorSpace = CGColorSpaceCreateDeviceRGB();
    //分配足够容纳图片字节数的内存空间
    bitmapData = malloc(bitmapByteCount);
    //创建CoreGraphic的图形上下文，该上下文描述了bitmaData指向的内存空间需要绘制的图像的一些绘制参数
    context = CGBitmapContextCreate(bitmapData, pixelsWide, pixelsHigh, 8, bitmapBytesPerRow, colorSpace, kCGImageAlphaPremultipliedLast);
    //Core Foundation中通过含有Create、Alloc的方法名字创建的指针，需要使用CFRelease()函数释放
    CGColorSpaceRelease(colorSpace);
    return context;
}

// 返回一个指针，该指针指向一个数组，数组中的每四个元素都是图像上的一个像素点的RGBA的数值(0-255)，用无符号的char是因为它正好的取值范围就是0-255
static unsigned char * RequestImagePixeDate(UIImage *image)
{
    CGImageRef img = [image CGImage];
    CGSize size = [image size];
    //创建上下文
    CGContextRef cgctx = CreateRGBABitmapContext(img);
    CGRect rect = {{0,0},{size.width,size.height}};
    //将目标图像绘制到指定的上下文，实际为上下文内的bitmapData。
    CGContextDrawImage(cgctx, rect, img);
    unsigned char *data = CGBitmapContextGetData(cgctx);
    CGContextRelease(cgctx);
    return data;
}

//修改RGB的值
static void chargeRGBA(int *red,int *green,int *blue,int *alpha,const float *f)
{
    int redV = *red;
    int greenV = *green;
    int blueV = *blue;
    int alphaV = *alpha;
    
    *red = f[0] * redV + f[1] * greenV + f[2] * blueV + f[3] * alphaV + f[4];
    *green = f[0+5] * redV + f[1+5] * greenV + f[2+5] * blueV + f[3+5] * alphaV + f[4+5];
    *blue = f[0+5*2] * redV + f[1+5*2] * greenV + f[2+5*2] * blueV + f[3+5*2] * alphaV + f[4+5*2];
    *alpha = f[0+5*3] * redV + f[1+5*3] * greenV + f[2+5*3] * blueV + f[3+5*3] * alphaV + f[4+5*3];
    *red = *red > 255 ? 255 : *red;
    *red = *red < 0 ? 0 : *red;
    *green = *green > 255 ? 255 : *green;
    *green = *green < 0 ? 0 : *green;
    *blue = *blue > 255 ? 255 : *blue;
    *blue = *blue < 0 ? 0 : *blue;
    *alpha = *alpha > 255 ? 255 : *alpha;
    *alpha = *alpha < 0 ? 0 : *alpha;
}

+ (UIImage *)ImageWithImage:(UIImage *)image withColorMatrix:(const float *)f
{
    unsigned char *imgPixel = RequestImagePixeDate(image);
    CGImageRef inImageRef = [image CGImage];
    GLuint w = (GLuint)CGImageGetWidth(inImageRef);
    GLuint h = (GLuint)CGImageGetHeight(inImageRef);
    
    int wOff = 0;
    int pixOff = 0;
    
    
    for(GLuint y = 0;y< h;y++)//双层循环按照长宽的像素个数迭代每个像素点
    {
        pixOff = wOff;
        
        for (GLuint x = 0; x<w; x++)
        {
            int red = (unsigned char)imgPixel[pixOff];
            int green = (unsigned char)imgPixel[pixOff+1];
            int blue = (unsigned char)imgPixel[pixOff+2];
            int alpha = (unsigned char)imgPixel[pixOff+3];
            chargeRGBA(&red, &green, &blue, &alpha, f);
            
            //回写数据
            imgPixel[pixOff] = red;
            imgPixel[pixOff+1] = green;
            imgPixel[pixOff+2] = blue;
            imgPixel[pixOff+3] = alpha;
            
            //将数组的索引指向下四个元素
            pixOff += 4;
        }
        
        wOff += w * 4;
    }
    
    NSInteger dataLength = w * h * 4;
    
    //下面的代码创建要输出的图像的相关参数
    CGDataProviderRef provider = CGDataProviderCreateWithData(NULL, imgPixel, dataLength, NULL);
    
    int bitsPerComponent = 8;
    int bitsPerPixel = 32;
    int bytesPerRow = 4 * w;
    CGColorSpaceRef colorSpaceRef = CGColorSpaceCreateDeviceRGB();
    CGBitmapInfo bitmapInfo = kCGBitmapByteOrderDefault;
    CGColorRenderingIntent renderingIntent = kCGRenderingIntentDefault;
    //创建要输出的图像
    CGImageRef imageRef = CGImageCreate(w, h, bitsPerComponent, bitsPerPixel, bytesPerRow,colorSpaceRef, bitmapInfo, provider, NULL, NO, renderingIntent);
    
    UIImage *myImage = [UIImage imageWithCGImage:imageRef];
    
    CFRelease(imageRef);
    CGColorSpaceRelease(colorSpaceRef);
    CGDataProviderRelease(provider);
    return myImage;
}
@end
