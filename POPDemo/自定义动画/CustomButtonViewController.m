//
//  CustomButtonViewController.m
//  PodDemo
//
//  Created by duoyi on 16/9/27.
//  Copyright © 2016年 bt. All rights reserved.
//

#import "CustomButtonViewController.h"
#import "POP.h"

@interface CustomButtonViewController ()

@property (nonatomic, strong) UIBarButtonItem *item;
@property (nonatomic, strong) UIButton *button;
@property (nonatomic, strong) UIImageView *imageView;

@end

@implementation CustomButtonViewController
{
    BOOL _isOpen;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
   
    self.navigationItem.rightBarButtonItem = self.item;
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.imageView];
}

#pragma mark - 懒加载

- (UIImageView *)imageView
{
    if (!_imageView)
    {
        _imageView = [[UIImageView alloc] init];
        _imageView.image = [UIImage imageNamed:@"wx"];
        _imageView.frame = CGRectMake(CGRectGetWidth(self.view.frame), 64, 0, 0);
    }
    return _imageView;
}

- (UIBarButtonItem *)item
{
    if (!_item)
    {
        UIButton *button = [[UIButton alloc] init];
        [button setImage:[UIImage imageNamed:@"add"] forState:UIControlStateNormal];
        [button sizeToFit];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(click) forControlEvents:UIControlEventTouchUpInside];
        self.button = button;
        _item =[[UIBarButtonItem alloc] initWithCustomView:button];
    }
    return _item;
}

#pragma mark - Void
- (void)click
{
    [self showPopup];
}

- (void)showPopup
{
    if (_isOpen)
    {
        [self hidePop];
        return;
    }
    _isOpen = YES;
    
    POPSpringAnimation *spring = [POPSpringAnimation animationWithPropertyNamed:kPOPViewFrame];
    spring.springBounciness = 15.0f;
    spring.springSpeed = 20.0f;
    spring.toValue =  [NSValue valueWithCGRect:CGRectMake(CGRectGetWidth(self.view.frame) - 50, 64, 50, 88)];
    [self.imageView pop_addAnimation:spring forKey:@"open"];
}

- (void)hidePop
{
    POPBasicAnimation *basic = [POPBasicAnimation animationWithPropertyNamed:kPOPViewFrame];
    basic.toValue = [NSValue valueWithCGRect:CGRectMake(CGRectGetWidth(self.view.frame), 64, 0, 0)];
    [self.imageView pop_addAnimation:basic forKey:@"frameAnimation"];
    _isOpen = NO;
}

@end
