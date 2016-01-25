//
//  HEEmotionTool.m
//  Weibo
//
//  Created by 贺俊孟 on 15/11/22.
//  Copyright © 2015年 贺俊孟. All rights reserved.
//

#import "HEEmotionTool.h"
#import "HEEmotion.h"
#import "MJExtension.h"

@implementation HEEmotionTool

/**
 *  默认表情
 */
static NSArray *_defaultEmotions;
/**
 *  emoji表情
 */
static NSArray *_emojiEmotions;
/**
 *  浪小花表情
 */
static NSArray *_lxhEmotions;
/**
 *  最近表情
 */
static NSArray *_recentEmotions;



/**
 *  默认表情
 */
+ (NSArray *)defaultEmotions{
    if (_defaultEmotions == nil) {
        NSString *path = [[NSBundle mainBundle] pathForResource:@"info1.plist" ofType:nil];
        _defaultEmotions = [HEEmotion objectArrayWithFile:path];
    }
    return _defaultEmotions;
}
/**
 *  emoji表情
 */
+ (NSArray *)emojiEmotions{
    if (_emojiEmotions == nil) {
        NSString *path = [[NSBundle mainBundle] pathForResource:@"info2.plist" ofType:nil];
        _emojiEmotions = [HEEmotion objectArrayWithFile:path];
    }
    return _emojiEmotions;
}
/**
 *  浪小花表情
 */
+ (NSArray *)lxhEmotions{
    if (_lxhEmotions == nil) {
        NSString *path = [[NSBundle mainBundle] pathForResource:@"info3.plist" ofType:nil];
        _lxhEmotions = [HEEmotion objectArrayWithFile:path];
    }
    return _lxhEmotions;
}
/**
 *  最近表情
 */
+ (NSArray *)recentEmotions{
    
    return nil;
}

/**
 *  根据表情的文字描述找出对应的表情对象， 只在默认和浪小花中找
 */
+ (HEEmotion *)emotionWithDesc:(NSString *)desc{
     __block HEEmotion *foundEmotion = nil;
    
    // 在默认表情中进行查找
    [[HEEmotionTool defaultEmotions]enumerateObjectsUsingBlock:^(HEEmotion *emotion, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([emotion.chs isEqualToString:desc] || [emotion.cht isEqualToString:desc]) {
            foundEmotion = emotion;
            *stop = YES;
        }
        
    }];
    if (foundEmotion) return foundEmotion;
    
    // 在浪小花中进行查找
    [[HEEmotionTool lxhEmotions]enumerateObjectsUsingBlock:^(HEEmotion *emotion, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([emotion.chs isEqualToString:desc] || [emotion.cht isEqualToString:desc]) {
            foundEmotion = emotion;
            *stop = YES;
        }
    }];
    return foundEmotion;
}

/**
 *  保存最近使用的表情
 */
+ (void)addRecentEmotion:(HEEmotion *)emotion{

}

@end
