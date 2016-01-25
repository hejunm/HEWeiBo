//
//  UIImage+Extension.h
//  Weibo
//
//  Created by 贺俊孟 on 15/9/12.
//  Copyright (c) 2015年 贺俊孟. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Extension)

/**
    图片的分类， 完成iOS6 和iOS7的适配， 不同的系统会使用不同的图片
 */
+(UIImage*) imageWithName:(NSString*) imageName;

/**  
    图片做填充
 */
+ (UIImage *)resizedImage:(NSString *)name;
@end
