//
//  HMStatusFrame.m
//  黑马微博
//
//  Created by apple on 14-7-14.
//  Copyright (c) 2014年 heima. All rights reserved.
//

#import "HMStatusFrame.h"
#import "HMStatus.h"
#import "HMStatusDetailFrame.h"
#import "HMStatusToolbarFrame.h"

@implementation HMStatusFrame


- (void)setStatus:(HMStatus *)status{
    
    _status = status;
    // 1, 计算StatusDetailFrame
    self.detailFrame = [[HMStatusDetailFrame alloc]init];
    self.detailFrame.status = status;
    
    
    // 2, 计算StatusToolbarFrame
    self.toolbarFrame = [[HMStatusToolbarFrame alloc]init];
    CGRect toolbarFrame = self.toolbarFrame.frame;
    toolbarFrame.origin.y = CGRectGetMaxY(self.detailFrame.frame);
    self.toolbarFrame.frame = toolbarFrame;
    
    // 3, 计算出 cell 自身高度
    self.cellHeight = CGRectGetMaxY(self.toolbarFrame.frame) +HMStatusCellMargin;
    
    HELog(@"创建 HMStatusFrame %@",self);
    
}
@end
