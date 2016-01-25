//
//  HETabBar.h
//  Weibo
//
//  Created by 贺俊孟 on 15/9/14.
//  Copyright (c) 2015年 贺俊孟. All rights reserved.
//

#import <UIKit/UIKit.h>

@class HETabBar;

@protocol HETabBarDelegate <NSObject>
@optional
- (void)tabBarDidClickedPlusButton:(HETabBar *)tabBar;
@end

@interface HETabBar : UITabBar
@property (nonatomic,weak) id<HETabBarDelegate> tabBarDelegate;
@end
