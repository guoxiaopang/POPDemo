//
//  BasicTimeViewController.m
//  PodDemo
//
//  Created by duoyi on 16/9/27.
//  Copyright © 2016年 bt. All rights reserved.
//

#import "CustomCountViewController.h"
#import "POP.h"

@interface CustomCountViewController ()

@property (nonatomic, strong) UILabel *countLabel;
@property (nonatomic, strong) UIButton *button;

@end

@implementation CustomCountViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.countLabel];
    [self.view addSubview:self.button];
}

#pragma mark -懒加载
- (UILabel *)countLabel
{
    if (!_countLabel)
    {
        _countLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetWidth(self.view.frame)/2 - 50, 130, 200, 50)];
        _countLabel.text = @"00:00:00";
        _countLabel.font = [UIFont systemFontOfSize:30];
    }
    return _countLabel;
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
    POPBasicAnimation *basic = [POPBasicAnimation animation]; 
    basic.timingFunction = [CAMediaTimingFunction functionWithControlPoints:0.69 :0.11 :0.32 :0.88];
    POPAnimatableProperty *prop = [POPAnimatableProperty propertyWithName:@"count" initializer:^(POPMutableAnimatableProperty *prop) {
        prop.readBlock = ^(id obj, CGFloat values[]){ //告诉POP当前的属性值
            // obj 就是label ，value就是动画作用的属性组
           // values[0] = 0.0f; // 这里只有label上的文字，只需要value[0]。 如果是CGRectMake(x,x,x,x) 则需要value[0],value[1],value[2],value[3]
        };
        
        prop.writeBlock = ^(id obj, const CGFloat values[]){ //修改变化后的属性值
            [obj setText:[NSString stringWithFormat:@"%02d:%02d:%02d",(int)values[0]/60,(int)values[0]%60,(int)(values[0]*100)%100]]; // 从value中获取数据 赋值给Label
        };
        prop.threshold = 0.1; // 值越大block调用的次数越少 默认不去设置
    }]; // 定义pop如何操作Label上的值
    basic.property = prop;
    basic.fromValue = @(0);
    basic.toValue = @(3 * 60);
    basic.duration = 3 *60;
   // basic.beginTime = CACurrentMediaTime() + 1.0f; // 延迟1秒开始
    [self.countLabel pop_addAnimation:basic forKey:@"count"];
}

@end
