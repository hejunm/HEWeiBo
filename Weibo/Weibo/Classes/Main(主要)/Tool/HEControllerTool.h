//
//  HEControllerTool.h
//  Weibo
//
//  Created by 贺俊孟 on 15/9/17.
//  Copyright (c) 2015年 贺俊孟. All rights reserved.

//

#import <Foundation/Foundation.h>

@interface HEControllerTool : NSObject
/**
    根据是否是最新的版本 来选择控制器。 如果是新版本，将显示新特性图片， 并将数据保存到用户偏好设置
 */
+ (void)chooseRootViewController;
@end
