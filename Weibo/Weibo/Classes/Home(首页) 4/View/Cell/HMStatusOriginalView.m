//
//  HMStatusOriginalView.m
//  Weibo
//
//  Created by 贺俊孟 on 15/11/21.
//  Copyright © 2015年 贺俊孟. All rights reserved.
//

#import "HMStatusOriginalView.h"
#import "HMStatusOriginalFrame.h"
#import "HMStatus.h"
#import "HMUser.h"
#import "UIImageView+WebCache.h"
#import "HEPhotosView.h"

@interface HMStatusOriginalView ()
@property (nonatomic,weak)UILabel *nameLabel;
@property (nonatomic,weak)UIImageView *iconImageView;
@property (nonatomic,weak)UILabel *timeLabel;
@property (nonatomic,weak)UILabel *sourceLabel;
@property (nonatomic,weak)UILabel *textLabel;
@property (nonatomic,weak)UIImageView *vipView;
@property (nonatomic,weak)HEPhotosView *photosView;
@end

@implementation HMStatusOriginalView

-(instancetype) init{
    self = [super init];
    if (self) {
        // 1, 昵称
        UILabel *nameLabel = [[UILabel alloc]init];
        nameLabel.font = HMStatusOrginalNameFont;
        [self addSubview:nameLabel];
        self.nameLabel = nameLabel;
        
        // 2,头像
        UIImageView *iconImageView = [[UIImageView alloc]init];
        [self addSubview:iconImageView];
        self.iconImageView = iconImageView;
        
        // 3, 发布时间
        UILabel *timeLabel = [[UILabel alloc]init];
        timeLabel.font = HMStatusOrginalTimeFont;
        [self addSubview:timeLabel];
        self.timeLabel = timeLabel;
        
        // 4, 来源
        UILabel *sourceLabel = [[UILabel alloc]init];
        sourceLabel.font = HMStatusOrginalSourceFont;
        [self addSubview:sourceLabel];
        self.sourceLabel = sourceLabel;
        
        // 5, 正文
        UILabel *textLabel = [[UILabel alloc]init];
        textLabel.font = HMStatusOrginalTextFont;
        [self addSubview:textLabel];
        self.textLabel = textLabel;
        
        // 6.会员图标
        UIImageView *vipView = [[UIImageView alloc] init];
        vipView.contentMode = UIViewContentModeCenter;
        [self addSubview:vipView];
        self.vipView = vipView;
        
        // 7, 配图View
        HEPhotosView *photosView = [[HEPhotosView alloc]init];
        [self addSubview:photosView];
        self.photosView = photosView;
        
    }
    return self;
}

-(void) setOriginalFrame:(HMStatusOriginalFrame *)originalFrame{
    _originalFrame = originalFrame;
    
    // 取出微博模型
    HMStatus *status = originalFrame.status;
    
    // 取出用户模型
    HMUser *user = status.user;
    
    // 设置用户简称
    self.nameLabel.frame = _originalFrame.nameFrame;
    self.nameLabel.text = user.name;
    // 是否是会员
    if (user.isVip) {
        self.nameLabel.textColor = [UIColor orangeColor];
        self.vipView.hidden = NO;
        self.vipView.frame = _originalFrame.vipViewFrame;
        self.vipView.image = [UIImage imageWithName:[NSString stringWithFormat:@"common_icon_membership_level%d", user.mbrank]];
    }else{
        self.nameLabel.textColor = [UIColor blackColor];
        self.vipView.hidden = YES;
    }
    
    // 设置用户头像
    self.iconImageView.frame = _originalFrame.iconFrame;
    
    [self.iconImageView sd_setImageWithURL:[NSURL URLWithString:user.profile_image_url] placeholderImage:[UIImage imageWithName:@"avatar_default_small"]];
    
    // 设置发布时间
    
    NSString *createTime = status.created_at;
    CGRect timeFrame =  _originalFrame.timeFrame;
    timeFrame.size = [createTime sizeWithFont:HMStatusOrginalTimeFont];
    self.timeLabel.frame = timeFrame;
    self.timeLabel.text = status.created_at;
    
    // 设置来源
    CGRect sourceFrame = _originalFrame.sourceFrame;
    sourceFrame.origin.x = CGRectGetMaxX(timeFrame) +HMStatusCellInset;
    self.sourceLabel.frame = sourceFrame;
    self.sourceLabel.text = status.source;
    
    // 设置微博正文
    self.textLabel.frame = _originalFrame.textFrame;
    //self.textLabel.text = status.text;
    self.textLabel.attributedText = status.attributedText;
    self.textLabel.numberOfLines = 0;
    
    // 设置配图
    self.photosView.frame = _originalFrame.photosViewFrame;
    self.photosView.photoModels = status.pic_urls;
    self.frame = _originalFrame.frame;
    
}

@end
