//
//  UIView+Masonry_ZC.m
//  ZCButtonControl
//
//  Created by zhangchao on 16/5/23.
//  Copyright © 2016年 zhangchao. All rights reserved.
//

#import "UIView+Masonry_ZC.h"
#import "Masonry.h"

@implementation UIView (Masonry_ZC)

- (void)distributeSpacingHorizontallyWith:(NSArray*)views
{
    UIView *firstView = views[0];
    //设置第一个视图距左距上为零
    [firstView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.bottom.equalTo(self);
        make.left.equalTo(self);
    }];
    
    UIView *lastView;
    for (int i = 1; i < views.count; i++) {
        
        if (!lastView) {
            
            lastView = firstView;
        }
        UIView *view = views[i];
        
        [view mas_makeConstraints:^(MASConstraintMaker *make) {
            //设置所有视图的左边等于上一视图的右边
            make.left.equalTo(lastView.mas_right);
            //设置所有视图等宽，同上同下
            make.width.top.bottom.equalTo(lastView);
            if (i == views.count - 1) {
                //最后一个视图的右边距父视图右边为零
                make.right.equalTo(self);
            }
        }];
        
        lastView = view;
    }
    [firstView mas_makeConstraints:^(MASConstraintMaker *make) {
        //设置第一个视图与最后一个视图等宽
        make.width.equalTo(lastView);
    }];
    
    [self layoutSubviews];
}

- (void)distributeSpacingVerticallyWith:(NSArray*)views
{
    NSMutableArray *spaces = [NSMutableArray arrayWithCapacity:views.count+1];
    for ( int i = 0 ; i < views.count+1 ; ++i )
    {
        UIView *v = [UIView new];
        [spaces addObject:v];
        [self addSubview:v];
        
        [v mas_makeConstraints:^(MASConstraintMaker *make) {
            //设置所有视图等宽等高
            make.width.equalTo(v.mas_height);
        }];
    }
    
    UIView *v0 = spaces[0];
    
    __weak __typeof(&*self)ws = self;
    
    [v0 mas_makeConstraints:^(MASConstraintMaker *make) {
        //设置第一个视图距父视图顶部距离为0
        make.top.equalTo(ws.mas_top);
        //设置第一个视图中心点X座标位置
        make.centerX.equalTo(((UIView*)views[0]).mas_centerX);
    }];
    
    UIView *lastSpace = v0;
    for ( int i = 0 ; i < views.count; ++i )
    {
        UIView *obj = views[i];
        UIView *space = spaces[i+1];
        
        [obj mas_makeConstraints:^(MASConstraintMaker *make) {
            //设置所有视图的顶部距上一视图底部距离为零
            make.top.equalTo(lastSpace.mas_bottom);
        }];
        
        [space mas_makeConstraints:^(MASConstraintMaker *make) {
            //设置所有视图的顶部距上一视图底部距离为零
            make.top.equalTo(obj.mas_bottom);
            //设置所有视图的中心点X座标位置相等
            make.centerX.equalTo(obj.mas_centerX);
            //设置所有视图等高
            make.height.equalTo(v0);
        }];
        
        lastSpace = space;
    }
    
    [lastSpace mas_makeConstraints:^(MASConstraintMaker *make) {
        //最后一个视图底部等于父视图的底部
        make.bottom.equalTo(ws.mas_bottom);
    }];
}
@end
