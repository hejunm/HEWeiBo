//
//  HEHttpTool.m
//  Weibo
//
//  Created by 贺俊孟 on 15/11/20.
//  Copyright © 2015年 贺俊孟. All rights reserved.
//

#import "HEHttpTool.h"
#import "AFNetworking.h"
#import "HeFormDataModel.h"

@implementation HEHttpTool

+ (void)getWithUrl:(NSString *)url params:(NSDictionary *)params
    success:(void (^)(id responseObject))success
    failure:(void (^)(NSError *error))failure{
    
    // 1.获得请求管理者
    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
    [mgr GET:url parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if (success) {
            success(responseObject);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (failure) {
            failure(error);
        };
    }];

}


+ (void)postWithUrl:(NSString *)url params:(NSDictionary *)params
     success:(void (^)(id responseObject))success
     failure:(void (^)(NSError *error))failure{
    // 1.获得请求管理者
    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
    [mgr POST:url parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if (success) {
            success(params);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
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
 *  @param formDataArray 上传文件参数。
 *  @param success 请求成功后的回调（请将请求成功后想做的事情写到这个block中）
 *  @param failure 请求失败后的回调（请将请求失败后想做的事情写到这个block中）
 */

+ (void)postWithUrl:(NSString *)url params:(NSDictionary *)params
      formDataArray:(NSArray *)formDataArray
            success:(void (^)(id responseObject))success
            failure:(void (^)(NSError *error))failure{
    // 1.获得请求管理者
    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
    
    // 2, 发送数据
    [mgr POST:url parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        for (HeFormDataModel *dataModel in formDataArray) {
            [formData appendPartWithFileData:dataModel.data name:dataModel.name fileName:dataModel.filename mimeType:dataModel.mimeType];
        }
    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if (success) {
            success(params);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (failure) {
            failure(error);
        }
    }];

}
@end

