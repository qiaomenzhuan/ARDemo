//
//  HelloARScanView.h
//  SportChina
//
//  Created by 杨磊 on 2018/5/2.
//  Copyright © 2018年 Beijing Sino Dance Culture Media Co.,Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^voidBlock)(void);
//仿支付宝AR扫描动画
@interface HelloARScanView : UIView


/**
 开始动画
 */
- (void)starAnimation;

/**
 停止动画
 */
- (void)stopAnimtion;

/**
 扫描成功动画
 */
- (void)sucessAnimtion;


/**
 成功回调
 */
@property (nonatomic,  copy)voidBlock success;

@end
