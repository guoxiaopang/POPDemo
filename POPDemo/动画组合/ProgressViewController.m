//
//  ProgressViewController.m
//  PodDemo
//
//  Created by duoyi on 16/9/27.
//  Copyright © 2016年 bt. All rights reserved.
//

#import "ProgressViewController.h"
#import "POP.h"

@interface ProgressViewController ()

@property (nonatomic, strong) UIButton *button;
@property (nonatomic, strong) UIView *roundView;

@end

@implementation ProgressViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.button];
    [self.view addSubview:self.roundView];
}

#pragma mark - 懒加载

- (UIView *)roundView
{
    if (!_roundView)
    {
        _roundView = [[UIView alloc] initWithFrame:CGRectMake(CGRectGetWidth(self.view.frame)/2 - 25, 150, 50, 50)];
        _roundView.backgroundColor = [UIColor colorWithRed:0.16 green:0.72 blue:1 alpha:1];
        _roundView.layer.cornerRadius = _roundView.frame.size.width/2;
        _roundView.layer.masksToBounds = YES;
    }
    return _roundView;
}

- (UIButton *)button
{
    if (!_button)
    {
        _button = [[UIButton alloc] init];
        [_button setTitle:@"Animation" forState:UIControlStateNormal];
        [_button setTitleColor:self.view.tintColor forState:UIControlStateNormal];
        [_button sizeToFit];
        _button.center = CGPointMake(CGRectGetWidth(self.view.frame)/2, CGRectGetHeight(self.view.frame) - 60);
        [_button addTarget:self action:@selector(animation) forControlEvents:UIControlEventTouchUpInside];
    }
    return _button;
}

#pragma mark - Void
- (void)animation
{
    [self.roundView pop_removeAllAnimations];
    // 重置视图
    for (CAShapeLayer *layer in self.roundView.layer.sublayers)
    {
        [layer removeFromSuperlayer];
    }
    
    _roundView.frame = CGRectMake(CGRectGetWidth(self.view.frame)/2 - 25, 150, 50, 50);
    
    // 白色进度条
    CAShapeLayer *progressLayer = [CAShapeLayer layer];
    progressLayer.strokeColor = [UIColor colorWithWhite:1.0 alpha:0.98].CGColor;
    progressLayer.lineCap   = kCALineCapRound;
    progressLayer.lineJoin  = kCALineJoinBevel;
    progressLayer.lineWidth = 26.0;
    progressLayer.strokeEnd = 0.0;
    
    UIBezierPath *progressline = [UIBezierPath bezierPath];
    [progressline moveToPoint:CGPointMake(25.0, 25.0)];
    [progressline addLineToPoint:CGPointMake(700.0, 25.0)];
    progressLayer.path = progressline.CGPath;
    
    [self.roundView.layer addSublayer:progressLayer];

    // 圆形->长方形->缩放->绘制进度条
    POPSpringAnimation *boundsAnimation = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerBounds];
    boundsAnimation.toValue = [NSValue valueWithCGRect:CGRectMake(0, 0, 800, 50)];
    boundsAnimation.springBounciness = 10;
    boundsAnimation.springSpeed = 6;
    boundsAnimation.completionBlock = ^(POPAnimation *anim, BOOL finished){
        if (finished)
        {
            UIGraphicsBeginImageContextWithOptions(self.roundView.frame.size, NO, 0.0);
            // 绘制动画
            POPBasicAnimation *progressAnimation = [POPBasicAnimation animationWithPropertyNamed:kPOPShapeLayerStrokeEnd];
            progressAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
            progressAnimation.duration = 1.0;
            progressAnimation.fromValue = @0.0;
            progressAnimation.toValue = @1.0;
            [progressLayer pop_addAnimation:progressAnimation forKey:@"AnimateBounds"];
            progressAnimation.completionBlock = ^(POPAnimation *anim, BOOL finished) {
                if (finished) {
                    UIGraphicsEndImageContext();
                }
            };
        }
    };
    
    POPSpringAnimation *scaleAnimation = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerScaleXY];
    scaleAnimation.toValue = [NSValue valueWithCGPoint:CGPointMake(0.3, 0.3)];
    scaleAnimation.springBounciness = 5;
    scaleAnimation.springSpeed = 12;

    
    [self.roundView.layer pop_addAnimation:boundsAnimation forKey:@"bouds"];
    [self.roundView.layer pop_addAnimation:scaleAnimation forKey:@"scale"];
}

@end
