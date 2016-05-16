//
//  ZCTableViewController.m
//  ZCSelfUSE
//
//  Created by zhangchao on 16/5/5.
//  Copyright © 2016年 zhangchao. All rights reserved.
//

#import "ZCTableViewController.h"

#define kWidth [UIScreen mainScreen].bounds.size.width
#define kHeight [UIScreen mainScreen].bounds.size.height

@interface ZCTableViewController ()
@property (nonatomic,strong) UIAlertAction *secureTextAlertAction;
@property (nonatomic,strong) UITextField *myTextField;
@end

@implementation ZCTableViewController
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


- (void)showTextFileEntryAlertWithOneBlock:(BLOCK)oneBlock
                               AndTwoBlock:(BLOCK)twoBlock
{
    NSString *title = NSLocalizedString(@"温馨提示", nil);
    NSString *message = NSLocalizedString(@"请输入密码", nil);
    NSString *cancelButtonTitle = NSLocalizedString(@"取消", nil);
    NSString *otherButtonTitle = NSLocalizedString(@"确定", nil);
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    
    //给弹框加一个输入框
    [alertController addTextFieldWithConfigurationHandler:^(UITextField *textField) {
        //添加一个通知
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleTextFieldTextDidChangeNotification:) name:UITextFieldTextDidChangeNotification object:textField];
        self.myTextField = textField;
        textField.secureTextEntry = YES;
    }];
    
    // Create the actions.
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:cancelButtonTitle style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
        if(oneBlock) oneBlock();
        //在点击按钮时移除通知
        [[NSNotificationCenter defaultCenter] removeObserver:self name:UITextFieldTextDidChangeNotification object:alertController.textFields.firstObject];
    }];
    
    UIAlertAction *otherAction = [UIAlertAction actionWithTitle:otherButtonTitle style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        if(twoBlock) twoBlock();
        //在点击按钮时移除通知
        [[NSNotificationCenter defaultCenter] removeObserver:self name:UITextFieldTextDidChangeNotification object:alertController.textFields.firstObject];
    }];
    //开始时，确定按钮是不可以被点击的
    otherAction.enabled = NO;
    self.secureTextAlertAction = otherAction;
    
    
    [alertController addAction:cancelAction];
    [alertController addAction:otherAction];
    
    [self presentViewController:alertController animated:YES completion:nil];
}

//临听事件的方法
- (void)handleTextFieldTextDidChangeNotification:(NSNotification *)notification {
    UITextField *textField = notification.object;
    //当输入密码等于六位数的时候确定按钮可以被点击
    self.secureTextAlertAction.enabled = textField.text.length >= 6;
    if(textField.text.length >= 6)
    {//当输入密码等于六位数的时候不可再编辑
        self.myTextField.enabled = NO;
    }
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
