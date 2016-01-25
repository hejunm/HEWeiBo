//
//  HMStatusToolbarFrame.m
//  Weibo
//
//  Created by 贺俊孟 on 15/11/21.
//  Copyright © 2015年 贺俊孟. All rights reserved.
//

#import "HMStatusToolbarFrame.h"

@implementation HMStatusToolbarFrame
-(instancetype) init{
    self = [super init];
    if (self) {
        float x = 0;
        float y = 0;
        float w = HMScreenW;
        float h = 35;
        self.frame = CGRectMake(x, y, w, h);
    }
    return self;
}
@end
