//
//  UIImage+Cut.m
//  ZCSelfUSE
//
//  Created by zhangchao on 16/6/2.
//  Copyright © 2016年 zhangchao. All rights reserved.
//

#import "UIImage+Cut.h"
#import "UIImage+RoundedCorner.h"

@implementation UIImage (Cut)
- (UIImage *)clipImageWithScaleWithSize:(CGSize)size
{
    UIImage *newImage;
    UIImage *image = self;
    if(image == nil)
    {
        newImage = nil;
    }
    else
    {
        CGSize oldsize = image.size;
        CGRect rect;
        if(size.width/size.height > oldsize.width/oldsize.height)
        {
            rect.size.width = size.width;
            rect.size.height = size.width * oldsize.height/oldsize.width;
            rect.origin.x = 0;
            rect.origin.y = (size.height - rect.size.height)/2;
        }
        else
        {
            rect.size.width = size.height * oldsize.width/oldsize.height;
            rect.size.height = size.height;
            rect.origin.x = (size.width - rect.size.width)/2;
            rect.origin.y = 0;
        }
        UIGraphicsBeginImageContext(size);
        CGContextRef context = UIGraphicsGetCurrentContext();
        CGContextClipToRect(context, CGRectMake(0, 0, size.width, size.height));
        CGContextSetFillColorWithColor(context, [UIColor clearColor].CGColor);
        UIRectFill(CGRectMake(0, 0, size.width, size.height));
        [image drawInRect:rect];
        newImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
    }
    return newImage;
}

- (UIImage *)clipImageWithScaleWithSize:(CGSize)size roundedCornerImage:(NSInteger)roundedCornerImage borderSize:(NSInteger)borderSize
{
    UIImage *image = [self clipImageWithScaleWithSize:size];
    return [image roundedCornerImage:roundedCornerImage borderSize:borderSize];
}
@end
