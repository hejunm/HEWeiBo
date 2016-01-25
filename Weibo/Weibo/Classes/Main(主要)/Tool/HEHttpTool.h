//
//  HEHttpTool.h
//  Weibo
//
//  Created by 贺俊孟 on 15/11/20.
//  Copyright © 2015年 贺俊孟. All rights reserved.
//  封装AFN, 解除项目对AFN 的依赖。

#import <Foundation/Foundation.h>


@interface HEHttpTool : NSObject
/**
 *  发送一个GET请求
 *
 *  @param url     请求路径
 *  @param params  请求参数
 *  @param success 请求成功后的回调（请将请求成功后想做的事情写到这个block中）
 *  @param failure 请求失败后的回调（请将请求失败后想做的事情写到这个block中）
 */

+ (void)getWithUrl:(NSString *)url params:(NSDictionary *)params
                        success:(void (^)(id responseObject))success
                        failure:(void (^)(NSError *error))failure;

/**
 *  发送一个POST请求
 *
 *  @param url     请求路径
 *  @param params  请求参数
 *  @param success 请求成功后的回调（请将请求成功后想做的事情写到这个block中）
 *  @param failure 请求失败后的回调（请将请求失败后想做的事情写到这个block中）
 */

+ (void)postWithUrl:(NSString *)url params:(NSDictionary *)params
     success:(void (^)(id responseObject))success
     failure:(void (^)(NSError *error))failure;

/**
 *  发送一个post请求, 上传文件
 *
 *  @param url     请求路径
 *  @param params  请求参数
 *  @param formDataArray 上传文件参数。 数组内是HEFormDataModel
 *  @param success 请求成功后的回调（请将请求成功后想做的事情写到这个block中）
 *  @param failure 请求失败后的回调（请将请求失败后想做的事情写到这个block中）
 */
+ (void)postWithUrl:(NSString *)url params:(NSDictionary *)params
      formDataArray:(NSArray *)formDataArray
            success:(void (^)(id responseObject))success
            failure:(void (^)(NSError *error))failure;


@end

