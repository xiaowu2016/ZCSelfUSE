//
//  ImageUtil.h
//  ZCSelfUSE
//
//  Created by zhangchao on 16/6/2.
//  Copyright © 2016年 zhangchao. All rights reserved.
//


#import <Foundation/Foundation.h>
#import <OpenGLES/ES1/gl.h>
#import <OpenGLES/ES1/glext.h>
#import <UIKit/UIKit.h>


@interface ImageUtil : NSObject
+ (UIImage *)ImageWithImage:(UIImage *)image
            withColorMatrix:(const float *)f;
@end
