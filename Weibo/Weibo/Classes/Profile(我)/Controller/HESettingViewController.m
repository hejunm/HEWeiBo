//
//  HESettingViewController.m
//  Weibo
//
//  Created by 贺俊孟 on 15/11/25.
//  Copyright © 2015年 贺俊孟. All rights reserved.
//

#import "HESettingViewController.h"
#import "HECommonGroup.h"
#import "HECommonItem.h"
#import "HECommonLabelItem.h"
#import "HECommonSwitchItem.h"
#import "HECommonArrowItem.h"
#import "HEGeneralSettingViewController.h"
#import "HEAccountTool.h"
#import "MBProgressHUD+MJ.h"

@interface HESettingViewController ()

@end

@implementation HESettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"设置";
    
    [self setupGroups];
    
    [self setupFooter];
    // Do any additional setup after loading the view.
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
    HECommonArrowItem *newFriend = [HECommonArrowItem itemWithTitle:@"帐号管理"];
    
    group.items = @[newFriend];
}

- (void)setupGroup1
{
    // 1.创建组
    HECommonGroup *group = [HECommonGroup group];
    [self.groups addObject:group];
    
    // 2.设置组的所有行数据
    HECommonArrowItem *newFriend = [HECommonArrowItem itemWithTitle:@"主题、背景"];
    newFriend.operation = ^(){
        HELog(@"点击cell 执行block");
        [MBProgressHUD showSuccess:@"点击cell 执行block"];
    };
    
    group.items = @[newFriend];
}

- (void)setupGroup2
{
    // 1.创建组
    HECommonGroup *group = [HECommonGroup group];
    [self.groups addObject:group];
    
    // 2.设置组的所有行数据
    HECommonArrowItem *generalSetting = [HECommonArrowItem itemWithTitle:@"通用设置"];
    generalSetting.destVcClass = [HEGeneralSettingViewController class];
    
    group.items = @[generalSetting];
}

- (void)setupFooter
{
    // 1.创建按钮
    UIButton *logout = [[UIButton alloc] init];
    
    // 2.设置属性
    logout.titleLabel.font = [UIFont systemFontOfSize:14];
    [logout setTitle:@"退出当前帐号" forState:UIControlStateNormal];
    [logout setTitleColor:HEColor(255, 10, 10) forState:UIControlStateNormal];
    [logout setBackgroundImage:[UIImage resizedImage:@"common_card_background"] forState:UIControlStateNormal];
    [logout setBackgroundImage:[UIImage resizedImage:@"common_card_background_highlighted"] forState:UIControlStateHighlighted];
    
    [logout addTarget:self action:@selector(logout) forControlEvents:UIControlEventTouchUpInside];
    
    // 3.设置尺寸(tableFooterView和tableHeaderView的宽度跟tableView的宽度一样)
    logout.height = 35;
    
    self.tableView.tableFooterView = logout;
}

// 退出当前账户
-(void) logout{
    [HEAccountTool save:nil];
    [MBProgressHUD showSuccess:@"退出账号成功"];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
