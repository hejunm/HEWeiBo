//
//  EmotionKeyboardToolbar.m
//  Weibo
//
//  Created by 贺俊孟 on 15/11/23.
//  Copyright © 2015年 贺俊孟. All rights reserved.
//

#import "EmotionKeyboardToolbar.h"

// 工具栏的按钮数量
#define EmotionKeyboardToolbarButtonMaxCount 4

@interface EmotionKeyboardToolbar()

/** 选中的button */
@property (nonatomic,weak) UIButton *selectedButton; 

@end



@implementation EmotionKeyboardToolbar

-(instancetype) initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        
        // 1.添加4个按钮
        [self setupButton:@"最近" tag:HEEmotionTypeRecent];
        [self setupButton:@"默认" tag:HEEmotionTypeDefault];
        [self setupButton:@"Emoji" tag:HEEmotionTypeEmoji];
        [self setupButton:@"浪小花" tag:HEEmotionTypeLxh];
    }
    return self;
}

/**
 *  添加按钮
 *
 *  @param title 按钮文字
    @param tag   按钮类型
 */
- (UIButton *)setupButton:(NSString *)title tag:(HEEmotionType)tag
{
    UIButton *button = [[UIButton alloc] init];
    button.tag = tag;
    
    // 文字
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [button setTitleColor:[UIColor darkGrayColor] forState:UIControlStateSelected];
    [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    button.titleLabel.font = [UIFont systemFontOfSize:13];
    
    // 添加按钮
    [self addSubview:button];
    
    // 设置背景图片
    NSInteger count = self.subviews.count;
    if (count == 1) { // 第一个按钮
        [button setBackgroundImage:[UIImage resizedImage:@"compose_emotion_table_left_normal"] forState:UIControlStateNormal];
        [button setBackgroundImage:[UIImage resizedImage:@"compose_emotion_table_left_selected"] forState:UIControlStateSelected];
    } else if (count == EmotionKeyboardToolbarButtonMaxCount) { // 最后一个按钮
        [button setBackgroundImage:[UIImage resizedImage:@"compose_emotion_table_right_normal"] forState:UIControlStateNormal];
        [button setBackgroundImage:[UIImage resizedImage:@"compose_emotion_table_right_selected"] forState:UIControlStateSelected];
    } else { // 中间按钮
        [button setBackgroundImage:[UIImage resizedImage:@"compose_emotion_table_mid_normal"] forState:UIControlStateNormal];
        [button setBackgroundImage:[UIImage resizedImage:@"compose_emotion_table_mid_selected"] forState:UIControlStateSelected];
    }
    return button;
}



/** 监听按钮点击 */
- (void)buttonClick:(UIButton *)button
{
    // 1.控制按钮状态
    self.selectedButton.selected = NO;
    button.selected = YES;
    self.selectedButton = button;
    
    // 2.通知代理
    if ([self.delegate respondsToSelector:@selector(emotionToolbar:didSelectedButton:)]) {
        [self.delegate emotionToolbar:self didSelectedButton:button.tag];
    }
}

/** 设置代理*/
-(void) setDelegate:(id<EmotionKeyboardToolbarDelegate>)delegate{
    _delegate = delegate;
    
    // 设置默认选中的button
    UIButton *defauleBtn = (UIButton *)[self viewWithTag:HEEmotionTypeDefault];
    [self buttonClick:defauleBtn];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    // 设置工具条按钮的frame
    CGFloat buttonW = self.width / EmotionKeyboardToolbarButtonMaxCount;
    CGFloat buttonH = self.height;
    for (int i = 0; i<EmotionKeyboardToolbarButtonMaxCount; i++) {
        UIButton *button = self.subviews[i];
        button.width = buttonW;
        button.height = buttonH;
        button.x = i * buttonW;
    }
}


@end
