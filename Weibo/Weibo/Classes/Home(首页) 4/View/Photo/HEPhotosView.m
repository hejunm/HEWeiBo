//
//  HEPhotosView.m
//  Weibo
//
//  Created by 贺俊孟 on 15/11/22.
//  Copyright © 2015年 贺俊孟. All rights reserved.
//

#import "HEPhotosView.h"
#import "HEImageView.h"
#import "HMPhoto.h"

#define HMStatusPhotosMaxCount 9
#define HMStatusPhotosMaxCols(photosCount) ((photosCount==4)?2:3)
#define HMStatusPhotoW  (HMScreenW - 4*HMStatusPhotoMargin)/3
#define HMStatusPhotoH HMStatusPhotoW
#define HMStatusPhotoMargin 10

@interface HEPhotosView ()


@end


@implementation HEPhotosView
-(instancetype) initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        
        //创建9个HEImageView，循环使用
        for (int i=0; i<HMStatusPhotosMaxCount; i++) {
            HEImageView *imageView = [[HEImageView alloc]init];
            imageView.tag = i;
            [self addSubview:imageView];
        }
    }
    return self;
}
/** set方法*/
-(void) setPhotoModels:(NSArray *)photoModels{
    _photoModels = photoModels;
    NSInteger numOfPhotoModels = _photoModels.count;
    for (int i=0; i<HMStatusPhotosMaxCount; i++) {
        
        HEImageView *imageView = self.subviews[i];
        
        if (i<numOfPhotoModels) {
            imageView.hidden = NO;
            imageView.photoModel = _photoModels[i];
        }else{
            imageView.hidden = YES;
        }
    }
    //[self setNeedsDisplay];  // 需要重新进行布局
}

-(void) layoutSubviews{
    [super layoutSubviews];
    
    // 获得照片总数
    NSInteger photosCount = self.photoModels.count;
    
    //最大列数
    NSInteger maxCols = HMStatusPhotosMaxCols(photosCount);
    
    for (int i = 0; i<photosCount; i++) {
        HEImageView *imageView = self.subviews[i];
        int row = i/maxCols; // 行
        int col = i%maxCols; // 列
        CGFloat width = HMStatusPhotoW;
        CGFloat height = HMStatusPhotoH;
        CGFloat x = col *(HMStatusPhotoW +HMStatusPhotoMargin);
        CGFloat y = row *(HMStatusPhotoH +HMStatusPhotoMargin);
        imageView.frame = CGRectMake(x, y, width, height);
    }
}

+ (CGSize)sizeWithPhotosCount:(NSInteger)photosCount{
   // 列数
    CGFloat maxCols = HMStatusPhotosMaxCols(photosCount);
    if (photosCount < maxCols) {
        maxCols = photosCount;
    }
    // 总行数
    int totalRows = (photosCount + maxCols - 1) / maxCols;
    
    CGFloat width =   HMStatusPhotoW*maxCols +  (maxCols -1)*HMStatusPhotoMargin;
    CGFloat height =  HMStatusPhotoH*totalRows +(totalRows-1) *HMStatusPhotoMargin;
    return CGSizeMake(width, height);
}






@end
