//
//  HMStatusDetailFrame.h
//  Weibo
//
//  Created by 贺俊孟 on 15/11/21.
//  Copyright © 2015年 贺俊孟. All rights reserved.
//

#import <Foundation/Foundation.h>
@class HMStatusOriginalFrame;
@class HMStatusRetweetedFrame;
@class HMStatus;


@interface HMStatusDetailFrame : NSObject
/** 原微博Frame*/
@property (nonatomic,strong)HMStatusOriginalFrame *originalFrame;
/** 转发微博 Frame*/
@property (nonatomic,strong)HMStatusRetweetedFrame *retweetedFrame;
/** 自身的frame */
@property (nonatomic,assign) CGRect frame;
/** 微博数据*/
@property (nonatomic,strong) HMStatus *status;

@end
