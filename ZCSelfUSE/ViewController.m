//
//  ViewController.m
//  ZCSelfUSE
//
//  Created by zhangchao on 16/5/6.
//  Copyright © 2016年 zhangchao. All rights reserved.
//

#import "ViewController.h"


@interface ViewController ()
@property (nonatomic,copy) BLOCK block1;
@property (nonatomic,copy) BLOCK block2;
@property (nonatomic,copy) BLOCK block3;
@end

@implementation ViewController

- (BLOCK)block1
{
    if(!_block1)
    {
        _block1 = ^
        {
            NSLog(@"你好");
        };
    }
    return _block1;
}

- (BLOCK)block2
{
    if(!_block2)
    {
        _block2 = ^
        {
            NSLog(@"不好");
        };
    }
    return _block2;
}

- (BLOCK)block3
{
    if(!_block3)
    {
        _block3 = ^
        {
            NSLog(@"好你妹");
        };
    }
    return _block3;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
    button.frame = CGRectMake(100, 100, 200, 30);
    [button setTitle:@"动态弹出一个Label" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(didClickBtn) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    
    UIButton * buttonA = [UIButton buttonWithType:UIButtonTypeSystem];
    buttonA.frame = CGRectMake(100, 150, 200, 30);
    [buttonA setTitle:@"弹出有两个按钮的弹框" forState:UIControlStateNormal];
    [buttonA addTarget:self action:@selector(didClickA) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:buttonA];
    
    
    UIButton * buttonB = [UIButton buttonWithType:UIButtonTypeSystem];
    buttonB.frame = CGRectMake(100, 200, 200, 30);
    [buttonB setTitle:@"弹出自己想要的弹框" forState:UIControlStateNormal];
    [buttonB addTarget:self action:@selector(didClickB) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:buttonB];
    
    
}

- (void)didClickBtn
{
    [self showLabelWithString:@"你好" AndBlock:^{
        NSLog(@"这个Block也可以为空");
    }];
}


- (void)didClickA
{
    [self showAlertTwoButtonWithTitle:@"提示" AndMessage:@"你好" AndAlertStyle:UIAlertControllerStyleAlert AndOneButtonTitle:@"你好" AndTwoButtonTitle:@"不好" AndOneBlock:^{
        NSLog(@"BLock1---可为空");
    } AndTwoBlock:^{
        NSLog(@"Block2---可为空");
    }];
}

- (void)didClickB
{
    NSArray *array = [NSArray arrayWithObjects:@"你好",@"不好",@"好你妹",nil];
    NSArray *blockArray = [NSArray arrayWithObjects:self.block1,self.block2,self.block3, nil];
    [self showAlertWithWithTitle:@"提示" AndMessage:@"你好" AndAlertStyle:UIAlertControllerStyleActionSheet AndButtonString:array AndBlockArray:blockArray];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
