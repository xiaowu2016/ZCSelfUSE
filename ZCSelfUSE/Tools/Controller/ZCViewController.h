//
//  ZCViewController.h
//  ZCSelfUSE
//
//  Created by zhangchao on 16/5/5.
//  Copyright © 2016年 zhangchao. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^BLOCK)(void);

@interface ZCViewController : UIViewController
/**
 *  创建只有一个按钮的弹框，并在点击时做某些事情
 *
 *  @param title    弹框的title
 *  @param message  弹框信息
 *  @param style    弹框的类型
 *  @param oneTitle 按钮的title
 *  @param block    BLOCK
 */
- (void)showAlertOneButtonWithTitle:(nullable NSString *)title
                         AndMessage:(nullable NSString *)message
                      AndAlertStyle:(UIAlertControllerStyle)style
                 AndOneButtonTittle:(NSString *)oneTitle
                           AndBlock:(__nullable BLOCK)block;

/**
 *  创建有两个按钮的弹框，两个按钮都自定义,并在点击这两个按钮时做某些事情
 *
 *  @param title    弹框的title
 *  @param message  弹框的信息
 *  @param style    弹框的类型
 *  @param oneTitle 第一个按钮的title
 *  @param twoTitle 第二个按钮的title
 *  @param oneBlock oneBLOCK
 *  @param twoBlock twoBLOCK
 */
- (void)showAlertTwoButtonWithTitle:(nullable NSString *)title
                         AndMessage:(nullable NSString *)message
                     AndAlertStyle :(UIAlertControllerStyle)style
                  AndOneButtonTitle:(NSString *)oneTitle
                  AndTwoButtonTitle:(NSString *)twoTitle
                        AndOneBlock:(__nullable BLOCK)oneBlock
                        AndTwoBlock:(__nullable BLOCK)twoBlock;

/**
 *  创建有三个按钮的弹框，三个按钮都自定义,并在点击这些按钮时做某些事情
 *
 *  @param title      弹框的title
 *  @param message    弹框的信息
 *  @param style      弹框的类型
 *  @param oneTitle   第一个按钮的title
 *  @param twoTitle   第二个按钮的title
 *  @param threeTitle 第三个按钮的title
 *  @param oneBlock   oneBLOCK
 *  @param twoBlock   twoBLOCK
 *  @param threeBlock threeBLOCK
 */
- (void)showAlertThreeButtonWithTitle:(nullable NSString *)title
                           AndMessage:(nullable NSString *)message
                       AndAlertStyle :(UIAlertControllerStyle)style
                    AndOneButtonTitle:(NSString *)oneTitle
                    AndTwoButtonTitle:(NSString *)twoTitle
                  AndThreeButtonTitle:(NSString *)threeTitle
                          AndOneBlock:(__nullable BLOCK)oneBlock
                          AndTwoBlock:(__nullable BLOCK)twoBlock
                        AndThreeBlock:(__nullable BLOCK)threeBlock;

/**
 *  创建一个弹框，可以自行定义有多少个按钮，但是需要传入按钮的title，并且每个按钮都可以定义一个BLOCK放到BLOCK数组中，在BLOCK中做自己想做的事
 *
 *  @param title      弹框的title
 *  @param message    弹框的信息
 *  @param style      弹框的类型
 *  @param array      按钮的title数组
 *  @param blockArray 按钮的BLOCK数组
 */
- (void)showAlertWithWithTitle:(nullable NSString *)title
                    AndMessage:(nullable NSString *)message
                AndAlertStyle :(UIAlertControllerStyle)style
               AndButtonString:(NSArray *)array
                 AndBlockArray:(NSArray<BLOCK> *)blockArray;

/**
 *  创建一个密码输入弹框
 *
 *  @param oneBlock 点击确定时要做的事情
 *  @param twoBlock 点击取消时要做的事情
 */
- (void)showTextFileEntryAlertWithOneBlock:(BLOCK)oneBlock
                               AndTwoBlock:(BLOCK)twoBlock;

/**
 *  在视图上显示一个自定义的Label,并使它停留一断时间
 *
 *  @param string Label的title
 *  @param block  BLOCK
 */
- (void)showLabelWithString:(NSString *)string
                   AndBlock:(__nullable BLOCK)block;
@end

NS_ASSUME_NONNULL_END