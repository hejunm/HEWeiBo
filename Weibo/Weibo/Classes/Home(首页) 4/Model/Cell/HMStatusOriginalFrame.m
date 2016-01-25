//
//  HMStatusOriginalFrame.m
//  Weibo
//
//  Created by 贺俊孟 on 15/11/21.
//  Copyright © 2015年 贺俊孟. All rights reserved.
//

#import "HMStatusOriginalFrame.h"
#import "HMStatus.h"
#import "HMUser.h"
#import "HEPhotosView.h"

@implementation HMStatusOriginalFrame
-(void) setStatus:(HMStatus *)status{
    _status = status;
    // 1, 设置iconFrame
    CGFloat iconX = HMStatusCellInset;
    CGFloat iconY = HMStatusCellInset;
    CGFloat iconW = 35;
    CGFloat iconH = 35;
    self.iconFrame = CGRectMake(iconX, iconY, iconW, iconH);
    
    // 2, 设置nameFame
    CGFloat nameX =  CGRectGetMaxX(self.iconFrame) +HMStatusCellInset;
    CGFloat nameY = iconY;
    CGSize  nameSize = [status.user.name sizeWithFont:HMStatusOrginalNameFont];
    self.nameFrame = (CGRect){{nameX,nameY},nameSize};
    
    // 2.1 设置会员图标frame
    CGFloat vipViewX = CGRectGetMaxX(self.nameFrame) +HMStatusCellInset/2;
    CGFloat vipViewY = nameY;
    CGFloat vipViewW = nameSize.height;
    CGFloat vipViewH = vipViewW;
    self.vipViewFrame = CGRectMake(vipViewX, vipViewY, vipViewW, vipViewH);
    
    
    // 3, 设置timeFrame
    NSString *createTime = status.created_at;
    CGFloat timeX = nameX;
    CGFloat timeY = CGRectGetMaxY(self.nameFrame)+HMStatusCellInset/2;
    CGSize  timeSize = [status.created_at sizeWithFont:HMStatusOrginalTimeFont];
    self.timeFrame = (CGRect){{timeX,timeY},timeSize};
    
    // 4, 设置sourceFrame
    CGFloat sourceX = CGRectGetMaxX(self.timeFrame)+HMStatusCellInset/2;
    CGFloat sourceY = timeY;
    CGSize  sourceSize = [status.source sizeWithFont:HMStatusOrginalSourceFont];
    self.sourceFrame = (CGRect){{sourceX,sourceY},sourceSize};
    
    // 5, 设置正文
    CGFloat textX = iconX;
    CGFloat textY = CGRectGetMaxY(self.iconFrame)+HMStatusCellInset;
    CGFloat maxW = HMScreenW - 2*textX;
    CGSize maxSize = CGSizeMake(maxW, MAXFLOAT);
    CGSize textSize = [status.attributedText boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin context:nil].size;
    self.textFrame = (CGRect){{textX,textY},textSize};
    
    // 自身的高度
    CGFloat frameH = CGRectGetMaxY(self.textFrame )+HMStatusCellInset;
    
    // 6, 设置配图的frame
    if (_status.pic_urls.count) {
        CGSize photosViewSize = [HEPhotosView sizeWithPhotosCount:_status.pic_urls.count];
        CGFloat photosViewX = textX;
        CGFloat photosViewY = CGRectGetMaxY(self.textFrame)+HMStatusCellInset;
        self.photosViewFrame = (CGRect){{photosViewX,photosViewY},photosViewSize};
        frameH = CGRectGetMaxY(self.photosViewFrame)+HMStatusCellInset;
    }
    
    // 7, 设置自身的frame
    CGFloat frameX = 0;
    CGFloat frameY = 0;
    CGFloat frameW = HMScreenW;
    self.frame = CGRectMake(frameX, frameY, frameW, frameH);
    
}
@end
