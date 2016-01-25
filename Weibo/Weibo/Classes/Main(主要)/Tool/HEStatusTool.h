//
//  HEStatusTool.h
//  Weibo
//
//  Created by 贺俊孟 on 15/11/20.
//  Copyright © 2015年 贺俊孟. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HEBaseTool.h"
@class HMHomeStatusesParam;
@class HMHomeStatusesResult;

@class HMSendStatusParam;
@class HMSendStatusResult;

@class HMSendImageStatusParam;
@class HMSendImageStatusResult;


@interface HEStatusTool : HEBaseTool

/** 获取首页的微博*/
+(void)homeStatusesWithParam:(HMHomeStatusesParam*)param
                success:(void (^)(HMHomeStatusesResult * responseObject))success
                failure:(void (^)(NSError *error))failure;

/** 发送没有图片的微博*/
+(void)sendStatusWithParam:(HMSendStatusParam *)param
                   success:(void (^)(HMSendStatusResult * responseObject))success
                   failure:(void (^)(NSError *error))failure;

/** 发送有图片的微博*/
+(void) sendImageStatusWithParam:(HMSendImageStatusParam *)param
                   formDataArray:(NSArray *)formDataArray
                         success:(void (^)(HMSendImageStatusResult * responseObject))success
                         failure:(void (^)(NSError *error))failure;

@end
