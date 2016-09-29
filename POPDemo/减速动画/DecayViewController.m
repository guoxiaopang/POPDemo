//
//  DecayViewController.m
//  PodDemo
//
//  Created by duoyi on 16/9/27.
//  Copyright © 2016年 bt. All rights reserved.
//

#import "DecayViewController.h"
#import "POP.h"

@interface DecayViewController ()

@property (nonatomic, strong) UIView *roundView;

@end

@implementation DecayViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
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
        UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePan:)];
        [_roundView addGestureRecognizer:pan];
    }
    return _roundView;
}

#pragma mark - Void
- (void)handlePan:(UIPanGestureRecognizer *)pan
{
    switch (pan.state)
    {
        case UIGestureRecognizerStateBegan:
        case UIGestureRecognizerStateChanged: {
            [self.roundView.layer pop_removeAllAnimations];
            
            CGPoint translation = [pan translationInView:self.view];
            
            CGPoint center = self.roundView.center;
            center.x += translation.x;
            center.y += translation.y;
            self.roundView.center = center;
            
            [pan setTranslation:CGPointZero inView:self.roundView];
            break;
        }
            
        case UIGestureRecognizerStateEnded:
        case UIGestureRecognizerStateCancelled: {
            
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
    
    [self.roundView.layer pop_addAnimation:anim forKey:@"AnimationPosition"];
}


@end
