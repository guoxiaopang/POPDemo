//
//  PushViewController.m
//  PodDemo
//
//  Created by duoyi on 16/9/27.
//  Copyright © 2016年 bt. All rights reserved.
//

#import "PushViewController.h"
#import "Pop.h"

@interface PushViewController ()

@property (nonatomic, strong) UIView *pushView;
@property (nonatomic, strong) UIButton *button;
@property (nonatomic, strong) UIButton *closeButton;

@end

@implementation PushViewController
{
    BOOL _isOpen;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.view addSubview:self.button];
    [self.view addSubview:self.pushView];
    [_pushView addSubview:self.closeButton];
    self.view.backgroundColor = [UIColor whiteColor];
}

#pragma mark - pushView
- (UIView *)pushView
{
    if (!_pushView)
    {
        _pushView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 160, 230)];
        [_pushView.layer setCornerRadius:5.0f];
        _pushView.backgroundColor = [UIColor colorWithRed:0.16 green:0.72 blue:1.0 alpha:1.0];
        _pushView.center = CGPointMake(CGRectGetWidth(self.view.frame)/2, -200);
        UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePan:)];
        [_pushView addGestureRecognizer:pan];
    }
    return _pushView;
}

- (UIButton *)closeButton
{
    if (!_closeButton)
    {
        _closeButton = [[UIButton alloc] init];
        [_closeButton setTitle:@"关闭" forState:UIControlStateNormal];
        [_closeButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_closeButton sizeToFit];
        _closeButton.center = CGPointMake(CGRectGetWidth(self.pushView.frame)/2, 210);
        [_closeButton addTarget:self action:@selector(close) forControlEvents:UIControlEventTouchUpInside];
    }
    return _closeButton;
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
- (void)handlePan:(UIPanGestureRecognizer *)pan
{
    switch (pan.state)
    {
        case UIGestureRecognizerStateBegan:
        case UIGestureRecognizerStateChanged:
        {
            [self.pushView.layer pop_removeAllAnimations];
            
            CGPoint translation = [pan translationInView:self.view];
            
            CGPoint center = self.pushView.center;
            center.x += translation.x;
            center.y += translation.y;
            self.pushView.center = center;
            
            [pan setTranslation:CGPointZero inView:self.pushView];
            break;
        }
            
        case UIGestureRecognizerStateEnded:
        case UIGestureRecognizerStateCancelled:
        {
            CGPoint velocity = [pan velocityInView:self.view];
            [self addDecayPositionAnimationWithVelocity:velocity];
            break;
        }
            
        default:
            break;
    }
}

// 添加减速动画
-(void)addDecayPositionAnimationWithVelocity:(CGPoint)velocity
{
    POPDecayAnimation *anim = [POPDecayAnimation animationWithPropertyNamed:kPOPLayerPosition];
    
    anim.velocity = [NSValue valueWithCGPoint:CGPointMake(velocity.x, velocity.y)];
    
    
    anim.deceleration = 0.998;
    
    [self.pushView.layer pop_addAnimation:anim forKey:@"AnimationPosition"];
}

- (void)animation
{
    if (_isOpen)
    {
        [self close];
        return;
    }
    _isOpen = YES;
    [self.pushView pop_removeAllAnimations];

    _pushView.center = CGPointMake(CGRectGetWidth(self.view.frame)/2, -200);
    
    POPSpringAnimation *anim = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerPositionY];
    anim.springBounciness = 6; //弹簧
    anim.springSpeed = 10;
    anim.fromValue = @-200;
    anim.toValue = @(self.view.center.y);
    
    POPBasicAnimation *opacityAnim = [POPBasicAnimation animationWithPropertyNamed:kPOPLayerOpacity];
    // 透明度
    opacityAnim.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    opacityAnim.duration = 0.25;
    opacityAnim.toValue = @1.0;
    
    POPBasicAnimation *rotationAnim = [POPBasicAnimation animationWithPropertyNamed:kPOPLayerRotation];
    // 旋转
    rotationAnim.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    rotationAnim.beginTime = CACurrentMediaTime() + 0.1;
    rotationAnim.duration = 0.3;
    rotationAnim.toValue = @(0);
    
    [self.pushView.layer pop_addAnimation:anim forKey:@"AnimationScale"];
    [self.pushView.layer pop_addAnimation:opacityAnim forKey:@"AnimateOpacity"];
    [self.pushView.layer pop_addAnimation:rotationAnim forKey:@"AnimateRotation"];
}

- (void)close
{
    [self.pushView pop_removeAllAnimations];
    POPSpringAnimation *anim = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerPositionY];
    anim.springBounciness = 6; //弹簧
    anim.springSpeed = 10;
    anim.toValue = @(-200);
    
    POPBasicAnimation *opacityAnim = [POPBasicAnimation animationWithPropertyNamed:kPOPLayerOpacity];
    opacityAnim.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    opacityAnim.duration = 0.25;
    opacityAnim.toValue = @0.0;
    
    POPBasicAnimation *rotationAnim = [POPBasicAnimation animationWithPropertyNamed:kPOPLayerRotation];
    rotationAnim.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    rotationAnim.beginTime = CACurrentMediaTime() + 0.1;
    rotationAnim.duration = 0.3;
    rotationAnim.toValue = @(M_PI_4/8);
    
    [self.pushView.layer pop_addAnimation:anim forKey:@"AnimationScale"];
    [self.pushView.layer pop_addAnimation:opacityAnim forKey:@"AnimateOpacity"];
    [self.pushView.layer pop_addAnimation:rotationAnim forKey:@"AnimateRotation"];
    _isOpen = NO;
}

@end
