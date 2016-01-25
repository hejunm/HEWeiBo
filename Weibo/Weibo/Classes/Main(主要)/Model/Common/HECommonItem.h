//
//  HECommonItem.h
//  Weibo
//
//  Created by 贺俊孟 on 15/11/25.
//  Copyright © 2015年 贺俊孟. All rights reserved.
//  一个cell 的信息

#import <Foundation/Foundation.h>

@interface HECommonItem : NSObject

/** 左侧图标*/
@property (nonatomic ,copy) NSString *icon;

/** title*/
@property (nonatomic ,copy) NSString *title;

/** subTitle*/
@property (nonatomic ,copy) NSString *subTitle;

/** 右边显示的数字标记 */
@property (nonatomic ,copy) NSString *badgeValue;

/** 点击这行cell，需要调转到哪个控制器 */
@property (nonatomic, assign) Class destVcClass;

/** 点击这一行需要跳转的控制器*/
@property (nonatomic, copy) void (^operation)();

/** 创建含有标题和图标的item */
+ (instancetype)itemWithTitle:(NSString *)title Icon:(NSString *)icon;

/** 创建只有图标的item */
+ (instancetype)itemWithTitle: (NSString *)title;
@end
