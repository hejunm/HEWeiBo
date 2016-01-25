//
//  HEStatusTool.m
//  Weibo
//
//  Created by 贺俊孟 on 15/11/20.
//  Copyright © 2015年 贺俊孟. All rights reserved.
//

#import "HEStatusTool.h"
#import "HMHomeStatusesParam.h"
#import "HMHomeStatusesResult.h"
#import "HEBaseTool.h"

#import "HMSendStatusParam.h"
#import "HMSendStatusResult.h"

#import "HMSendImageStatusParam.h"
#import "HMSendImageStatusResult.h"

@implementation HEStatusTool

+(void)homeStatusesWithParam:(HMHomeStatusesParam*)param
                success:(void (^)(HMHomeStatusesResult * responseObject))success
                failure:(void (^)(NSError *error))failure{
    [self getWithUrl:@"https://api.weibo.com/2/statuses/home_timeline.json" params:param resultClass:[HMHomeStatusesResult class] success:success failure:failure];
}

/** 发送没有图片的微博*/
+(void)sendStatusWithParam:(HMSendStatusParam *)param
                   success:(void (^)(HMSendStatusResult * responseObject))success
                   failure:(void (^)(NSError *error))failure{
    [self postWithUrl:@"https://api.weibo.com/2/statuses/update.json" params:param resultClass:[HMSendStatusResult class] success:success failure:failure];
}

/** 发送有图片的微博*/
+(void) sendImageStatusWithParam:(HMSendImageStatusParam *)param
                   formDataArray:(NSArray *)formDataArray
                         success:(void (^)(HMSendImageStatusResult * responseObject))success
                         failure:(void (^)(NSError *error))failure{
    [self postWithUrl:@"https://upload.api.weibo.com/2/statuses/upload.json" params:param resultClass:[HMSendImageStatusResult class] formDataArray:formDataArray success:success failure:failure];

}
@end
