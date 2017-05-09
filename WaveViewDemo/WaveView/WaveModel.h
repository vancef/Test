//
//  WaveModel.h
//  WaveViewDemo
//
//  Created by vance on 2017/3/8.
//  Copyright © 2017年 Vancef. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface WaveModel : NSObject

//前面的波浪
@property (nonatomic, strong) CAShapeLayer *waveLayer1;
@property (nonatomic, strong) CAShapeLayer *waveLayer2;

@property (nonatomic, strong) CADisplayLink *disPlayLink;

//曲线的振幅
@property (nonatomic, assign) CGFloat waveAmplitude;

//曲线角速度
@property (nonatomic, assign) CGFloat wavePalstance;
//曲线初相
@property (nonatomic, assign) CGFloat waveX;
//曲线偏距
@property (nonatomic, assign) CGFloat waveY;
//曲线移动速度
@property (nonatomic, assign) CGFloat waveMoveSpeed;

@end
