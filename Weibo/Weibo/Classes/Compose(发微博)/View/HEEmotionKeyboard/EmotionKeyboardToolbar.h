//
//  EmotionKeyboardToolbar.h
//  Weibo
//
//  Created by 贺俊孟 on 15/11/23.
//  Copyright © 2015年 贺俊孟. All rights reserved.
//  表情键盘工具栏

#import <UIKit/UIKit.h>
typedef enum {
    HEEmotionTypeRecent, // 最近
    HEEmotionTypeDefault, // 默认
    HEEmotionTypeEmoji, // Emoji
    HEEmotionTypeLxh // 浪小花
} HEEmotionType;

@class EmotionKeyboardToolbar;
@protocol EmotionKeyboardToolbarDelegate <NSObject>
@optional
- (void)emotionToolbar:(EmotionKeyboardToolbar *)toolbar didSelectedButton:(HEEmotionType)emotionType;
@end

@interface EmotionKeyboardToolbar : UIView

@property(nonatomic, weak) id<EmotionKeyboardToolbarDelegate> delegate;

@end
