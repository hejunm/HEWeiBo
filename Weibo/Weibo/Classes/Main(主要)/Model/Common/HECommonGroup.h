//
//  HECommonGroup.h
//  Weibo
//
//  Created by 贺俊孟 on 15/11/25.
//  Copyright © 2015年 贺俊孟. All rights reserved.
//  分组

#import <Foundation/Foundation.h>

@interface HECommonGroup : NSObject
/** 分组头部信息*/
@property (nonatomic,copy) NSString *headerString;

/** 分组尾部信息*/
@property (nonatomic,copy) NSString *footerString;

/** group内存放的items  */
@property (nonatomic, strong)NSArray *items;

+(instancetype) group;

@end
