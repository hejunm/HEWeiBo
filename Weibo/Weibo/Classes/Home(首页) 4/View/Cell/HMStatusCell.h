//
//  HMStatusCell.h
//  Weibo
//
//  Created by 贺俊孟 on 15/11/21.
//  Copyright © 2015年 贺俊孟. All rights reserved.
//

#import <UIKit/UIKit.h>
@class HMStatusFrame;

@interface HMStatusCell : UITableViewCell

+(instancetype) cellWithTableView:(UITableView *)tableView;
@property (nonatomic,strong)HMStatusFrame *statusFrame;
@end
