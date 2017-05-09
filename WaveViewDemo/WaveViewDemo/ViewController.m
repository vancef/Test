//
//  ViewController.m
//  WaveViewDemo
//
//  Created by vance on 2017/3/8.
//  Copyright © 2017年 Vancef. All rights reserved.
//

#import "ViewController.h"
#import "WaveView.h"

@interface ViewController ()

@property (nonatomic, strong) WaveView *waveView;

@property (nonatomic, strong) UILabel *textLabel;

@property (nonatomic, strong) UISlider *slider;

@end

@implementation ViewController

- (WaveView *)waveView {
    if (!_waveView) {
        _waveView = [[WaveView alloc] initWithFrame:self.view.bounds];
    }
    return _waveView;
}

- (UILabel *)textLabel {
    if (!_textLabel) {
        _textLabel = [[UILabel alloc] initWithFrame:self.view.bounds];
        _textLabel.textAlignment = NSTextAlignmentCenter;
        _textLabel.textColor = [UIColor whiteColor];
        _textLabel.font = [UIFont boldSystemFontOfSize:50];
        _textLabel.text = @"0%";
    }
    return _textLabel;
}

- (UISlider *)slider {
    if (!_slider) {
        _slider = [[UISlider alloc] initWithFrame:CGRectMake(50, 100, self.view.bounds.size.width - 2 * 50, 30)];
        _slider.center = CGPointMake(self.view.center.x, 100);
        [_slider addTarget:self action:@selector(sliderMethod:) forControlEvents:UIControlEventValueChanged];
        [_slider setMaximumValue:1];
        [_slider setMinimumValue:0];
        [_slider setMinimumTrackTintColor:[UIColor colorWithRed:96/255.0f green:159/255.0f blue:150/255.0f alpha:1]];
    }
    return _slider;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.waveView];
    [self.view addSubview:self.textLabel];
    [self.view addSubview:self.slider];
}

- (void)sliderMethod:(UISlider*)slider {
    self.waveView.progress = slider.value;
    self.textLabel.text = [NSString stringWithFormat:@"%.0f%%", slider.value * 100];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
