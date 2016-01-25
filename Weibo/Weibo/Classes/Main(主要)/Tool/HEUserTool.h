//
//  HEUserTool.h
//  Weibo
//
//  Created by 贺俊孟 on 15/11/20.
//  Copyright © 2015年 贺俊孟. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HMUnreadCountParam.h"
#import "HMUnreadCountResult.h"
#import "HMUserInfoParam.h"
#import "HMUserInfoResult.h"
@interface HEUserTool : NSObject

/**
 获取用户的未读数
 */
+(void)getUnreadCountWithParam:(HMUnreadCountParam*)param
                     success:(void (^)(HMUnreadCountResult * responseObject))success
                     failure:(void (^)(NSError *error))failure;

/**
 获取用户信息
 */

+(void)getUserInfoWithParam:(HMUserInfoParam*)param
                       success:(void (^)(HMUserInfoResult * responseObject))success
                       failure:(void (^)(NSError *error))failure;

@end
