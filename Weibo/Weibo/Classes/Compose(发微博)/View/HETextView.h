//
//  HETextView.h
//  Weibo
//
//  Created by 贺俊孟 on 15/11/23.
//  Copyright © 2015年 贺俊孟. All rights reserved.
//  自定义  UITextView, 可以设置 placehoder

#import <UIKit/UIKit.h>

@interface HETextView : UITextView
/** 占位文字*/
@property (nonatomic,copy) NSString *placehoder;
/** 占位文字内容 */
@property (nonatomic,strong) UIColor *placehoderColor;

@end
