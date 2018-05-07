//
//  ViewController.m
//  ARDemo
//
//  Created by 杨磊 on 2018/5/4.
//  Copyright © 2018年 csda_Chinadance. All rights reserved.
//

#import "ViewController.h"
#import "HelloARScanView.h"
#import <Masonry/Masonry.h>
#define LFScreenW [UIScreen mainScreen].bounds.size.width
#define LFScreenH [UIScreen mainScreen].bounds.size.height
#define RGBCOLOR(r,g,b) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:(1.f)]
#define COLOR_BASE_GREEN        RGBCOLOR(0xfa, 0x58,0x58)        //默认绿色fa5858

@interface ViewController ()

@property (nonatomic, strong) HelloARScanView *aniView;
@property (nonatomic, strong) UIButton *cameraButton;
@property (nonatomic, strong) UIButton *flashButton;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self ceateUI];
}

-(void)ceateUI{
    UIImageView *backImg = [UIImageView new];
    [self.view addSubview:backImg];
    backImg.image = [UIImage imageNamed:@"WechatIMG31"];
    [backImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsMake(0, 0, 0, 0));
    }];
    
    self.aniView = [[HelloARScanView alloc] initWithFrame:CGRectMake(0, 0, LFScreenW, LFScreenH)];;
    [self.view addSubview:self.aniView];
    [self.view bringSubviewToFront:self.aniView];
    [self.aniView starAnimation];
    
    [self otherView];
}

#pragma mark - 导航 tabber
- (void)otherView
{
    UIView *topView = [UIView new];
    topView.backgroundColor = [UIColor blackColor];
    [self.view addSubview:topView];
    [topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.mas_equalTo(0);
        make.height.mas_equalTo(64);
    }];
    
    UIButton *flashBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [flashBtn setImage:[UIImage imageNamed:@"icon_shoudiantong"] forState:UIControlStateNormal];
    [flashBtn setImage:[UIImage imageNamed:@"icon_shoudiantong_r"] forState:UIControlStateSelected];
    flashBtn.backgroundColor = [UIColor clearColor];
    [flashBtn addTarget:self action:@selector(flash:) forControlEvents:UIControlEventTouchUpInside];
    [topView addSubview:flashBtn];
    [flashBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.bottom.top.mas_equalTo(0);
        make.width.mas_equalTo(42);
    }];
    flashBtn.imageEdgeInsets = UIEdgeInsetsMake(11,-10,-11,10);
    self.flashButton = flashBtn;
    
    UIButton *cameraBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [cameraBtn setImage:[UIImage imageNamed:@"icon_xuanzhuan"] forState:UIControlStateNormal];
    cameraBtn.backgroundColor = [UIColor clearColor];
    [cameraBtn addTarget:self action:@selector(camera:) forControlEvents:UIControlEventTouchUpInside];
    [topView addSubview:cameraBtn];
    [cameraBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(flashBtn.mas_left).mas_offset(0);
        make.bottom.top.mas_equalTo(0);
        make.width.mas_equalTo(52);
    }];
    cameraBtn.imageEdgeInsets = UIEdgeInsetsMake(11,-5,-11,5);
    self.cameraButton = cameraBtn;
    
    
    UIView *botView = [UIView new];
    botView.backgroundColor = [UIColor blackColor];
    [self.view addSubview:botView];
    [botView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_equalTo(0);
        make.height.mas_equalTo(84);
    }];
    
    UIImageView *arImg = [UIImageView new];
    arImg.image = [UIImage imageNamed:@"icon_ar"];
    [botView addSubview:arImg];
    [arImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(34, 34));
        make.centerX.mas_equalTo(botView);
        make.top.mas_equalTo(15);
    }];
    
    UILabel *arLabel = [UILabel new];
    arLabel.font = [UIFont systemFontOfSize:15];
    arLabel.text = @"AR";
    arLabel.textColor = COLOR_BASE_GREEN;
    arLabel.textAlignment = NSTextAlignmentCenter;
    [botView addSubview:arLabel];
    [arLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(50, 21));
        make.centerX.mas_equalTo(botView);
        make.top.mas_equalTo(arImg.mas_bottom).mas_offset(3);
    }];
}
#pragma mark - 切换摄像头
- (void)camera:(UIButton *)sender
{
    [[self class]cancelPreviousPerformRequestsWithTarget:self selector:@selector(camera2:)object:sender];
    [self performSelector:@selector(camera2:)withObject:sender afterDelay:0.2f];
}
- (void)camera2:(UIButton *)sender
{
    BOOL mode = NO;
    if (!sender.selected) {
        mode = YES;
    }
    if (mode)
    {
        self.flashButton.selected = NO;
        [UIView animateWithDuration:0.25 animations:^{
            [self.flashButton mas_updateConstraints:^(MASConstraintMaker *make) {
                make.right.mas_equalTo(42);
            }];
            [self.view layoutIfNeeded];
        }];
    }else
    {
        [UIView animateWithDuration:0.25 animations:^{
            [self.flashButton mas_updateConstraints:^(MASConstraintMaker *make) {
                make.right.mas_equalTo(0);
            }];
            [self.view layoutIfNeeded];
        }];
    }
    sender.selected = !sender.selected;
}
#pragma mark - 打开手电筒
- (void)flash:(UIButton*)btn
{
    [[self class]cancelPreviousPerformRequestsWithTarget:self selector:@selector(flash2:)object:btn];
    [self performSelector:@selector(flash2:)withObject:btn afterDelay:0.5f];
}
- (void)flash2:(UIButton*)btn
{
    btn.selected = !btn.selected;
    [self turnTorchOn:btn.selected];
}
-(void)turnTorchOn:(bool)on
{

}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
