//
//  HEEmotionTool.h
//  Weibo
//
//  Created by 贺俊孟 on 15/11/22.
//  Copyright © 2015年 贺俊孟. All rights reserved.
//  表情工具类

#import <Foundation/Foundation.h>
@class HEEmotion;

@interface HEEmotionTool : NSObject
/**
 *  默认表情
 */
+ (NSArray *)defaultEmotions;
/**
 *  emoji表情
 */
+ (NSArray *)emojiEmotions;
/**
 *  浪小花表情
 */
+ (NSArray *)lxhEmotions;
/**
 *  最近表情
 */
+ (NSArray *)recentEmotions;

/**
 *  根据表情的文字描述找出对应的表情对象
 */
+ (HEEmotion *)emotionWithDesc:(NSString *)desc;

/**
 *  保存最近使用的表情
 */
+ (void)addRecentEmotion:(HEEmotion *)emotion;
@end
