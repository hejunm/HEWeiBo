//
//  UIBarButtonItem+category.h
//  Weibo
//
//  Created by 贺俊孟 on 15/9/12.
//  Copyright (c) 2015年 贺俊孟. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (category)
/**
 使用图片创建 导航条中的  UIBarButtonItem
 imageName:            普通状态下图片名
 highLightImageName    高亮状态下的图片名
 target                响应对象
 action                响应方法
 */
+ (UIBarButtonItem *)itemWithImageName:(NSString*)imageName highLightImageName:(NSString*)highLightImageName target:(id)target action:(SEL)action;
@end
