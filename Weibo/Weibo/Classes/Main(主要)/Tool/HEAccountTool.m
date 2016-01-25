//
//  HMAccountTool.m
//  黑马微博
//
//  Created by apple on 14-7-8.
//  Copyright (c) 2014年 heima. All rights reserved.
//

#define HEAccountFilepath [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"account.data"]

#import "HEAccountTool.h"
#import "HEAccount.h"

@implementation HEAccountTool

+ (void)save:(HEAccount *)account
{
    // 归档
    [NSKeyedArchiver archiveRootObject:account toFile:HEAccountFilepath];
}

+ (HEAccount *)account
{
    // 读取帐号
    HEAccount *account = [NSKeyedUnarchiver unarchiveObjectWithFile:HEAccountFilepath];
    
    // 判断帐号是否已经过期
    NSDate *now = [NSDate date];

    if ([now compare:account.expires_time] != NSOrderedAscending) { // 过期
        account = nil;
    }
    return account;
}

/**
 NSOrderedAscending = -1L,  升序，越往右边越大
 NSOrderedSame, 相等，一样
 NSOrderedDescending 降序，越往右边越小
 */
@end
