//
//  HMSendImageStatusParam.h
//  Weibo
//
//  Created by 贺俊孟 on 15/11/25.
//  Copyright © 2015年 贺俊孟. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HMBaseParam.h"

@interface HMSendImageStatusParam : HMBaseParam

/** 微博正文*/
@property (nonatomic ,copy) NSString *status;
@end
