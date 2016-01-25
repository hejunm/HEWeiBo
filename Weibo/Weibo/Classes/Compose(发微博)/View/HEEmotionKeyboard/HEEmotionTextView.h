//
//  HEEmotionTextView.h
//  Weibo
//
//  Created by 贺俊孟 on 15/11/24.
//  Copyright © 2015年 贺俊孟. All rights reserved.
//  可以显示出表情的自定义输入框

#import "HETextView.h"
@class HEEmotion;

@interface HEEmotionTextView : HETextView

/**
 *  拼接表情到最后面
 */
- (void)appendEmotion:(HEEmotion *)emotion;

/**
 *  具体的文字内容
 */
- (NSString *)realText;

@end
