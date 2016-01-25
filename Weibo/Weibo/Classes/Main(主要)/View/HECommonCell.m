//
//  HECommonCell.m
//  Weibo
//
//  Created by 贺俊孟 on 15/11/25.
//  Copyright © 2015年 贺俊孟. All rights reserved.
//  自定义的commonCell 

#import "HECommonCell.h"
#import "HECommonItem.h"
#import "HEBadgeView.h"
#import "HECommonArrowItem.h"
#import "HECommonLabelItem.h"
#import "HECommonSwitchItem.h"

@interface HECommonCell ()

/**
 提醒文字
 */
@property (nonatomic ,strong) HEBadgeView *badgeView;
/**
 *  箭头
 */
@property (strong, nonatomic) UIImageView *rightArrow;
/**
 *  开关
 */
@property (strong, nonatomic) UISwitch *rightSwitch;
/**
 *  标签
 */
@property (strong, nonatomic) UILabel *rightLabel;

@end

@implementation HECommonCell

//提醒文字
-(HEBadgeView*)badgeView{
    if (_badgeView == nil) {
        _badgeView = [[HEBadgeView alloc]init];
    }
    return _badgeView;
}

// 箭头
-(UIImageView *)rightArrow{
    if (_rightArrow == nil) {
        _rightArrow = [[UIImageView alloc]initWithImage:[UIImage imageWithName:@"common_icon_arrow"]];
    }
    return _rightArrow;
}
// 开关
-(UISwitch *)rightSwitch{
    if (_rightSwitch == nil) {
        _rightSwitch = [[UISwitch alloc]init];
        [_rightSwitch setOn:YES];
    }
    return _rightSwitch;
}
// 标签
-(UILabel *)rightLabel{
    if (_rightLabel == nil) {
        _rightLabel = [[UILabel alloc]init];
        self.rightLabel.textColor = [UIColor lightGrayColor];
        self.rightLabel.font = [UIFont systemFontOfSize:13];
    }
    return _rightLabel;
}


/** 初始化*/
+(instancetype) cellWithTableView:(UITableView *)tableView{
    static NSString *ID= @"HECommonCell";
    HECommonCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell =  [[self alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return cell;
}

/** 设置cell 的模型*/
-(void)setItem:(HECommonItem *)item{
    _item = item;
    self.imageView.image = [UIImage imageWithName:item.icon];
    self.textLabel.text = item.title;
    self.detailTextLabel.text = item.subTitle;
    
    if (item.badgeValue) {  //右边有提醒文字
        self.accessoryView = self.badgeView;
        self.badgeView.badgeValue = item.badgeValue;
     }else{
         if ([item isKindOfClass:[HECommonArrowItem class]]) { // 箭头
             self.accessoryView = self.rightArrow;
         }
         
         else if ([item isKindOfClass:[HECommonLabelItem class]]){ //label
             HECommonLabelItem *labelItem = (HECommonLabelItem *)item;
             self.rightLabel.text = labelItem.rightLabelText;
             // 根据文字计算尺寸
             self.rightLabel.size = [labelItem.rightLabelText sizeWithFont:self.rightLabel.font];
             self.accessoryView = self.rightLabel;
         }
         
         else if ([item isKindOfClass:[HECommonSwitchItem class]]){        //switch
             HECommonSwitchItem *switchItem = (HECommonSwitchItem *)item;
             [self.rightSwitch setOn:switchItem.isOn] ;
             self.accessoryView = self.rightSwitch;
        }
    }
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

@end
