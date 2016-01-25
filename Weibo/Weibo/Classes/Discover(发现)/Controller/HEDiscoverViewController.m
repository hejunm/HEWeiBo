//
//  HEDiscoverViewController.m
//  Weibo
//
//  Created by 贺俊孟 on 15/9/12.
//  Copyright (c) 2015年 贺俊孟. All rights reserved.
//

#import "HEDiscoverViewController.h"
#import "HECommonGroup.h"
#import "HECommonItem.h"
#import "HECommonLabelItem.h"
#import "HECommonSwitchItem.h"
#import "HECommonArrowItem.h"

#import "HEOneViewController.h"
#import "HETwoViewController.h"

#import "HMSearchBar.h"


@implementation HEDiscoverViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // 搜索框
    HMSearchBar *searchBar = [HMSearchBar searchBar];
    searchBar.width = 300;
    searchBar.height = 30;
    self.navigationItem.titleView = searchBar;
    
    // 初始化模型数据
    [self setupGroups];
}

/**
*  初始化模型数据;
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
    
    // 2.设置组的基本数据
    group.headerString = @"第0组头部";
    group.footerString = @"第0组尾部的详细信息";
    
    // 3.设置组的所有行数据
    HECommonArrowItem *hotStatus = [HECommonArrowItem itemWithTitle:@"热门微博" Icon:@"hot_status"];
    hotStatus.subTitle = @"笑话，娱乐，神最右都搬到这啦";
    hotStatus.destVcClass = [HEOneViewController class];
    
    HECommonArrowItem *findPeople = [HECommonArrowItem itemWithTitle:@"找人" Icon:@"find_people"];
    findPeople.badgeValue = @"N";
    findPeople.destVcClass = [HETwoViewController class];
    findPeople.subTitle = @"名人、有意思的人尽在这里";
    
    group.items = @[hotStatus, findPeople];
}

- (void)setupGroup1
{
    // 1.创建组
    HECommonGroup *group = [HECommonGroup group];
    [self.groups addObject:group];
    
    // 2.设置组的所有行数据
    HECommonItem *gameCenter = [HECommonItem itemWithTitle:@"游戏中心" Icon:@"game_center"];
    gameCenter.destVcClass = [HETwoViewController class];
    
    HECommonLabelItem *near = [HECommonLabelItem itemWithTitle:@"周边" Icon:@"near"];
    near.destVcClass = [HETwoViewController class];
    near.rightLabelText = @"测试文字";
    
    HECommonSwitchItem *app = [HECommonSwitchItem itemWithTitle:@"应用" Icon:@"app"];
    app.destVcClass = [HETwoViewController class];
    app.badgeValue = @"10";
    
    group.items = @[gameCenter, near, app];
}

- (void)setupGroup2
{
    // 1.创建组
    HECommonGroup *group = [HECommonGroup group];
    [self.groups addObject:group];
    
    // 2.设置组的所有行数据
    HECommonSwitchItem *video = [HECommonSwitchItem itemWithTitle:@"视频" Icon:@"video"];
    video.operation = ^{
        [MBProgressHUD showSuccess:@"----点击了视频---"];
    };
    
    HECommonSwitchItem *music = [HECommonSwitchItem itemWithTitle:@"音乐" Icon:@"music"];
    music.operation = ^{
        [MBProgressHUD showSuccess:@"----点击了音乐---"];
    };
    
    
    HECommonItem *movie = [HECommonItem itemWithTitle:@"电影" Icon:@"movie"];
    movie.operation = ^{
        [MBProgressHUD showSuccess:@"----点击了电影---"];
    };
    
    
    HECommonLabelItem *cast = [HECommonLabelItem itemWithTitle:@"播客" Icon:@"cast"];
    cast.operation = ^{
       [MBProgressHUD showSuccess:@"----点击了播客---"];
    };
    cast.badgeValue = @"5";
    cast.subTitle = @"(10)";
    
    HECommonArrowItem *more = [HECommonArrowItem itemWithTitle:@"更多" Icon:@"more"];
    //    more.badgeValue = @"998";
    
    group.items = @[video, music, movie, cast, more];
}

@end
