//
//  BasicMoveViewController.m
//  PodDemo
//
//  Created by duoyi on 16/9/26.
//  Copyright © 2016年 bt. All rights reserved.
//

#import "BasicMoveViewController.h"
#import "POP.h"

@interface BasicMoveViewController ()

@property (nonatomic, strong) UIButton *button;
@property (nonatomic, strong) UIView *roundView;

@end

@implementation BasicMoveViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
  
    self.navigationItem.title = @"移动动画";
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:self.button];
    [self.view addSubview:self.roundView];
    
}

#pragma makr - 懒加载

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
    NSInteger width = CGRectGetWidth(self.view.frame);
    NSInteger height = CGRectGetHeight(self.view.frame);
    CGFloat centerX = arc4random() % width;
    CGFloat centery = arc4random() % height;

    POPBasicAnimation *basic = [POPBasicAnimation animationWithPropertyNamed:kPOPViewCenter];
    basic.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    // basic.fromValue 初始值
    basic.toValue = [NSValue valueWithCGPoint:CGPointMake(centerX, centery)];
    basic.duration = 0.4;
    [self.roundView pop_addAnimation:basic forKey:@"centerMove"];
}

@end
