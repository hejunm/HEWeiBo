//
//  HMStatusDetailView.m
//  Weibo
//
//  Created by 贺俊孟 on 15/11/21.
//  Copyright © 2015年 贺俊孟. All rights reserved.
//

#import "HMStatusDetailView.h"
#import "HMStatusOriginalView.h"
#import "HMStatusRetweetedView.h"
#import "HMStatusDetailFrame.h"

@interface HMStatusDetailView ()

// 原创微博View
@property (nonatomic,weak) HMStatusOriginalView *originalView;
// 转发微博view
@property (nonatomic,weak) HMStatusRetweetedView *retweetedView;


@end


@implementation HMStatusDetailView

-(instancetype)init{
    self = [super init];
    if (self) {
        
        self.userInteractionEnabled = YES;
        self.image = [UIImage resizedImage:@"timeline_card_top_background"];
        
        // 原创微博View
        HMStatusOriginalView *originalView = [[HMStatusOriginalView alloc]init];
        [self addSubview:originalView];
        self.originalView = originalView;
        
        // 转发微博view
        HMStatusRetweetedView *retweetedView = [[HMStatusRetweetedView alloc]init];
        [self addSubview:retweetedView];
        self.retweetedView = retweetedView;
    }
    return self;
}

-(void) setDetailFrame:(HMStatusDetailFrame *)detailFrame{
    _detailFrame = detailFrame;
    self.originalView.originalFrame = detailFrame.originalFrame;
    self.retweetedView.retweetedFrame = detailFrame.retweetedFrame;
    self.frame = detailFrame.frame;
}



@end
