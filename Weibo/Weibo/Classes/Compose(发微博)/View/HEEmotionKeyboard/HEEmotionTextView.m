//
//  HEEmotionTextView.m
//  Weibo
//
//  Created by 贺俊孟 on 15/11/24.
//  Copyright © 2015年 贺俊孟. All rights reserved.
//

#import "HEEmotionTextView.h"
#import "HEEmotion.h"
#import "HEEmotionTextAttachment.h"

@implementation HEEmotionTextView


/**
 *  拼接表情到最后面
 */
- (void)appendEmotion:(HEEmotion *)emotion{
    
    // 1, 判断表情类型
    if (emotion.isEmoji) { // 👿
        [self insertText:emotion.emoji];
    }else{ //图片表情
        
        // 2, 获取原字符串
        NSMutableAttributedString *attributedString  = [[NSMutableAttributedString alloc]initWithAttributedString:self.attributedText];
        
        // 3, 获得焦点位置
        NSInteger forceIndex = self.selectedRange.location;
        
        // 4,创建附件
        HEEmotionTextAttachment *textAttachment = [[HEEmotionTextAttachment alloc]init];
        textAttachment.emotion = emotion;
        textAttachment.bounds = CGRectMake(0, -3, self.font.lineHeight, self.font.lineHeight);
        
        // 5, 创建富文本字符串
        NSAttributedString *attributedStr = [NSAttributedString attributedStringWithAttachment:textAttachment];
        
        
        // 6, 插入到原来原富文本
        [attributedString insertAttributedString:attributedStr atIndex:forceIndex];
        
        
        // 7, 设置字体, 否则表情会变小
        [attributedString addAttribute:NSFontAttributeName value:self.font range:NSMakeRange(0, attributedString.length)];
        
        self.attributedText  = attributedString;
        
        // 8, 设置光标的位置
        self.selectedRange = NSMakeRange(forceIndex+1, 0);
    }
    

}

/**
 *  具体的文字内容
 */
- (NSString *)realText{
    NSMutableString *str = [NSMutableString string];
    [self.attributedText enumerateAttributesInRange:NSMakeRange(0,self.attributedText.length) options:0 usingBlock:^(NSDictionary<NSString *,id> * _Nonnull attrs, NSRange range, BOOL * _Nonnull stop) {
        HEEmotionTextAttachment *attach = attrs[@"NSAttachment"];
        if (attach) { // 是附件
            [str appendString:attach.emotion.chs];
        }else{
            // 截取range范围的普通文本
            NSString *substr = [self.attributedText attributedSubstringFromRange:range].string;
            [str appendString:substr];
        }
    }];
    return str;
}

@end
