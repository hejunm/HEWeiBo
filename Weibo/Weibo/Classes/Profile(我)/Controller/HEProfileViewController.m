//
//  HEProfileViewController.m
//  Weibo
//
//  Created by 贺俊孟 on 15/9/12.
//  Copyright (c) 2015年 贺俊孟. All rights reserved.
//

#import "HEProfileViewController.h"
#import "HECommonGroup.h"
#import "HECommonItem.h"
#import "HECommonArrowItem.h"
#import "HESettingViewController.h"

@implementation HEProfileViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setupGroups];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"设置" style:UIBarButtonItemStyleDone target:self action:@selector(setting)];
}

/** 设置groups */
-(void) setupGroups{
    [self setupGroup0];
    [self setupGroup1];
}


/** 设置第一个分组*/
-(void) setupGroup0{
    HECommonGroup *group = [HECommonGroup group];
    [self.groups addObject:group];
    
    HECommonItem *newFriend = [HECommonItem itemWithTitle:@"新的好友" Icon:@"new_friend" ];
    newFriend.badgeValue = @"50";
    
    group.items = @[newFriend];
}

/** 设置第二个分组*/

-(void) setupGroup1{
    // 1.创建组
    HECommonGroup *group = [HECommonGroup group];
    [self.groups addObject:group];
    
    // 2.设置组的所有行数据
    HECommonArrowItem *album = [HECommonArrowItem itemWithTitle:@"我的相册" Icon:@"album"];
    album.subTitle = @"(10)";
  
    HECommonArrowItem *collect = [HECommonArrowItem itemWithTitle:@"我的收藏" Icon:@"collect"];
    collect.subTitle = @"(10)";
    collect.badgeValue = @"1";
    
    HECommonArrowItem *like = [HECommonArrowItem itemWithTitle:@"赞" Icon:@"like"];
    like.subTitle = @"(36)";
    
    group.items = @[album, collect, like];

}

/** 设置*/
-(void) setting{
    HESettingViewController *settingVC = [[HESettingViewController alloc]init];
    [self.navigationController pushViewController:settingVC animated:YES];
}


@end
