//
//  HEUserTool.m
//  Weibo
//
//  Created by 贺俊孟 on 15/11/20.
//  Copyright © 2015年 贺俊孟. All rights reserved.
//

#import "HEUserTool.h"
#import "HEBaseTool.h"

@implementation HEUserTool


/**
 获取用户的未读数
 */
+(void)getUnreadCountWithParam:(HMUnreadCountParam*)param
                       success:(void (^)(HMUnreadCountResult * responseObject))success
                       failure:(void (^)(NSError *error))failure{
    [HEBaseTool getWithUrl:@"https://rm.api.weibo.com/2/remind/unread_count.json" params:param resultClass:[HMUnreadCountResult class] success:success failure:failure];
}

/**
 获取用户信息
 */

+(void)getUserInfoWithParam:(HMUserInfoParam*)param
                    success:(void (^)(HMUserInfoResult * responseObject))success
                    failure:(void (^)(NSError *error))failure{
    [HEBaseTool getWithUrl:@"https://api.weibo.com/2/users/show.json" params:param resultClass:[HMUserInfoResult class] success:success failure:failure];
}
@end
