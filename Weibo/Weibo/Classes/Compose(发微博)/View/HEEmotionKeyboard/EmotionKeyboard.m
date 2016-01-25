//
//  EmotionKeyboard.m
//  Weibo
//
//  Created by 贺俊孟 on 15/11/23.
//  Copyright © 2015年 贺俊孟. All rights reserved.
//  自定义 表情键盘

#import "EmotionKeyboard.h"
#import "EmotionKeyboardListView.h"
#import "EmotionKeyboardToolbar.h"
#import "HEEmotionTool.h"
#import "HEEmotion.h"

@interface EmotionKeyboard ()<EmotionKeyboardToolbarDelegate>
/** ListView*/
@property (nonatomic,weak) EmotionKeyboardListView *emotionKeyboardListView;
/** 自定义键盘工具栏*/
@property (nonatomic,weak) EmotionKeyboardToolbar *emotionKeyboardToolbar;

/** 最近*/
@property (nonatomic ,strong)NSArray *defaultEmotion;

/** Emoji*/
@property (nonatomic ,strong)NSArray *emojiEmotion;

/** 浪小花*/
@property (nonatomic ,strong)NSArray *lxhEmotion;

@end

@implementation EmotionKeyboard


/** 获得表情键盘*/
+(instancetype) keyboard{
    return [[self alloc]init];
}

-(instancetype) initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        
        // 背景色
        self.backgroundColor = [UIColor clearColor];
        
        // 添加 EmotionKeyboardListView
        EmotionKeyboardListView *emotionKeyboardListView = [[EmotionKeyboardListView alloc]init];
        self.emotionKeyboardListView = emotionKeyboardListView;
        [self addSubview:emotionKeyboardListView];
        
        // 添加 EmotionKeyboardToolbar
        EmotionKeyboardToolbar *emotionKeyboardToolbar = [[EmotionKeyboardToolbar alloc]init];
        emotionKeyboardToolbar.backgroundColor = [UIColor clearColor];
        emotionKeyboardToolbar.delegate = self;
        self.emotionKeyboardToolbar = emotionKeyboardToolbar;
        [self addSubview:emotionKeyboardToolbar];
        
    }
    return self;
}



-(void)layoutSubviews{
    [super layoutSubviews];
    
    //设置 emotionKeyboardToolbar frame
    CGFloat toolbarW = self.width;
    CGFloat toolbarH = 35;
    CGFloat toolbarX = 0;
    CGFloat toolbarY = self.height-toolbarH;
    self.emotionKeyboardToolbar.frame = CGRectMake(toolbarX, toolbarY, toolbarW, toolbarH);
    
    //设置 emotionKeyboardListView frame
    CGFloat listViewW = self.width;
    CGFloat listViewH = toolbarY;
    CGFloat listViewX = 0;
    CGFloat listViewY = 0;
    self.emotionKeyboardListView.frame = CGRectMake(listViewX, listViewY, listViewW, listViewH);
    
}

#pragma mark EmotionKeyboardToolbarDelegate 
/**
 HEEmotionTypeRecent, // 最近
 HEEmotionTypeDefault, // 默认
 HEEmotionTypeEmoji, // Emoji
 HEEmotionTypeLxh // 浪小花
 */
- (void)emotionToolbar:(EmotionKeyboardToolbar *)toolbar didSelectedButton:(HEEmotionType)emotionType{
    HELog(@"%s   表情键盘工具栏按钮--%d--点击",__func__,emotionType);
    switch (emotionType) {
        case HEEmotionTypeRecent:{   // 最近
            self.emotionKeyboardListView.emotions = nil;
         break;
        }
        case HEEmotionTypeDefault:{  // 默认
            self.emotionKeyboardListView.emotions = self.defaultEmotion;
            break;
        }
        case HEEmotionTypeEmoji:{    // Emoji
            self.emotionKeyboardListView.emotions = self.emojiEmotion;
            break;
        }
        case HEEmotionTypeLxh:{  // 浪小花
            self.emotionKeyboardListView.emotions = self.lxhEmotion;
            break;
        }
        default:
            break;
    }
    
}

#pragma mark 懒加载表情数据
-(NSArray *)defaultEmotion{
    if (_defaultEmotion == nil) {
        _defaultEmotion = [HEEmotionTool defaultEmotions];
    }
    return _defaultEmotion;
}

-(NSArray *)emojiEmotion{
    if (_emojiEmotion == nil) {
        _emojiEmotion = [HEEmotionTool emojiEmotions];
    }
    return _emojiEmotion;
}

-(NSArray *)lxhEmotion{
    if (_lxhEmotion == nil) {
        _lxhEmotion = [HEEmotionTool lxhEmotions];
    }
    return _lxhEmotion;
}





@end
