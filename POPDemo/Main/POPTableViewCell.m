//
//  POPTableViewCell.m
//  PodDemo
//
//  Created by duoyi on 16/9/29.
//  Copyright © 2016年 bt. All rights reserved.
//

#import "POPTableViewCell.h"
#import "POP.h"
#import "UIFont+Fonts.h"

@interface POPTableViewCell ()

@end

@implementation POPTableViewCell

- (UILabel *)label
{
    if (!_label)
    {
        _label = [[UILabel alloc] init];
        _label.font = [UIFont HeitiSCWithFontSize:17];
        _label.frame = CGRectMake(20, 0, 200, self.frame.size.height);
    }
    return _label;
}

- (void)setHighlighted:(BOOL)highlighted animated:(BOOL)animated
{
    
    [super setHighlighted:highlighted animated:animated];
    // cell动画
    if (self.highlighted)
    {
        POPBasicAnimation *scaleAnimation = [POPBasicAnimation animationWithPropertyNamed:kPOPViewScaleXY];
        scaleAnimation.duration           = 0.1f;
        scaleAnimation.toValue            = [NSValue valueWithCGPoint:CGPointMake(0.95, 0.95)];
        [self.label pop_addAnimation:scaleAnimation forKey:@"scaleAnimation"];
        // 如果使用self.textLabel点击会有bug
    } else
    {
        POPSpringAnimation *scaleAnimation = [POPSpringAnimation animationWithPropertyNamed:kPOPViewScaleXY];
        scaleAnimation.toValue             = [NSValue valueWithCGPoint:CGPointMake(1, 1)];
        scaleAnimation.velocity            = [NSValue valueWithCGPoint:CGPointMake(2, 2)];
        scaleAnimation.springBounciness    = 20.f;
        [self.label pop_addAnimation:scaleAnimation forKey:@"scaleAnimation"];
    }
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        [self.contentView addSubview:self.label];
    }
    return self;
}
@end
