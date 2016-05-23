//
//  UIView+Masonry_ZC.h
//  ZCButtonControl
//
//  Created by zhangchao on 16/5/23.
//  Copyright © 2016年 zhangchao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Masonry_ZC)
/**
 *  对传入的视图进行水平等间距布局
 *
 *  @param views 传入的视图数组
 */
- (void)distributeSpacingHorizontallyWith:(NSArray*)views;
/**
 *  对传入的视图进行垂直等间距布局
 *
 *  @param views 传入的视图数组
 */
- (void)distributeSpacingVerticallyWith:(NSArray*)views;
@end
