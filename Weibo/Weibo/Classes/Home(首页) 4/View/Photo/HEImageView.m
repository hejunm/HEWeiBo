//
//  HEImageView.m
//  Weibo
//
//  Created by 贺俊孟 on 15/11/22.
//  Copyright © 2015年 贺俊孟. All rights reserved.
//

#import "HEImageView.h"
#import "HMPhoto.h"


@interface HEImageView ()
@property (nonatomic,weak) UIImageView *gifIconView;

@end

@implementation HEImageView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        // 允许用户交互
        self.userInteractionEnabled = YES;
        self.contentMode = UIViewContentModeScaleAspectFill;
        self.clipsToBounds = YES;
        
        // 设置gif 图标, 这种情况下创建的imageView 的大小和图片大小一致。
        UIImageView *gifIconView = [[UIImageView alloc]initWithImage:[UIImage imageWithName:@"timeline_image_gif"]];
        [self addSubview:gifIconView];
        self.gifIconView = gifIconView;
    }
    return self;
}

-(void) setPhotoModel:(HMPhoto *)photoModel{
    _photoModel = photoModel;
    NSString *urlStr = [NSString stringWithFormat:@"%@",_photoModel.thumbnail_pic];
    [self sd_setImageWithURL:[NSURL URLWithString:urlStr] placeholderImage:[UIImage imageWithName:@"timeline_image_placeholder"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        HELog(@"加载图片成功！！！");
        
    }];
    
    NSString *extention = _photoModel.thumbnail_pic.pathExtension.lowercaseString;
    if ([extention isEqualToString:@"gif"]) {
        self.gifIconView.hidden = NO;
    }else{
        self.gifIconView.hidden = YES;
    }
}

-(void) layoutSubviews{
    [super layoutSubviews];
    self.gifIconView.x = self.width - self.gifIconView.width;
    self.gifIconView.y = self.height - self.gifIconView.height;
}

@end
