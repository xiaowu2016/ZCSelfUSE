//
//  UIImage+RoundedCorner.h
//  ZCSelfUSE
//
//  Created by zhangchao on 16/6/2.
//  Copyright © 2016年 zhangchao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (RoundedCorner)
- (UIImage *)roundedCornerImage:(NSInteger)cornerSize
                     borderSize:(NSInteger)borderSize;
- (void)addRoundedRectToPath:(CGRect)rect
                     context:(CGContextRef)context
                    ovalWith:(CGFloat)ovalWidth
                  ovalHeight:(CGFloat)ovalHeight;
@end
