//
//  HECommonCell.h
//  Weibo
//
//  Created by 贺俊孟 on 15/11/25.
//  Copyright © 2015年 贺俊孟. All rights reserved.
//

#import <UIKit/UIKit.h>
@class HECommonItem;

@interface HECommonCell : UITableViewCell

/** 设置cell 的模型*/
@property (nonatomic,strong) HECommonItem *item;

/** 初始化*/
+(instancetype) cellWithTableView:(UITableView *)tableView;

@end
