//
//  HEImageView.h
//  Weibo
//
//  Created by 贺俊孟 on 15/11/22.
//  Copyright © 2015年 贺俊孟. All rights reserved.
//

#import <UIKit/UIKit.h>
@class HMPhoto;

@interface HEImageView : UIImageView
/**
 单张照片model
 */
@property (nonatomic,strong) HMPhoto *photoModel;
@end
