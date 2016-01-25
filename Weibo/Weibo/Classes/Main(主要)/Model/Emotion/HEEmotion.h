//
//  HEEmotion.h
//  Weibo
//
//  Created by 贺俊孟 on 15/11/22.
//  Copyright © 2015年 贺俊孟. All rights reserved.
//  表情模型

#import <Foundation/Foundation.h>

@interface HEEmotion : NSObject

/**表情描述 -- 简体*/
@property (nonatomic,copy)NSString *chs;

/**表情描述 -- 繁体*/
@property (nonatomic,copy)NSString *cht;

/**动态表情图*/
@property (nonatomic,copy)NSString *gif;

/**表情图片*/
@property (nonatomic,copy)NSString *png;

/**emoji编码*/
@property (nonatomic,copy) NSString *code;

/**emoji*/
@property (nonatomic,copy)NSString *emoji;


/** 表情类型*/
@property (nonatomic,assign, getter=isEmoji) BOOL type;

@end
