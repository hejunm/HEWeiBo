//
//  HMStatusFrame.h
//  黑马微博
//
//  Created by apple on 14-7-14.
//  Copyright (c) 2014年 heima. All rights reserved.
//  一个frame包括一个cell内部所有子控件的fame数据和显示数据

#import <Foundation/Foundation.h>
@class HMStatus, HMStatusDetailFrame;

@interface HMStatusFrame : NSObject
/** 子控件的frame数据 */
@property (nonatomic, assign) CGRect toolbarFrame;
@property (nonatomic, strong) HMStatusDetailFrame *detailFrame;

/** cell的高度 */
@property (nonatomic, assign) CGFloat cellHeight;

/** 微博数据 */
@property (nonatomic, strong) HMStatus *status;
@end
