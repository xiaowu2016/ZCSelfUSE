//
//  ViewController.m
//  ZCSelfUSE
//
//  Created by zhangchao on 16/5/6.
//  Copyright © 2016年 zhangchao. All rights reserved.
//

#import "ViewController.h"
#import "ZCRecordTool.h"
#import "UIView+Category.h"


@interface ViewController ()<ZCRecordToolDelegate>
@property (nonatomic,copy) BLOCK block1;
@property (nonatomic,copy) BLOCK block2;
@property (nonatomic,copy) BLOCK block3;

/** 录音工具 */
@property (nonatomic,strong) ZCRecordTool *recordTool;
/** 录音时的图片 */
@property (weak, nonatomic) UIImageView *imageView;
/** 录音按钮 */
@property (weak, nonatomic) UIButton *recordBtn;
/** 播放按钮 */
@property (weak, nonatomic) UIButton *playBtn;
@property (nonatomic,strong) UIView *myView;
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
    
    self.myView = [[UIView alloc] initWithFrame:CGRectMake(0, self.view.height - 224, self.view.width, 144)];
    [self.view addSubview:self.myView];
    [self setup];
    [self addFrame];
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




- (void)setup {
    
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"mic_0"]];
    [self.myView addSubview:imageView];
    self.imageView = imageView;
    self.imageView.hidden = YES;
    
    [self setupRecordBtn];
    
    UIButton *playBtn = [[UIButton alloc] init];
    [self.myView addSubview:playBtn];
    self.playBtn = playBtn;
    
    [self.playBtn setImage:[UIImage imageNamed:@"MessageVideoPlay"] forState:UIControlStateNormal];
    
    self.recordTool = [ZCRecordTool sharedRecordTool];
    self.recordTool.delegate = self;
    
    // 录音按钮事件
    [self.recordBtn addTarget:self action:@selector(recordBtnDidTouchDown:) forControlEvents:UIControlEventTouchDown];
    [self.recordBtn addTarget:self action:@selector(recordBtnDidTouchUpInside:) forControlEvents:UIControlEventTouchUpInside];
    [self.recordBtn addTarget:self action:@selector(recordBtnDidTouchDragExit:) forControlEvents:UIControlEventTouchDragExit];
    
    // 播放按钮事件
    [self.playBtn addTarget:self action:@selector(play) forControlEvents:UIControlEventTouchUpInside];
}

- (void)setupRecordBtn {
    UIButton *recordBtn = [[UIButton alloc] init];
    
    self.recordBtn = recordBtn;
    [self.myView addSubview:recordBtn];
    
    // 按钮属性
    self.recordBtn.layer.cornerRadius = 10;
    [self.recordBtn setTitle:@"按住 说话" forState:UIControlStateNormal];
    [self.recordBtn setTitle:@"松开 结束" forState:UIControlStateHighlighted];
    [self.recordBtn setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    [self.recordBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
    
    [self.recordBtn setBackgroundImage:[UIImage imageNamed:@"VoiceBtn_Black"] forState:UIControlStateNormal];
    [self.recordBtn setBackgroundImage:[UIImage imageNamed:@"VoiceBtn_BlackHL"] forState:UIControlStateHighlighted];
}


#pragma mark - 录音按钮事件
// 按下
- (void)recordBtnDidTouchDown:(UIButton *)recordBtn {
    [self.recordTool startRecording];
    self.imageView.hidden = NO;
}

// 点击
- (void)recordBtnDidTouchUpInside:(UIButton *)recordBtn {
    double currentTime = self.recordTool.recorder.currentTime;
    NSLog(@"%lf", currentTime);
    if (currentTime < 2) {
        
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            
            [self.recordTool stopRecording];
            
            [self.recordTool destructionRecordingFile];
            dispatch_async(dispatch_get_main_queue(), ^{
                self.imageView.hidden = YES;
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [self showLabelWithString:@"说话时间太短" AndBlock:nil];
                });
            });
        });
    } else {
        
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            
            [self.recordTool stopRecording];
            dispatch_async(dispatch_get_main_queue(), ^{
                self.imageView.hidden = YES;
            });
        });
        // 已成功录音
        [self showLabelWithString:@"已成功录音" AndBlock:nil];
    }
}

// 手指从按钮上移除
- (void)recordBtnDidTouchDragExit:(UIButton *)recordBtn {
    
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        
        [self.recordTool stopRecording];
        [self.recordTool destructionRecordingFile];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            self.imageView.hidden = YES;
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [self showLabelWithString:@"已取消录音" AndBlock:nil];
            });
        });
    });
    
}

#pragma mark - 播放录音
- (void)play {
    [self.recordTool playRecordingFile];
}


- (void)dealloc {
    if (self.recordTool.player.isPlaying) {
        [self.recordTool stopPlaying];
    }
    if (self.recordTool.recorder.isRecording) {
        
        [self.recordTool stopRecording];
    }
    [self.recordTool destructionRecordingFile];
}

#pragma mark - LVRecordToolDelegate
- (void)recordTool:(ZCRecordTool *)recordTool didStartRecoring:(int)no{
    NSString *imageName = [NSString stringWithFormat:@"mic_%d", no];
    NSLog(@"%@",imageName);
    self.imageView.image = [UIImage imageNamed:imageName];
}


- (void)addFrame {
    CGFloat leftMargin = 20;
    CGFloat buttonH = 40;
    
    self.playBtn.x = self.myView.width - leftMargin - buttonH;
    self.playBtn.y = self.myView.height - buttonH;
    self.playBtn.width = buttonH;
    self.playBtn.height = buttonH;
    
    self.recordBtn.x = leftMargin;
    self.recordBtn.y = self.playBtn.y;
    self.recordBtn.width = self.playBtn.x - leftMargin;
    self.recordBtn.height = buttonH;
    
    self.imageView.width = 64;
    self.imageView.height = 64;
    self.imageView.centerX = self.recordBtn.centerX;
    self.imageView.y = self.recordBtn.y - self.imageView.height;
}


//点击屏幕弹出密码输入框
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self showTextFileEntryAlertWithOneBlock:self.block1 AndTwoBlock:self.block2];
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
