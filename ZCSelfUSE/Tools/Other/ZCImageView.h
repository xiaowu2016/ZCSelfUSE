//
//  ZCImageView.h
//  ZCSelfUSE
//
//  Created by zhangchao on 16/4/18.
//  Copyright © 2016年 icfcc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZCImageView : UIImageView
{
    id _target;
    SEL _action;
}
-(void)MyTarget:(id)target Action:(SEL)action;
@end
