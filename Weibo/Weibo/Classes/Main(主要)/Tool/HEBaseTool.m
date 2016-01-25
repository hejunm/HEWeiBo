//
//  HEBaseTool.m
//  Weibo
//
//  Created by 贺俊孟 on 15/11/20.
//  Copyright © 2015年 贺俊孟. All rights reserved.
//

#import "HEBaseTool.h"
#import "HEHttpTool.h"
#import "MJExtension.h"



@implementation HEBaseTool
/**
 
 */
+ (void)getWithUrl:(NSString *)url params:(id)params resultClass:(Class)resultClass
           success:(void (^)(id responseObject))success
           failure:(void (^)(NSError *error))failure{
    NSDictionary *paramsDict = [params keyValues];
    [HEHttpTool getWithUrl:url params:paramsDict success:^(id responseObject) {
        if (success) {
            id result = [resultClass objectWithKeyValues:responseObject];
            success(result);
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];

}

+ (void)postWithUrl:(NSString *)url params:(id)params resultClass:(Class)resultClass
            success:(void (^)(id responseObject))success
            failure:(void (^)(NSError *error))failure{
    NSDictionary *paramsDict = [params keyValues];
    [HEHttpTool postWithUrl:url params:paramsDict success:^(id responseObject) {
        if (success) {
            id result = [resultClass objectWithKeyValues:responseObject];
            success(result);
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

/**
 *  发送一个post请求, 上传文件
 *
 *  @param url     请求路径
 *  @param params  请求参数
 *  @param formDataArray 上传文件参数。 数组内是HEFormDataModel
 *  @param success 请求成功后的回调（请将请求成功后想做的事情写到这个block中）
 *  @param failure 请求失败后的回调（请将请求失败后想做的事情写到这个block中）
 */
+ (void)postWithUrl:(NSString *)url params:(id)params
        resultClass:(Class)resultClass
      formDataArray:(NSArray *)formDataArray
            success:(void (^)(id responseObject))success
            failure:(void (^)(NSError *error))failure{
    NSDictionary *paramsDict = [params keyValues];
    [HEHttpTool postWithUrl:url params:paramsDict formDataArray:formDataArray success:^(id responseObject) {
        if (success) {
            id result = [resultClass objectWithKeyValues:responseObject];
            success(result);
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

@end
