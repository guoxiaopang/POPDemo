//
//  POPButtonAlterView.h
//  PodDemo
//
//  Created by duoyi on 16/9/28.
//  Copyright © 2016年 bt. All rights reserved.
//

#import <UIKit/UIKit.h>

@class POPButtonAlertView;

@protocol POPButtonAlertViewDelegate <NSObject>

- (void)alertView:(POPButtonAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex;

@end

@interface POPButtonAlertView : UIView

@property (nonatomic, weak)id<POPButtonAlertViewDelegate> delegate;
@property (nonatomic, strong) UIView *contentView;
@property (nonatomic, strong) NSArray *buttonsTitle;
@property (nonatomic, copy) NSString *message;

- (void)show;
- (void)hide;
- (UIView *)viewWithKey:(NSString *)key;

- (instancetype)initWithContentView:(UIView *)view message:(NSString *)message buttonTitles:(NSArray *)titles;

@end
