//
//  SpringCircleViewController.m
//  PodDemo
//
//  Created by duoyi on 16/9/27.
//  Copyright © 2016年 bt. All rights reserved.
//

#import "SpringCircleViewController.h"
#import "CircleView.h"

@interface SpringCircleViewController ()

@property (nonatomic, strong) UISlider *slider;
@property (nonatomic, strong) CircleView *circleView;

@end

@implementation SpringCircleViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.slider];
    [self.view addSubview:self.circleView];
}

#pragma mark - 懒加载

- (CircleView *)circleView
{
    if (!_circleView)
    {
        _circleView = [[CircleView alloc] initWithFrame:CGRectMake(0, 0, 200, 200)];
        _circleView.strokeColor = self.view.tintColor;
        _circleView.center = CGPointMake(CGRectGetWidth(self.view.frame)/2, 200);
    }
    return _circleView;
}
- (UISlider *)slider
{
    if (!_slider)
    {
        _slider = [[UISlider alloc] initWithFrame:CGRectMake(0, 0, 300, 20)];
        _slider.translatesAutoresizingMaskIntoConstraints = NO;
        _slider.center = CGPointMake(CGRectGetWidth(self.view.frame)/2, 500);
        [_slider addTarget:self action:@selector(sliderChange:) forControlEvents:UIControlEventValueChanged];
        [_slider setValue:0.7 animated:YES];
        [self sliderChange:_slider];
    }
    return _slider;
}

#pragma mark - Void
- (void)sliderChange:(UISlider *)slider
{
    [self.circleView setStrokeEnd:slider.value animated:YES];
}

@end
