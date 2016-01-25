//
//  HETabBarViewController.m
//  Weibo
//
//  Created by 贺俊孟 on 15/9/12.
//  Copyright (c) 2015年 贺俊孟. All rights reserved.
//

#import "HETabBarViewController.h"
#import "HENavigationViewController.h"
#import "HEHomeViewController.h"
#import "HEMessageViewController.h"
#import "HEDiscoverViewController.h"
#import "HEProfileViewController.h"
#import "HETabBar.h"
#import "HEComposeViewController.h"
#import "HEUserTool.h"
#import "HMUnreadCountParam.h"
#import "HMUnreadCountResult.h"
#import "HEAccountTool.h"
#import "HEAccount.h"


@interface HETabBarViewController ()<HETabBarDelegate,UITabBarControllerDelegate>

@property (nonatomic,weak) HEHomeViewController *home;
@property (nonatomic,weak) HEMessageViewController *message;
@property (nonatomic,weak) HEProfileViewController *profile;
@property (nonatomic,strong) UIViewController *lastSelectedVC; //上一次选择的控制器
@end

@implementation HETabBarViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 添加自定义的 tabBar
    [self addCustomTabBar];
    
    // 添加子视图
    [self addAllChildVcs];
    
    // 定时获取未读数
    NSTimer *timer = [NSTimer timerWithTimeInterval:10 target:self selector:@selector(getUnreadCount) userInfo:nil repeats:YES];
    [[NSRunLoop mainRunLoop]addTimer:timer forMode:NSRunLoopCommonModes];
    
    // 设置UITabBarControllerDelegate代理， 当选择控制器时执行
    self.delegate = self;
    
    
}

// 获得用户未读数
-(void)getUnreadCount{
    HELog(@"%s",__func__);
    
    HMUnreadCountParam *param = [[HMUnreadCountParam alloc]init];
    param.uid =  [HEAccountTool account].uid;
    [HEUserTool getUnreadCountWithParam:param success:^(HMUnreadCountResult *result) {
        // 显示微博未读数
        if (result.status == 0) {
            self.home.tabBarItem.badgeValue = nil;
        } else {
            self.home.tabBarItem.badgeValue = [NSString stringWithFormat:@"%d", result.status];
        }
        
        // 显示消息未读数
        if (result.messageCount == 0) {
            self.message.tabBarItem.badgeValue = nil;
        } else {
            self.message.tabBarItem.badgeValue = [NSString stringWithFormat:@"%d", result.messageCount];
        }
        
        // 显示新粉丝数
        if (result.follower == 0) {
            self.profile.tabBarItem.badgeValue = nil;
        } else {
            self.profile.tabBarItem.badgeValue = [NSString stringWithFormat:@"%d", result.follower];
        }
        // 在图标上显示所有的未读数
        [UIApplication sharedApplication].applicationIconBadgeNumber = result.totalCount;
        HELog(@"总未读数--%d", result.totalCount);
    } failure:^(NSError *error) {
        HELog(@"获得用户未读数 --->  失败");
    }];
}

/**
    添加自定义的tabBar
 */
- (void) addCustomTabBar{
    HETabBar *customTabBar = [[HETabBar alloc]init];
    customTabBar.tabBarDelegate = self;
    [self setValue:customTabBar forKey:@"tabBar"];
}

/**
    添加所有的子控制器
 */
- (void) addAllChildVcs{
    // 主页
    HEHomeViewController *home = [[HEHomeViewController alloc]init];
    [self addChildViewController:home title:@"主页" imageName:@"tabbar_home" selectedImageName:@"tabbar_home_selected"];
    self.home = home;
    self.lastSelectedVC = home;
    
    // 消息
    HEMessageViewController *message = [[HEMessageViewController alloc]init];
    [self addChildViewController:message title:@"消息" imageName:@"tabbar_message_center" selectedImageName:@"tabbar_message_center_selected"];
    self.message = message;
    
    // 发现
    HEDiscoverViewController *discover = [[HEDiscoverViewController alloc]init];
    [self addChildViewController:discover title:@"发现" imageName:@"tabbar_discover" selectedImageName:@"tabbar_discover_selected"];
    
    // 我
    HEProfileViewController *profile = [[HEProfileViewController alloc]init];
    [self addChildViewController:profile title:@"我" imageName:@"tabbar_profile" selectedImageName:@"tabbar_profile_selected"];
    self.profile = profile;
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// 向tabBarViewController控制器中添加子控制器
-(void) addChildViewController:(UIViewController *)childController title:(NSString *)title imageName:(NSString *)imageName selectedImageName:(NSString *)selectedImageName{
    
    
    // 设置title 一行顶两行
    childController.title = title;
    //childController.tabBarItem.title =title;
    //childController.navigationItem.title = title;
    
    // 设置普通状态下图标
    childController.tabBarItem.image = [UIImage imageWithName:imageName];
    
    // 设置选中的图标 iOS7 之后， 选中的图片自动渲染成为蓝色， 要告诉它不要渲染
    UIImage *selectedImage = [UIImage imageWithName:selectedImageName];
    if (iOS7) {
       selectedImage = [selectedImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    }
    childController.tabBarItem.selectedImage = selectedImage;
    
    // 设置选中状态的文字属性
    NSMutableDictionary *textAttrs = [NSMutableDictionary dictionary];
    textAttrs[NSForegroundColorAttributeName] = [UIColor orangeColor];
    textAttrs[NSFontAttributeName] = [UIFont systemFontOfSize:15];
    [childController.tabBarItem setTitleTextAttributes:textAttrs forState:UIControlStateSelected];
    
    //设置导航控制器
    HENavigationViewController *navigationVC =[[HENavigationViewController alloc]initWithRootViewController:childController];
    
    // 添加到控制器
    [self addChildViewController:navigationVC];
}

#pragma mark HETabBarDelegate
//#warning 这里有问题， 导航栏的标题主题颜色不对！
- (void)tabBarDidClickedPlusButton:(HETabBar *)tabBar{
    
    HEComposeViewController *composeVc = [[HEComposeViewController alloc]init];
    HENavigationViewController *navigationVC =[[HENavigationViewController alloc]initWithRootViewController:composeVc];
    [self presentViewController:navigationVC animated:YES completion:nil];
}

#pragma mark UITabBarControllerDelegate
- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UINavigationController *)viewController{
    UIViewController *selectedVC = [viewController.viewControllers firstObject];
    
    if ([selectedVC isKindOfClass:[HEHomeViewController class]]) {
        if (self.lastSelectedVC == viewController) {
            [self.home refreshFromSelf:YES];
        }else{
            [self.home refreshFromSelf:NO];
        }
    }
    self.lastSelectedVC = viewController;
}


@end
