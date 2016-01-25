//
//  HeFormDataModel.h
//  Weibo
//
//  Created by 贺俊孟 on 15/11/25.
//  Copyright © 2015年 贺俊孟. All rights reserved.
//  AFN 文件上传模型

#import <Foundation/Foundation.h>

@interface HeFormDataModel : NSObject
/**
 *  文件数据
 */
@property (nonatomic, strong) NSData *data;

/**
 *  参数名
 */
@property (nonatomic, copy) NSString *name;

/**
 *  文件名
 */
@property (nonatomic, copy) NSString *filename;

/**
 *  文件类型
 */
@property (nonatomic, copy) NSString *mimeType;
@end
