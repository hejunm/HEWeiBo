//
//  HEControllerTool.m
//  Weibo
//
//  Created by 贺俊孟 on 15/9/17.
//  Copyright (c) 2015年 贺俊孟. All rights reserved.
//

#import "HEControllerTool.h"
#import "HETabBarViewController.h"
#import "HENewfeatureViewController.h"

@implementation HEControllerTool
+ (void)chooseRootViewController{
    
    // 版本号关键字
    NSString *versionKey = (__bridge NSString *)kCFBundleVersionKey;
    // 获取当前运行软件的版本号
    NSString *currentVersion = [NSBundle mainBundle].infoDictionary[versionKey];
    
    // 获取前一次登录时的版本号
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *lastVerson = [defaults objectForKey:versionKey];
    
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    if ([lastVerson isEqualToString:currentVersion]) {
       window.rootViewController = [[HETabBarViewController alloc]init];
    }else{
        
        // 将最新的版本号添加到用户偏好设置
        [defaults setObject:currentVersion forKey:versionKey];
        
        // 显示新特性
        window.rootViewController = [[HENewfeatureViewController alloc]init];
    }
    
    
}
@end
