//
//  UIImage+Extension.m
//  Weibo
//
//  Created by 贺俊孟 on 15/9/12.
//  Copyright (c) 2015年 贺俊孟. All rights reserved.
//

#import "UIImage+Extension.h"

@implementation UIImage (Extension)
+(UIImage*) imageWithName:(NSString *)imageName{
    UIImage *image = nil;
    NSString *name = imageName;
    if (iOS7) {
        name = [NSString stringWithFormat:@"%@_os7",imageName];
        image = [UIImage imageNamed:name];
    }
    if (!image) {
        image = [UIImage imageNamed:imageName];
    }
    return image;
}
+ (UIImage *)resizedImage:(NSString *)name
{
    UIImage *image = [UIImage imageWithName:name];
    return [image stretchableImageWithLeftCapWidth:image.size.width * 0.5 topCapHeight:image.size.height * 0.5];
}
@end
