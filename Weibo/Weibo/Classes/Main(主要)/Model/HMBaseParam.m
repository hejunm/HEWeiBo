//
//  HMBaseParam.m
//  黑马微博
//
//  Created by apple on 14-7-11.
//  Copyright (c) 2014年 heima. All rights reserved.
//

#import "HMBaseParam.h"
#import "HEAccount.h"
#import "HEAccountTool.h"

@implementation HMBaseParam
- (id)init
{
    if (self = [super init]) {
        self.access_token = [HEAccountTool account].access_token;
    }
    return self;
}

+ (instancetype)param
{
    return [[self alloc] init];
}
@end
