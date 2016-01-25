//
//  EmotionKeyboardGridView.m
//  Weibo
//
//  Created by 贺俊孟 on 15/11/23.
//  Copyright © 2015年 贺俊孟. All rights reserved.
//

#import "EmotionKeyboardGridView.h"
#import "EmotionView.h"
#import "HEEmotion.h"

@interface EmotionKeyboardGridView()
/** 删除按钮*/
@property (nonatomic, weak) UIButton *deleteButton;

/** emotionViews 存储所有的表情view*/
@property (nonatomic,strong) NSMutableArray *emotionViews;

@end

@implementation EmotionKeyboardGridView

-(instancetype) initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        //创建删除按钮
        // 添加删除按钮
        UIButton *deleteButton = [[UIButton alloc] init];
        [deleteButton setImage:[UIImage imageWithName:@"compose_emotion_delete"] forState:UIControlStateNormal];
        [deleteButton setImage:[UIImage imageWithName:@"compose_emotion_delete_highlighted"] forState:UIControlStateHighlighted];
        [deleteButton addTarget:self action:@selector(deleteClick) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:deleteButton];
        self.deleteButton = deleteButton;
        
        /** 添加 emotionViews */
        for (NSInteger i=0; i<HMEmotionMaxCountPerPage; i++) {
            EmotionView *emotionView = [[EmotionView alloc]init];
            [self addSubview:emotionView];
            [emotionView addTarget:self action:@selector(emotionViewClick:) forControlEvents:UIControlEventTouchUpInside];
            [self.emotionViews addObject:emotionView];
        }
    }
    return self;
}

/** 将一页中的emotion模型添加到对应的View上*/
-(void) setEmotionsForPerPage:(NSArray *)emotionsForPerPage{
    _emotionsForPerPage  = emotionsForPerPage;
    HELog(@"%s  对每一页设置表情 ",__func__);
    HELog(@"%@",_emotionsForPerPage);
    
    NSInteger emotionCount = emotionsForPerPage.count;
    
    for (NSInteger i=0; i<HMEmotionMaxCountPerPage; i++) {
        if (i<emotionCount) {
            EmotionView *emotionView = [self.emotionViews objectAtIndex:i];
            HEEmotion *emotion = [_emotionsForPerPage objectAtIndex:i];
            emotionView.emotion = emotion;
            emotionView.hidden = NO;
        }else{ //没有使用到的emotionView
            EmotionView *emotionView = [self.emotionViews objectAtIndex:i];
            emotionView.hidden = YES;
        }
    }
    
}


-(void)layoutSubviews{
    [super layoutSubviews];
    CGFloat emotionViewW = (self.width - 2.0*HMEmotionMargin)/HMEmotionMaxCols;
    CGFloat emotionViewH = emotionViewW;
    CGFloat emotionViewX = 0;
    CGFloat emotionViewY = 0;
    
    // 1, 设置所有表情的frame
    for (NSInteger i=0; i<HMEmotionMaxCountPerPage; i++) {
        emotionViewX = (i%HMEmotionMaxCols)*emotionViewW + HMEmotionMargin;
        emotionViewY = (i/HMEmotionMaxCols)*emotionViewH + HMEmotionMargin;
        EmotionView *emotionView = [self.emotionViews objectAtIndex:i];
        emotionView.frame = CGRectMake(emotionViewX, emotionViewY, emotionViewW, emotionViewH);
    }
    
    //设置删除按钮的frame
    emotionViewX = (HMEmotionMaxCols-1)*emotionViewW +HMEmotionMargin;
    emotionViewY = (HMEmotionMaxRows -1)*emotionViewH + HMEmotionMargin;
    self.deleteButton.frame = CGRectMake(emotionViewX, emotionViewY, emotionViewW, emotionViewH);
}

/** 点击删除按钮*/
-(void) deleteClick{
    HELog(@"%s  点击了删除按钮", __func__);
    
    //发送删除表情的通知
     [[NSNotificationCenter defaultCenter] postNotificationName:HMEmotionDidDeletedNotification object:nil userInfo:nil];
}

/** 点击了某一个表情*/
-(void) emotionViewClick:(EmotionView *)sender{
    if (sender) {
        HELog(@"%s  点击--%@--表情", __func__,sender);
        
        //1, 将点击的表情存储到 “最近” 中
        
        //2, 发送点击某一个表情的通知
        [[NSNotificationCenter defaultCenter] postNotificationName:HMEmotionDidSelectedNotification object:nil userInfo:@{HMSelectedEmotion : sender.emotion}];
    }
    
}




#pragma mark 数据懒加载
-(NSMutableArray *)emotionViews{
    if (_emotionViews == nil) {
        _emotionViews = [NSMutableArray array];
    }
    return _emotionViews;
}


@end
