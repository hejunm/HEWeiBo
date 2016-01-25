//
//  UIBarButtonItem+category.m
//  Weibo
//
//  Created by 贺俊孟 on 15/9/12.
//  Copyright (c) 2015年 贺俊孟. All rights reserved.
//

#import "UIBarButtonItem+category.h"

@implementation UIBarButtonItem (category)
+ (UIBarButtonItem *)itemWithImageName:(NSString*)imageName highLightImageName:(NSString*)highLightImageName target:(id)target action:(SEL)action{
    UIButton *btn = [[UIButton alloc]init];
    [btn setBackgroundImage:[UIImage imageWithName:imageName] forState:UIControlStateNormal];
    [btn setBackgroundImage:[UIImage imageWithName:highLightImageName] forState:UIControlStateHighlighted];
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    
    // 设置按钮的尺寸
    btn.size = btn.currentBackgroundImage.size;
    
    // 创建UIBarButtonItem并返回
    return [[UIBarButtonItem alloc]initWithCustomView:btn];
}
@end
