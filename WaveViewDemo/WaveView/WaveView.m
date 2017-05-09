//
//  WaveView.m
//  WaveViewDemo
//
//  Created by vance on 2017/3/8.
//  Copyright © 2017年 Vancef. All rights reserved.
//

#import "WaveView.h"
#import "WaveModel.h"
#import "WaveViewConfig.h"

@interface WaveView ()

@property (nonatomic, strong) WaveModel *model;

@end

@implementation WaveView

- (WaveModel *)model {
    if (!_model) {
        _model = [[WaveModel alloc] init];
    }
    return _model;
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self initView];
        [self initData];
    }
    return self;
}

//初始化UI
- (void)initView {
    
    //初始化波浪
    //底层
    self.model.waveLayer1 = [CAShapeLayer layer];
    self.model.waveLayer1.fillColor = WaveColor1.CGColor;
    self.model.waveLayer1.strokeColor = WaveColor1.CGColor;
    [self.layer addSublayer:self.model.waveLayer1];
    
    //上层
    self.model.waveLayer2 = [CAShapeLayer layer];
    self.model.waveLayer2.fillColor = WaveColor2.CGColor;
    self.model.waveLayer2.strokeColor = WaveColor2.CGColor;
    [self.layer addSublayer:self.model.waveLayer2];
    
    self.backgroundColor = BackGroundColor;
}

//初始化数据
- (void)initData {
    //振幅
    self.model.waveAmplitude = WaveAmplitude;
    //角速度
    self.model.wavePalstance = M_PI / self.bounds.size.width;
    //偏距
    self.model.waveY = self.bounds.size.height;
    //初相
    self.model.waveX = WaveX;
    //x轴移动速度
    self.model.waveMoveSpeed = self.model.wavePalstance * WaveMoveSpeed;
    //以屏幕刷新速度为周期刷新曲线的位置
    self.model.disPlayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(updateWave:)];
    [self.model.disPlayLink addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSRunLoopCommonModes];
}

- (void)updateWave:(CADisplayLink *)link {
    self.model.waveX += self.model.waveMoveSpeed;
    [self updateWaveY];
    [self updateWaveX:cos];
    [self updateWaveX:sin];
}

//更新偏距的大小 直到达到目标偏距 让wave有一个匀速增长的效果
- (void)updateWaveY {
    CGFloat targetY = self.bounds.size.height - self.progress * self.bounds.size.height;
    if (WaveAnimationCurveLinear) {//匀速增长
        if (self.model.waveY < targetY) {
            self.model.waveY += WaveCreateSpeed;
        }
        if (self.model.waveY > targetY) {
            self.model.waveY -= WaveCreateSpeed;
        }
    } else {
        self.model.waveY = targetY;
    }
    
}

- (void)updateWaveX:(double(double))math {
    //波浪宽度
    CGFloat waterWaveWidth = self.bounds.size.width;
    //初始化运动路径
    CGMutablePathRef path = CGPathCreateMutable();
    //设置起始位置
    CGPathMoveToPoint(path, nil, 0, self.model.waveY);
    //初始化波浪其实Y为偏距
    CGFloat y = self.model.waveY;
    //正弦曲线公式为： y=Asin(ωx+φ)+k;
    //余弦曲线公式为： y=Acos(ωx+φ)+k;
    for (float x = 0.0f; x <= waterWaveWidth; x++) {
        y = self.model.waveAmplitude * math(self.model.wavePalstance * x + self.model.waveX) + self.model.waveY;
        CGPathAddLineToPoint(path, nil, x, y);
    }
    //填充底部颜色
    CGPathAddLineToPoint(path, nil, waterWaveWidth, self.bounds.size.height);
    CGPathAddLineToPoint(path, nil, 0, self.bounds.size.height);
    CGPathCloseSubpath(path);
    if (math == cos) {
        self.model.waveLayer1.path = path;
    } else {
        self.model.waveLayer2.path = path;
    }
    CGPathRelease(path);
}

- (void)stop {
    if (self.model.disPlayLink) {
        [self.model.disPlayLink invalidate];
        self.model.disPlayLink = nil;
    }
}

- (void)dealloc {
    [self stop];
    if (self.model.waveLayer1) {
        [self.model.waveLayer1 removeFromSuperlayer];
        self.model.waveLayer1 = nil;
    }
    if (self.model.waveLayer2) {
        [self.model.waveLayer2 removeFromSuperlayer];
        self.model.waveLayer2 = nil;
    }
}


@end
