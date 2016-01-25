//
//  HMAccountTool.h
//  黑马微博
//
//  Created by apple on 14-7-8.
//  Copyright (c) 2014年 heima. All rights reserved.
//

#import <Foundation/Foundation.h>
@class HEAccount;

@interface HEAccountTool : NSObject

/**
 *  存储帐号
 */
+ (void)save:(HEAccount *)account;

/**
 *  读取帐号
 */
+ (HEAccount *)account;

@end
