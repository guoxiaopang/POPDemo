//
//  SpringRoteViewController.m
//  PodDemo
//
//  Created by duoyi on 16/9/27.
//  Copyright © 2016年 bt. All rights reserved.
//

#import "SpringBasicViewController.h"
#import "POP.h"

@interface SpringBasicViewController ()<POPAnimationDelegate>

@property (nonatomic, strong) UIView *rectAngleView;
@property (nonatomic, strong) UIButton *button;

// 弹力
@property (nonatomic, strong) UISlider *springBounciness;
@property (nonatomic, strong) UILabel *springBouncinessLabel;

// 拉力
@property (nonatomic, strong) UISlider *dynamicsTension;
@property (nonatomic, strong) UILabel *dynamicsTensionLabel;

// 质量
@property (nonatomic, strong) UISlider *dynamicsMass;
@property (nonatomic, strong) UILabel *dynamicsMassLabel;

// 摩擦力

// 速度
@property (nonatomic, strong) UISlider *speed;
@property (nonatomic, strong) UILabel *speedLabel;

@end

@implementation SpringBasicViewController
{
    CGFloat _springBouncinessValue;
    CGFloat _dynamicsTensionValue;
    CGFloat _dynamicsMassValue;
    CGFloat _speedValue;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.rectAngleView];
    [self.view addSubview:self.button];
    [self.view addSubview:self.springBouncinessLabel];
    [self.view addSubview:self.springBounciness];
    [self.view addSubview:self.dynamicsTension];
    [self.view addSubview:self.dynamicsTensionLabel];
    [self.view addSubview:self.dynamicsMass];
    [self.view addSubview:self.dynamicsMassLabel];
    [self.view addSubview:self.speed];
    [self.view addSubview:self.speedLabel];
}

#pragma mark - 懒加载

- (UILabel *)speedLabel
{
    if (!_speedLabel)
    {
        _speedLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, CGRectGetMaxY(_dynamicsMassLabel.frame) + 30, 100, 20)];
        _speedLabel.textColor = self.view.tintColor;
        _speedLabel.text = @"速度:12.0";
    }
    return _speedLabel;
}

- (UISlider *)speed
{
    if (!_speed)
    {
        _speed = [[UISlider alloc] initWithFrame:CGRectMake(100, CGRectGetMaxY(_dynamicsMassLabel.frame) + 30, CGRectGetWidth(self.view.frame) - 120, 20)];
        _speed.maximumValue = 20.0f;
        _speed.minimumValue = 0.0f;
        [_speed addTarget:self action:@selector(speedChange:) forControlEvents:UIControlEventValueChanged];
        [_speed setValue:12 animated:YES];
    }
    return _speed;
}


- (UILabel *)dynamicsMassLabel
{
    if (!_dynamicsMassLabel)
    {
        _dynamicsMassLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, CGRectGetMaxY(_dynamicsTensionLabel.frame) + 30, 100, 20)];
        _dynamicsMassLabel.textColor = self.view.tintColor;
        _dynamicsMassLabel.text = @"质量:1.0";
    }
    return _dynamicsMassLabel;
}

- (UISlider *)dynamicsMass
{
    if (!_dynamicsMass)
    {
        _dynamicsMass = [[UISlider alloc] initWithFrame:CGRectMake(100, CGRectGetMaxY(_dynamicsTensionLabel.frame) + 30,  CGRectGetWidth(self.view.frame) - 120, 20)];
        _dynamicsMass.maximumValue = 100.f;
        _dynamicsMass.minimumValue = 0.0f;
        [_dynamicsMass addTarget:self action:@selector(dynamicsMassChange:) forControlEvents:UIControlEventValueChanged];
        [_dynamicsMass setValue:1.0f animated:YES];
    }
    return _dynamicsMass;
}

- (UILabel *)dynamicsTensionLabel
{
    if (!_dynamicsTensionLabel)
    {
        _dynamicsTensionLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, CGRectGetMaxY(_springBounciness.frame) + 30, 100, 20)];
        _dynamicsTensionLabel.textColor = self.view.tintColor;
        _dynamicsTensionLabel.text = @"拉力:214.0";
    }
    return _dynamicsTensionLabel;
}

- (UISlider *)dynamicsTension
{
    if (!_dynamicsTension)
    {
        _dynamicsTension = [[UISlider alloc] initWithFrame:CGRectMake(100, CGRectGetMaxY(_springBounciness.frame) + 30, CGRectGetWidth(self.view.frame) - 120, 20)];
        _dynamicsTension.maximumValue = 1000.0f;
        _dynamicsTension.minimumValue = 0.0f;
        [_dynamicsTension addTarget:self action:@selector(dynamicsTensionChange:) forControlEvents:UIControlEventValueChanged];
        [_dynamicsTension setValue:214 animated:YES];
    }
    return _dynamicsTension;
}

- (UILabel *)springBouncinessLabel
{
    if (!_springBouncinessLabel)
    {
        _springBouncinessLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, CGRectGetMaxY(_button.frame) + 30, 100, 20)];
        _springBouncinessLabel.textColor = self.view.tintColor;
        _springBouncinessLabel.text = @"弹力:16.0";
    }
    return _springBouncinessLabel;
}

- (UISlider *)springBounciness
{
    if (!_springBounciness)
    {
        _springBounciness = [[UISlider alloc] initWithFrame:CGRectMake(100, CGRectGetMaxY(_button.frame) + 30, CGRectGetWidth(self.view.frame) - 120, 20)];
        _springBounciness.maximumValue = 20.0f;
        _springBounciness.minimumValue = 0.0f;
        [_springBounciness addTarget:self action:@selector(springBouncinessChange:) forControlEvents:UIControlEventValueChanged];
        [_springBounciness setValue:16 animated:YES];
    }
    return _springBounciness;
}

- (UIView *)rectAngleView
{
    if (!_rectAngleView)
    {
        _rectAngleView = [[UIView alloc] initWithFrame:CGRectMake(0, 64, 50, 50)];
        _rectAngleView.backgroundColor = [UIColor colorWithRed:0.16 green:0.72 blue:1 alpha:1];
        _rectAngleView.layer.cornerRadius = _rectAngleView.frame.size.width/2;
        _rectAngleView.layer.masksToBounds = YES;
    }
    return _rectAngleView;
}

- (UIButton *)button
{
    if (!_button)
    {
        _button = [[UIButton alloc] init];
        [_button setTitle:@"animation" forState:UIControlStateNormal];
        [_button sizeToFit];
        [_button setTitleColor:self.view.tintColor forState:UIControlStateNormal];
        [_button addTarget:self action:@selector(animation) forControlEvents:UIControlEventTouchUpInside];
        _button.center = CGPointMake(CGRectGetWidth(self.view.frame)/2, CGRectGetHeight(self.view.frame)/2 + 50);
    }
    return _button;
}

#pragma mark - Void
- (void)speedChange:(UISlider *)speed
{
    _speedValue = speed.value;
    self.speedLabel.text = [NSString stringWithFormat:@"速度: %.1lf", _speedValue];
}


- (void)dynamicsMassChange:(UISlider *)dynamicsMass
{
    _dynamicsMassValue = dynamicsMass.value;
    self.dynamicsMassLabel.text = [NSString stringWithFormat:@"质量: %.1lf", _dynamicsMassValue];
}

- (void)dynamicsTensionChange:(UISlider *)dynamicsTension
{
    _dynamicsTensionValue = dynamicsTension.value;
    self.dynamicsTensionLabel.text = [NSString stringWithFormat:@"拉力: %.1lf", _dynamicsTensionValue];
}

- (void)springBouncinessChange:(UISlider *)springBounciness
{
    _springBouncinessValue = springBounciness.value;
    self.springBouncinessLabel.text = [NSString stringWithFormat:@"弹力: %.1lf", _springBouncinessValue];
}

- (void)animation
{
    NSInteger height = CGRectGetHeight(self.view.frame);
    NSInteger widrh = CGRectGetWidth(self.view.bounds);
    
    CGFloat centerX  = arc4random() % widrh;
    CGFloat centerY = arc4random() % height;
    POPSpringAnimation *spring = [POPSpringAnimation animationWithPropertyNamed:kPOPViewCenter];
    spring.toValue = [NSValue valueWithCGPoint:CGPointMake(centerX, centerY)];
    spring.springBounciness = _springBouncinessValue; // 弹簧弹力 [0,20] 默认4, 越大震动幅度越大
    spring.springSpeed = _speedValue ? _speedValue : 12; // [0 - 20] 越大 动画结束越快
    spring.dynamicsTension = _dynamicsTensionValue ? _dynamicsTensionValue : 214; //弹簧的拉力
    spring.dynamicsMass = _dynamicsMassValue ? _dynamicsMassValue : 1.0f; // 质量
    spring.delegate =self;
    //spring.dynamicsFriction // 摩擦力
   // spring.velocity; 速率
    
    [self.rectAngleView pop_addAnimation:spring forKey:@"center"];
    spring.completionBlock = ^(POPAnimation *anim, BOOL finished){
        if (finished)
        {
            NSLog(@"finish");
        }
    };
}

#pragma mark - POPAnimationDelegate

- (void)pop_animationDidStart:(POPAnimation *)anim
{
    NSLog(@"动画开始调用");
}

- (void)pop_animationDidReachToValue:(POPAnimation *)anim
{
    NSLog(@"将要达到toValue值是调用");
}

- (void)pop_animationDidStop:(POPAnimation *)anim finished:(BOOL)finished
{
    NSLog(@"finished");
}

- (void)pop_animationDidApply:(POPAnimation *)anim
{
    NSLog(@"pop_animationDidApply"); // 动画执行过程中一直调用
}


@end
