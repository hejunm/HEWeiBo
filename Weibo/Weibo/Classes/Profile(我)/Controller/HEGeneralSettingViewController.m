//
//  HEGeneralSettingViewController.m
//  Weibo
//
//  Created by 贺俊孟 on 15/11/25.
//  Copyright © 2015年 贺俊孟. All rights reserved.
//

#import "HEGeneralSettingViewController.h"
#import "HECommonGroup.h"
#import "HECommonItem.h"
#import "HECommonLabelItem.h"
#import "HECommonSwitchItem.h"
#import "HECommonArrowItem.h"

@interface HEGeneralSettingViewController ()

@end

@implementation HEGeneralSettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"通用设置";
    
    [self setupGroups];
}

/**
 *  初始化模型数据
 */
- (void)setupGroups
{
    [self setupGroup0];
    [self setupGroup1];
    [self setupGroup2];
}

- (void)setupGroup0
{
    // 1.创建组
    HECommonGroup *group = [HECommonGroup group];
    [self.groups addObject:group];
    
    // 2.设置组的所有行数据
    HECommonLabelItem *readMdoe = [HECommonLabelItem itemWithTitle:@"阅读模式"];
    readMdoe.rightLabelText = @"有图模式";
    group.items = @[readMdoe];
}

- (void)setupGroup1
{
    // 1.创建组
    HECommonGroup *group = [HECommonGroup group];
    [self.groups addObject:group];
    
    // 2.设置组的所有行数据
    HECommonSwitchItem *receiveNoti = [HECommonSwitchItem itemWithTitle:@"声音"];
    receiveNoti.isOn = NO;
    group.items = @[receiveNoti];
}
- (void)setupGroup2
{
    // 1.创建组
    HECommonGroup *group = [HECommonGroup group];
    [self.groups addObject:group];
    
    // 2.设置组的所有行数据
    HECommonSwitchItem *showShortName = [HECommonSwitchItem itemWithTitle:@"显示备注"];
    showShortName.isOn = YES;
    group.items = @[showShortName];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
