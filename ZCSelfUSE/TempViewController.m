//
//  TempViewController.m
//  ZCSelfUSE
//
//  Created by zhangchao on 16/6/2.
//  Copyright © 2016年 zhangchao. All rights reserved.
//

#import "TempViewController.h"
#import "ImageUtil.h"



//LOMO
const float colormatrix_lomo[] = {
    1.7f,  0.1f, 0.1f, 0, -73.1f,
    0,  1.7f, 0.1f, 0, -73.1f,
    0,  0.1f, 1.6f, 0, -73.1f,
    0,  0, 0, 1.0f, 0 };

//黑白
const float colormatrix_heibai[] = {
    0.8f,  1.6f, 0.2f, 0, -163.9f,
    0.8f,  1.6f, 0.2f, 0, -163.9f,
    0.8f,  1.6f, 0.2f, 0, -163.9f,
    0,  0, 0, 1.0f, 0 };
//复古
const float colormatrix_huajiu[] = {
    0.2f,0.5f, 0.1f, 0, 40.8f,
    0.2f, 0.5f, 0.1f, 0, 40.8f,
    0.2f,0.5f, 0.1f, 0, 40.8f,
    0, 0, 0, 1, 0 };

//哥特
const float colormatrix_gete[] = {
    1.9f,-0.3f, -0.2f, 0,-87.0f,
    -0.2f, 1.7f, -0.1f, 0, -87.0f,
    -0.1f,-0.6f, 2.0f, 0, -87.0f,
    0, 0, 0, 1.0f, 0 };

//锐化
const float colormatrix_ruise[] = {
    4.8f,-1.0f, -0.1f, 0,-388.4f,
    -0.5f,4.4f, -0.1f, 0,-388.4f,
    -0.5f,-1.0f, 5.2f, 0,-388.4f,
    0, 0, 0, 1.0f, 0 };


//淡雅
const float colormatrix_danya[] = {
    0.6f,0.3f, 0.1f, 0,73.3f,
    0.2f,0.7f, 0.1f, 0,73.3f,
    0.2f,0.3f, 0.4f, 0,73.3f,
    0, 0, 0, 1.0f, 0 };

//酒红
const float colormatrix_jiuhong[] = {
    1.2f,0.0f, 0.0f, 0.0f,0.0f,
    0.0f,0.9f, 0.0f, 0.0f,0.0f,
    0.0f,0.0f, 0.8f, 0.0f,0.0f,
    0, 0, 0, 1.0f, 0 };

//清宁
const float colormatrix_qingning[] = {
    0.9f, 0, 0, 0, 0,
    0, 1.1f,0, 0, 0,
    0, 0, 0.9f, 0, 0,
    0, 0, 0, 1.0f, 0 };

//浪漫
const float colormatrix_langman[] = {
    0.9f, 0, 0, 0, 63.0f,
    0, 0.9f,0, 0, 63.0f,
    0, 0, 0.9f, 0, 63.0f,
    0, 0, 0, 1.0f, 0 };

//光晕
const float colormatrix_guangyun[] = {
    0.9f, 0, 0,  0, 64.9f,
    0, 0.9f,0,  0, 64.9f,
    0, 0, 0.9f,  0, 64.9f,
    0, 0, 0, 1.0f, 0 };

//蓝调
const float colormatrix_landiao[] = {
    2.1f, -1.4f, 0.6f, 0.0f, -31.0f,
    -0.3f, 2.0f, -0.3f, 0.0f, -31.0f,
    -1.1f, -0.2f, 2.6f, 0.0f, -31.0f,
    0.0f, 0.0f, 0.0f, 1.0f, 0.0f
};

//梦幻
const float colormatrix_menghuan[] = {
    0.8f, 0.3f, 0.1f, 0.0f, 46.5f,
    0.1f, 0.9f, 0.0f, 0.0f, 46.5f,
    0.1f, 0.3f, 0.7f, 0.0f, 46.5f,
    0.0f, 0.0f, 0.0f, 1.0f, 0.0f
};

//夜色
const float colormatrix_yese[] = {
    1.0f, 0.0f, 0.0f, 0.0f, -66.6f,
    0.0f, 1.1f, 0.0f, 0.0f, -66.6f,
    0.0f, 0.0f, 1.0f, 0.0f, -66.6f,
    0.0f, 0.0f, 0.0f, 1.0f, 0.0f
};


typedef void (^ImageBlock) (int i);

@interface TempViewController ()<UIActionSheetDelegate>


@property (nonatomic,strong)UIImageView*filterView;
@property (nonatomic,strong)UILabel *filter;
@property (nonatomic,copy) ImageBlock block;
@end

@implementation TempViewController

-(UIImageView*)filterView{
    
    if (_filterView==nil) {
        
        _filterView=[[UIImageView alloc]initWithFrame:CGRectMake(0, 50, 375, 300)];
        _filterView.contentMode=UIViewContentModeScaleAspectFit;
        
    }
    
    return _filterView;
}


-(UILabel *)fl{
    
    if (_filter==nil) {
        _filter=[[UILabel alloc]initWithFrame:CGRectMake(self.view.frame.size.width/2-50, 400, 100, 25)];
    }
    
    
    return _filter;
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.filterView.image=[UIImage imageNamed:@"1.png"];
    
    [self.view addSubview:self.filterView];
    
    self.filter.text=@"原图";
    
    [self.view addSubview:self.filter];
    
    UIButton *sender=[UIButton buttonWithType:UIButtonTypeCustom];
    
    sender.frame=CGRectMake(self.view.frame.size.width/2-50, 450, 100, 30) ;
    
    sender.backgroundColor=[UIColor grayColor];
    
    [sender setTitle:@"滤镜" forState:UIControlStateNormal];
    
    [sender addTarget:self action:@selector(senderAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:sender];
    
    
}
-(void)senderAction{
    
    __weak typeof(self) myself = self;
    _block= ^ (int i)
    {
        NSString  *str = @"";
        switch (i) {
            case 0:
                str = @"原图";
                myself.filterView.image = [UIImage imageNamed:@"1.png"];
                break;
            case 1:
                
                str = @"LOMO";
                myself.filterView.image = [ImageUtil ImageWithImage:[UIImage imageNamed:@"1"] withColorMatrix:colormatrix_lomo];
                break;
            case 2:
                str = @"黑白";
                myself.filterView.image = [ImageUtil ImageWithImage:[UIImage imageNamed:@"1.png"] withColorMatrix:colormatrix_heibai];
                break;
            case 3:
                str = @"复古";
                myself.filterView.image = [ImageUtil ImageWithImage:[UIImage imageNamed:@"1.png"] withColorMatrix:colormatrix_huajiu];
                break;
            case 4:
                str = @"哥特";
                myself.filterView.image = [ImageUtil ImageWithImage:[UIImage imageNamed:@"1.png"] withColorMatrix:colormatrix_gete];
                break;
                
            case 5:
                str = @"淡雅";
                myself.filterView.image = [ImageUtil ImageWithImage:[UIImage imageNamed:@"1.png"] withColorMatrix:colormatrix_danya];
                break;
            case 6:
                str = @"酒红";
                myself.filterView.image = [ImageUtil ImageWithImage:[UIImage imageNamed:@"1.png"] withColorMatrix:colormatrix_jiuhong];
                break;
            case 7:
                str = @"清宁";
                myself.filterView.image = [ImageUtil ImageWithImage:[UIImage imageNamed:@"1.png"] withColorMatrix:colormatrix_qingning];
                break;
            case 8:
                str = @"浪漫";
                myself.filterView.image = [ImageUtil ImageWithImage:[UIImage imageNamed:@"1.png"] withColorMatrix:colormatrix_langman];
                break;
            case 9:
                str = @"光晕";
                myself.filterView.image = [ImageUtil ImageWithImage:[UIImage imageNamed:@"1.png"] withColorMatrix:colormatrix_guangyun];
                break;
            case 10:
                str = @"蓝调";
                myself.filterView.image = [ImageUtil ImageWithImage:[UIImage imageNamed:@"1.png"] withColorMatrix:colormatrix_landiao];
                break;
            case 11:
                str = @"梦幻";
                myself.filterView.image = [ImageUtil ImageWithImage:[UIImage imageNamed:@"1.png"] withColorMatrix:colormatrix_menghuan];
                break;
            case 12:
                str = @"夜色";
                myself.filterView.image = [ImageUtil ImageWithImage:[UIImage imageNamed:@"1.png"] withColorMatrix:colormatrix_yese];
                break;
            default:
                break;
        }
        myself.filter.text = str;
    };
    [self showAlertWithWithTitle:@"滤镜" AndMessage:nil AndAlertStyle:UIAlertControllerStyleAlert AndButtonString:@[@"原图",@"LOMO",@"黑白",@"复古",@"哥特",@"淡雅",@"酒红",@"清宁",@"浪漫",@"光晕",@"蓝调",@"梦幻",@"夜色"] AndBlockArray:@[_block,_block,_block,_block,_block,_block,_block,_block,_block,_block,_block,_block,_block]];
    
}


- (void)showAlertWithWithTitle:(NSString *)title AndMessage:(NSString *)message AndAlertStyle:(UIAlertControllerStyle)style AndButtonString:(NSArray *)array AndBlockArray:(NSArray<ImageBlock> *)blockArray
{
    UIAlertController *ZCAlert = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:style];
    for(int i = 0; i < array.count; i++)
    {
        UIAlertAction *action = [UIAlertAction actionWithTitle:array[i] style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            if(blockArray[i])
            {
                blockArray[i](i);
            }
        }];
        [ZCAlert addAction:action];
    }
    [self presentViewController:ZCAlert animated:YES completion:nil];
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
