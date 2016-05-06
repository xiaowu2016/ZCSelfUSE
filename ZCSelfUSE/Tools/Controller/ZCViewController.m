//
//  ZCViewController.m
//  ZCAlertFrame
//
//  Created by zhangchao on 16/5/5.
//  Copyright © 2016年 zhangchao. All rights reserved.
//

#import "ZCViewController.h"

#define kWidth [UIScreen mainScreen].bounds.size.width
#define kHeight [UIScreen mainScreen].bounds.size.height

@interface ZCViewController ()

@end

@implementation ZCViewController

//创建只有一个按钮的弹框，并在点击时做某些事情
- (void)showAlertOneButtonWithTitle:(NSString *)title AndMessage:(NSString *)message AndAlertStyle:(UIAlertControllerStyle)style AndOneButtonTittle:(NSString *)oneTitle AndBlock:(BLOCK)block
{
    UIAlertController *ZCAlert = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:style];
    UIAlertAction *oneAction = [UIAlertAction actionWithTitle:oneTitle style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        if(block)
        {
            block();
        }
    }];
    [ZCAlert addAction:oneAction];
    [self presentViewController:ZCAlert animated:YES completion:nil];
}

//创建有两个按钮的弹框，两个按钮都自定义,并在点击这两个按钮时做某些事情
- (void)showAlertTwoButtonWithTitle:(NSString *)title AndMessage:(NSString *)message AndAlertStyle:(UIAlertControllerStyle)style AndOneButtonTitle:(NSString *)oneTitle AndTwoButtonTitle:(NSString *)twoTitle AndOneBlock:(BLOCK)oneBlock AndTwoBlock:(BLOCK)twoBlock
{
    UIAlertController *ZCAlert = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:style];
    UIAlertAction *oneAction = [UIAlertAction actionWithTitle:oneTitle style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        if(oneBlock)
        {
            oneBlock();
        }
    }];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:twoTitle style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        if(twoBlock)
        {
            twoBlock();
        }
    }];
    [ZCAlert addAction:oneAction];
    [ZCAlert addAction:cancelAction];
    [self presentViewController:ZCAlert animated:YES completion:nil];
}

//创建有三个按钮的弹框，三个按钮都自定义,并在点击这些按钮时做某些事情
- (void)showAlertThreeButtonWithTitle:(NSString *)title AndMessage:(NSString *)message AndAlertStyle:(UIAlertControllerStyle)style AndOneButtonTitle:(NSString *)oneTitle AndTwoButtonTitle:(NSString *)twoTitle AndThreeButtonTitle:(NSString *)threeTitle AndOneBlock:(BLOCK)oneBlock AndTwoBlock:(BLOCK)twoBlock AndThreeBlock:(BLOCK)threeBlock
{
    UIAlertController *ZCAlert = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:style];
    UIAlertAction *oneAction = [UIAlertAction actionWithTitle:oneTitle style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        if(oneBlock)
        {
            oneBlock();
        }
    }];
    UIAlertAction *twoAction = [UIAlertAction actionWithTitle:twoTitle style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        if(twoBlock)
        {
            twoBlock();
        }
    }];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:threeTitle style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        if(threeBlock)
        {
            threeBlock();
        }
    }];
    [ZCAlert addAction:oneAction];
    [ZCAlert addAction:twoAction];
    [ZCAlert addAction:cancelAction];
    [self presentViewController:ZCAlert animated:YES completion:nil];
}

//创建一个弹框，可以自行定义有多少个按钮，但是需要传入按钮的title，并且每个按钮都可以定义一个BLOCK放到BLOCK数组中，在BLOCK中做自己想做的事
- (void)showAlertWithWithTitle:(NSString *)title AndMessage:(NSString *)message AndAlertStyle:(UIAlertControllerStyle)style AndButtonString:(NSArray *)array AndBlockArray:(NSArray<BLOCK> *)blockArray
{
    UIAlertController *ZCAlert = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:style];
    for(int i = 0; i < array.count; i++)
    {
        UIAlertAction *action = [UIAlertAction actionWithTitle:array[i] style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            if(blockArray[i])
            {
                blockArray[i]();
            }
        }];
        [ZCAlert addAction:action];
    }
    [self presentViewController:ZCAlert animated:YES completion:nil];
}


//在视图上显示一个自定义的Label,并使它停留一断时间
- (void)showLabelWithString:(NSString *)string AndBlock:(BLOCK)block
{
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(kWidth * 0.3, kHeight * 0.5, kWidth * 0.4, 50)];
    label.backgroundColor = [UIColor colorWithRed:0.286 green:0.280 blue:0.298 alpha:1.000];
    label.textAlignment = NSTextAlignmentCenter;
    label.numberOfLines = 0;
    label.alpha = 0;
    label.textColor = [UIColor whiteColor];
    label.font = [UIFont systemFontOfSize:14];
    
    [self.view addSubview:label];
    
    [UIView animateWithDuration:0.3 animations:^{
        label.text = string;
        label.alpha = 1;
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.3 delay:1.5 options:UIViewAnimationOptionCurveEaseIn  animations:^{
            label.alpha = 0;
        } completion:^(BOOL finished) {
            [label removeFromSuperview];
            if(block)
            {
                block();
            }
        }];
    }];
}

@end
