//
//  EmotionView.m
//  Weibo
//
//  Created by 贺俊孟 on 15/11/23.
//  Copyright © 2015年 贺俊孟. All rights reserved.
//

#import "EmotionView.h"
#import "HEEmotion.h"

@implementation EmotionView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.adjustsImageWhenHighlighted = NO;
    }
    return self;
}


/** 设置表情*/
-(void)setEmotion:(HEEmotion *)emotion{
    _emotion = emotion;
    if (_emotion.isEmoji) {
        [self setTitle:_emotion.emoji forState:UIControlStateNormal];
        [self setImage:nil forState:UIControlStateNormal];

        
    }else{
        [self setTitle:nil forState:UIControlStateNormal];
        [self setImage:[UIImage imageWithName:emotion.png] forState:UIControlStateNormal];
    }
    
}



@end
