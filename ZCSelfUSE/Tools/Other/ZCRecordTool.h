//
//  ZCRecordTool.h
//  ZCSelfUSE
//
//  Created by zhangchao on 16/5/10.
//  Copyright © 2016年 zhangchao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>

@class ZCRecordTool;
@protocol ZCRecordToolDelegate <NSObject>

@optional
- (void)recordTool:(ZCRecordTool *)recordTool didStartRecoring:(int)no;

@end

@interface ZCRecordTool : NSObject

/**
 *  录音工具的单例
 *
 *  @return ZCRecordTool的对象
 */
+ (instancetype)sharedRecordTool;

/**
 *  开始录音
 */
- (void)startRecording;

/**
 *  停止录音
 */
- (void)stopRecording;

/**
 *  播放录音文件
 */
- (void)playRecordingFile;

/**
 *  停止播放录音文件
 */
- (void)stopPlaying;

/**
 *  销毁录音文件
 */
- (void)destructionRecordingFile;

/**
 *  录音对象
 */
@property (nonatomic,strong) AVAudioRecorder *recorder;

/**
 *  播放器对象
 */
@property (nonatomic,strong) AVAudioPlayer *player;

/**
 *  更新图片的代理
 */
@property (nonatomic,assign) id<ZCRecordToolDelegate> delegate;


@end
