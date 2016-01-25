//
//  HMStatusRetweetedView.m
//  Weibo
//
//  Created by 贺俊孟 on 15/11/21.
//  Copyright © 2015年 贺俊孟. All rights reserved.
//

#import "HMStatusRetweetedView.h"
#import "HMStatusRetweetedFrame.h"
#import "HMStatus.h"
#import "HMUser.h"
#import "HEPhotosView.h"


@interface HMStatusRetweetedView ()
@property (nonatomic,weak) UILabel *nameLabel;
@property (nonatomic,weak) UILabel *textLabel;
/**配图*/
@property (nonatomic,weak)HEPhotosView *photosView;
@end

@implementation HMStatusRetweetedView

-(instancetype)init{
    self = [super init];
    if (self) {
        self.userInteractionEnabled = YES;
        self.image = [UIImage resizedImage:@"timeline_retweet_background"];
        
        // 转发者的昵称
        UILabel *nameLabel = [[UILabel alloc]init];
        nameLabel.font = HMStatusRetweetedNameFont;
        [self addSubview:nameLabel];
        self.nameLabel = nameLabel;
        // 转发的文字
        UILabel *textLabel = [[UILabel alloc]init];
        textLabel.font = HMStatusRetweetedTextFont;
        [self addSubview:textLabel];
        self.textLabel = textLabel;
        
        // 配图
        // 7, 配图View
        HEPhotosView *photosView = [[HEPhotosView alloc]init];
        [self addSubview:photosView];
        self.photosView = photosView;
    }
    return self;
}


-(void) setRetweetedFrame:(HMStatusRetweetedFrame *)retweetedFrame{
    _retweetedFrame = retweetedFrame;
    HMStatus *retweetedStatus = _retweetedFrame.retweetedStatus;
    HMUser *user = retweetedStatus.user;
    
    // 昵称
    self.nameLabel.frame = _retweetedFrame.nameFrame;
    self.nameLabel.text = user.name;
    self.nameLabel.font = HMStatusRetweetedNameFont;
    
    // 转发微博内容
    self.textLabel.frame = _retweetedFrame.textFrame;
    self.textLabel.attributedText = retweetedStatus.attributedText;
    self.textLabel.font = HMStatusRetweetedTextFont;
    self.textLabel.numberOfLines = 0;
    
    // 设置配图
    self.photosView.frame = _retweetedFrame.photosViewFrame;
    self.photosView.photoModels = retweetedStatus.pic_urls;
    self.frame = _retweetedFrame.frame;
}

@end
