//
//  HMStatusRetweetedFrame.m
//  Weibo
//
//  Created by 贺俊孟 on 15/11/21.
//  Copyright © 2015年 贺俊孟. All rights reserved.
//

#import "HMStatusRetweetedFrame.h"
#import "HMStatus.h"
#import "HMUser.h"
#import "HEPhotosView.h"

@implementation HMStatusRetweetedFrame

-(void) setRetweetedStatus:(HMStatus *)retweetedStatus{
    _retweetedStatus = retweetedStatus;

    // 1, 设置昵称frame
    CGFloat nameX = HMStatusCellInset;
    CGFloat nameY = HMStatusCellInset;
    CGSize  nameSize = [_retweetedStatus.user.name sizeWithFont:HMStatusRetweetedNameFont];
    self.nameFrame = (CGRect){{nameX,nameY},nameSize};
    
    // 2, 设置转发微博内容 frame
    CGFloat textX = nameX;
    CGFloat textY = CGRectGetMaxY(self.nameFrame)+HMStatusCellInset;
    CGFloat maxW = HMScreenW - 2*textX;
    CGSize maxSize = CGSizeMake(maxW, MAXFLOAT);
    
    CGSize textSize = [_retweetedStatus.attributedText boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin context:nil].size;
    
    self.textFrame = (CGRect){{textX,textY},textSize};
   
    CGFloat h = CGRectGetMaxY(self.textFrame) + HMStatusCellInset;
    
    // 3, 设置配图的frame
    if (_retweetedStatus.pic_urls.count) {
        CGSize photosViewSize = [HEPhotosView sizeWithPhotosCount:_retweetedStatus.pic_urls.count];
        CGFloat photosViewX = textX;
        CGFloat photosViewY = CGRectGetMaxY(self.textFrame)+HMStatusCellInset;
        self.photosViewFrame = (CGRect){{photosViewX,photosViewY},photosViewSize};
        h = CGRectGetMaxY(self.photosViewFrame)+HMStatusCellInset;
    }
    
    //4, 设置自己的frame
    CGFloat x = 0;
    CGFloat y = 0;
    CGFloat w = HMScreenW;
    self.frame = CGRectMake(x, y, w, h);
}


@end
