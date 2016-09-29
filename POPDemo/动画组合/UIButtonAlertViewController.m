//
//  UIButtonAlterViewController.m
//  PodDemo
//
//  Created by duoyi on 16/9/28.
//  Copyright © 2016年 bt. All rights reserved.
//

#import "UIButtonAlertViewController.h"
#import "POPButtonAlertView.h"

@interface UIButtonAlertViewController()<POPButtonAlertViewDelegate>

@property (nonatomic, strong) UIButton *button;

@end

@implementation UIButtonAlertViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:self.button];
    
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
        _button.center = self.view.center;
    }
    return _button;
}

- (void)animation
{
//    POPButtonAlertView *showView  = [[POPButtonAlertView alloc] init];
//    showView.delegate = self;
//    showView.contentView = self.view;
//    showView.message = @"您的可用余额不足, 请及时充值";
//    showView.buttonsTitle = @[@"取消",@"确定"];
    POPButtonAlertView *showView  = [[POPButtonAlertView alloc] initWithContentView:self.view message:@"这是一个测试啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊" buttonTitles:@[@"取消", @"确定"]];
    showView.delegate = self;
    UIButton *button              = (UIButton *)[showView viewWithKey:@"secondButton"];
    [button setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [showView show];
}

- (void)alertView:(POPButtonAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    NSLog(@"%ld", buttonIndex);
    [alertView hide];
}
@end
