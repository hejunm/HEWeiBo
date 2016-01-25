//
//  HMStatusOriginalFrame.h
//  Weibo
//
//  Created by 贺俊孟 on 15/11/21.
//  Copyright © 2015年 贺俊孟. All rights reserved.
//  原微博

#import <Foundation/Foundation.h>
@class HMStatus;

@interface HMStatusOriginalFrame : NSObject

@property (nonatomic,assign)CGRect nameFrame;
@property (nonatomic,assign)CGRect iconFrame;
@property (nonatomic,assign)CGRect timeFrame;
@property (nonatomic,assign)CGRect sourceFrame;
@property (nonatomic,assign)CGRect textFrame;
// 会员图标frame
@property (nonatomic,assign)CGRect vipViewFrame;

// 配图frame
@property (nonatomic,assign) CGRect photosViewFrame;

/** 自身的frame*/
@property (nonatomic,assign) CGRect frame;

@property (nonatomic,strong)HMStatus *status;

@end
