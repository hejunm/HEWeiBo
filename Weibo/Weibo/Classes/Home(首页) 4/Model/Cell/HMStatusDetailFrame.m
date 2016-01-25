//
//  HMStatusDetailFrame.m
//  Weibo
//
//  Created by 贺俊孟 on 15/11/21.
//  Copyright © 2015年 贺俊孟. All rights reserved.
//

#import "HMStatusDetailFrame.h"
#import "HMStatusOriginalFrame.h"
#import "HMStatusRetweetedFrame.h"
#import "HMStatus.h"

@implementation HMStatusDetailFrame

/** 原微博Frame*/
//@property (nonatomic,strong)HMStatusOriginalFrame *originalFrame;
/** 转发微博 Frame*/
//@property (nonatomic,strong)HMStatusRetweetedFrame *retweetedFrame;
/** 自身的frame */
//@property (nonatomic,assign) CGRect frame;

-(void) setStatus:(HMStatus *)status{
    _status = status;
    // 1, 设置原微博的frame
    self.originalFrame = [[HMStatusOriginalFrame alloc]init];
    self.originalFrame.status = _status;
    CGFloat h = CGRectGetMaxY(self.originalFrame.frame);
    
    // 2, 设置 转发微博 Frame
    if (_status.retweeted_status) {
        self.retweetedFrame = [[HMStatusRetweetedFrame alloc]init];
        self.retweetedFrame.retweetedStatus = _status.retweeted_status;
        CGRect retweetedFrame =  self.retweetedFrame.frame;
        retweetedFrame.origin.y = CGRectGetMaxY(self.originalFrame.frame);
        self.retweetedFrame.frame = retweetedFrame;
        h = CGRectGetMaxY(retweetedFrame);
    }
    
    // 3, 设置 自身的frame
    CGFloat x= 0;
    CGFloat y= 0;
    CGFloat w = HMScreenW;
    self.frame = CGRectMake(x, y, w, h);
}
@end
