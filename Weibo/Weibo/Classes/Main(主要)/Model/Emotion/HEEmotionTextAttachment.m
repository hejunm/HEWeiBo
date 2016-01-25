//
//  HEEmotionTextAttachment.m
//  Weibo
//
//  Created by 贺俊孟 on 15/11/22.
//  Copyright © 2015年 贺俊孟. All rights reserved.
//

#import "HEEmotionTextAttachment.h"
#import "HEEmotion.h"

@implementation HEEmotionTextAttachment
-(void) setEmotion:(HEEmotion *)emotion{
    _emotion = emotion;
    
    self.image = [UIImage imageWithName:[NSString stringWithFormat:@"%@",emotion.png]];
    HELog(@"设置表情图   %@",self.image);
}
@end
