//
//  HEEmotion.m
//  Weibo
//
//  Created by 贺俊孟 on 15/11/22.
//  Copyright © 2015年 贺俊孟. All rights reserved.
//

#import "HEEmotion.h"

@implementation HEEmotion

-(void) setCode:(NSString *)code{
    _code = [code copy];
    if (_code == nil)  return;
    self.emoji = [NSString emojiWithStringCode:_code];
}

@end
