//
//  UIImage+Cut.h
//  ZCSelfUSE
//
//  Created by zhangchao on 16/6/2.
//  Copyright © 2016年 zhangchao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Cut)
- (UIImage *)clipImageWithScaleWithSize:(CGSize)size;
- (UIImage *)clipImageWithScaleWithSize:(CGSize)size
                     roundedCornerImage:(NSInteger)roundedCornerImage
                             borderSize:(NSInteger)borderSize;

@end
