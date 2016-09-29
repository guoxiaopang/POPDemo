//
//  BasicScaleViewController.m
//  PodDemo
//
//  Created by duoyi on 16/9/27.
//  Copyright © 2016年 bt. All rights reserved.
//

#import "BasicScaleViewController.h"
#import "POP.h"

@interface BasicScaleViewController ()

@property (nonatomic, strong) UIView *roundView;

@end

@implementation BasicScaleViewController
{
    BOOL _scale;
    BOOL _rote;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.title = @"形变动画";
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.roundView];
    
    [self changePOP];

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

#pragma mark - Void
- (void)changePOP
{
    POPBasicAnimation *basic = [POPBasicAnimation animationWithPropertyNamed:kPOPViewScaleXY];
    basic.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    if (_scale)
    {
        basic.toValue = [NSValue valueWithCGPoint:CGPointMake(1.0, 1.0)];
    }
    else
    {
        basic.toValue = [NSValue valueWithCGPoint:CGPointMake(2.0, 2.0)];
    }
    _scale = !_scale;
    basic.completionBlock = ^(POPAnimation *anim, BOOL finished) {
        if (finished)
        {
            [self changePOP];
        }
    };
    [self.roundView pop_addAnimation:basic forKey:@"basic"];
}

@end
