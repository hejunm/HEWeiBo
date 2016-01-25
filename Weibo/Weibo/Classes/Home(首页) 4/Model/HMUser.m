//
//  HMUser.m
//  黑马微博
//
//  Created by apple on 14-7-8.
//  Copyright (c) 2014年 heima. All rights reserved.
//

#import "HMUser.h"

@implementation HMUser
- (BOOL)isVip
{
    return self.mbtype > 2;
}
@end
