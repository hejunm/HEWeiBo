//
//  HECommonItem.m
//  Weibo
//
//  Created by 贺俊孟 on 15/11/25.
//  Copyright © 2015年 贺俊孟. All rights reserved.
//

#import "HECommonItem.h"

@implementation HECommonItem

/** 创建含有标题和图标的item */
+ (instancetype)itemWithTitle:(NSString *)title Icon:(NSString *)icon{
    HECommonItem *item = [[self alloc]init];
    item.title =  [title copy];
    item.icon = [icon copy];
    return item;
}

/** 创建只有图标的item */
+ (instancetype)itemWithTitle:(NSString *)title{
    return [self itemWithTitle:title Icon:nil];
}
@end
