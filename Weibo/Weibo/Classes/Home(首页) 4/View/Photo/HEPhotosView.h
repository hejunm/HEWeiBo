//
//  HEPhotosView.h
//  Weibo
//
//  Created by 贺俊孟 on 15/11/22.
//  Copyright © 2015年 贺俊孟. All rights reserved.
//  cell中的相册， 里面可以放置多张图片，最多九张。

#import <UIKit/UIKit.h>


@interface HEPhotosView : UIView

/** 里面存放的是 HMPhoto模型 */
@property (nonatomic,strong) NSArray *photoModels;

/** 获取自身的size */

/**
 *  根据图片个数计算相册的最终尺寸
 */
+ (CGSize)sizeWithPhotosCount:(NSInteger)photosCount;


@end
