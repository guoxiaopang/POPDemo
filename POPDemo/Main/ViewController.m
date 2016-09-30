//
//  ViewController.m
//  PodDemo
//
//  Created by duoyi on 16/9/26.
//  Copyright © 2016年 bt. All rights reserved.
//

#import "ViewController.h"
#import "POP.h"
#import "BasicMoveViewController.h"
#import "BasicScaleViewController.h"
#import "CustomButtonViewController.h"
#import "SpringBasicViewController.h"
#import "CustomCountViewController.h"
#import "SpringCircleViewController.h"
#import "PushViewController.h"
#import "ProgressViewController.h"
#import "DecayViewController.h"
#import "UIButtonAlertViewController.h"
#import "POPTableViewCell.h"

static NSString *ident = @"ident";

@interface ViewController ()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *titleArray;
@property (nonatomic, strong) NSMutableArray *classArray;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.title = @"POP";
    [self.view addSubview:self.tableView];
}

#pragma mark - 懒加载
- (UITableView *)tableView
{
    if (!_tableView)
    {
        _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        [_tableView registerClass:[POPTableViewCell class] forCellReuseIdentifier:ident];
        _tableView.showsVerticalScrollIndicator = NO;
    }
    return _tableView;
}

- (NSMutableArray *)titleArray
{
    if (!_titleArray)
    {
        _titleArray = [NSMutableArray array];
        [_titleArray addObjectsFromArray:@[@[@"移动动画",@"放大缩小动画"],
                                           @[@"弹簧动画",@"画圆"],
                                           @[@"减速动画"],
                                           @[@"选择框动画",@"秒表"],
                                           @[@"弹出视图",@"进度条",@"提示框"],
                                           @[@"测试",@"测试",@"测试"]]];
    }
    return _titleArray;
}

- (NSMutableArray *)classArray
{
    if (!_classArray)
    {
        _classArray = [NSMutableArray array];
        [_classArray addObjectsFromArray:@[
                                           @[@"BasicMoveViewController", @"BasicScaleViewController"],
                                           @[@"SpringBasicViewController", @"SpringCircleViewController"],
                                           @[@"DecayViewController"],
                                           @[@"CustomButtonViewController",@"CustomCountViewController"],
                                           @[@"PushViewController",@"ProgressViewController",@"UIButtonAlertViewController"]]];
    }
    return _classArray;
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSArray *array = self.titleArray[section];
    return array.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    POPTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ident];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    NSArray *array = self.titleArray[indexPath.section];
    cell.label.text = array[indexPath.row];
    return cell;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 6;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    switch (section)
    {
        case 0:
            return @"基础动画";
            break;
        case 1:
            return @"弹簧动画";
            break;
        case 2:
            return @"减速动画";
            break;
        case 3:
            return @"自定义动画";
            break;
        case 4:
            return @"动画组合";
            break;
        case 5:
            return @"测试";
            break;
        default:
            break;
    }
    return nil;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.section == 5)
    {
        return;
    }
    NSString *str = self.classArray[indexPath.section][indexPath.row];
    UIViewController *controller = [[NSClassFromString(str) alloc] init];
    [self.navigationController pushViewController:controller animated:YES];
}

@end
