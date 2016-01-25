//
//  HMStatusRetweetedFrame.h
//  Weibo
//
//  Created by 贺俊孟 on 15/11/21.
//  Copyright © 2015年 贺俊孟. All rights reserved.
//  转发微博

#import <Foundation/Foundation.h>
@class HMStatus;

@interface HMStatusRetweetedFrame : NSObject
@property (nonatomic,assign) CGRect nameFrame;
@property (nonatomic,assign) CGRect textFrame;

// 配图frame
@property (nonatomic,assign) CGRect photosViewFrame;

/** 自身的frame*/
@property (nonatomic,assign) CGRect frame;

/** 转发的微博数据*/
@property (nonatomic,strong) HMStatus *retweetedStatus;


@end
