//
//  UIImage+RoundedCorner.m
//  ZCSelfUSE
//
//  Created by zhangchao on 16/6/2.
//  Copyright © 2016年 zhangchao. All rights reserved.
//

#import "UIImage+RoundedCorner.h"
#import "UIImage+Alpha.h"

@implementation UIImage (RoundedCorner)
- (UIImage *)roundedCornerImage:(NSInteger)cornerSize borderSize:(NSInteger)borderSize
{
    UIImage *image = [self imageWithAlpha];
    CGContextRef context = CGBitmapContextCreate(NULL, image.size.width, image.size.height, CGImageGetBitsPerComponent(image.CGImage), 0, CGImageGetColorSpace(image.CGImage), CGImageGetBitmapInfo(image.CGImage));
    CGContextBeginPath(context);
    [self addRoundedRectToPath:CGRectMake(borderSize, borderSize, image.size.width - borderSize * 2, image.size.height - borderSize * 2) context:context ovalWith:cornerSize ovalHeight:cornerSize];
    CGContextClosePath(context);
    CGContextClip(context);
    CGContextDrawImage(context, CGRectMake(0, 0, image.size.width, image.size.height), image.CGImage);
    CGImageRef clippedImage = CGBitmapContextCreateImage(context);
    UIImage *roundedImage = [UIImage imageWithCGImage:clippedImage];
    CGContextRelease(context);
    CGImageRelease(clippedImage);
    return roundedImage;
}

- (void)addRoundedRectToPath:(CGRect)rect context:(CGContextRef)context ovalWith:(CGFloat)ovalWidth ovalHeight:(CGFloat)ovalHeight
{
    if(ovalWidth == 0 || ovalHeight == 0)
    {
        CGContextAddRect(context, rect);
        return ;
    }
    CGContextSaveGState(context);
    CGContextTranslateCTM(context, CGRectGetMinX(rect), CGRectGetMinY(rect));
    CGContextScaleCTM(context, ovalWidth, ovalHeight);
    CGFloat fw = CGRectGetWidth(rect) / ovalWidth;
    CGFloat fh = CGRectGetHeight(rect) / ovalHeight;
    CGContextMoveToPoint(context, fw, fh/2);
    CGContextAddArcToPoint(context, fw, fh, fw/2, fh, 1);
    CGContextAddArcToPoint(context, 0, fh, 0, fh/2, 1);
    CGContextAddArcToPoint(context, 0, 0, fw/2, 0, 1);
    CGContextAddArcToPoint(context, fw, 0, fw, fh/2, 1);
    CGContextClosePath(context);
    CGContextRestoreGState(context);
}
@end
