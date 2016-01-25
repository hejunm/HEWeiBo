//
//  HEEmotionTextAttachment.h
//  Weibo
//
//  Created by 贺俊孟 on 15/11/22.
//  Copyright © 2015年 贺俊孟. All rights reserved.
//  附件， 在图文混排时 可以用来存储图片

#import <UIKit/UIKit.h>
@class HEEmotion;
@interface HEEmotionTextAttachment : NSTextAttachment
@property (nonatomic,strong) HEEmotion *emotion;

@end
