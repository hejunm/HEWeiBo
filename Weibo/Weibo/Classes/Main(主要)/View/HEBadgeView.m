//
//  HEBagdeView.m
//  Weibo
//
//  Created by 贺俊孟 on 15/11/25.
//  Copyright © 2015年 贺俊孟. All rights reserved.
//

#import "HEBadgeView.h"

@implementation HEBadgeView

-(instancetype) initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.titleLabel.font = [UIFont systemFontOfSize:11];
        [self setBackgroundImage:[UIImage resizedImage:@"main_badge"]  forState:UIControlStateNormal];
        self.height = self.currentBackgroundImage.size.height;
    }
    return self;
}

-(void)setBadgeValue:(NSString *)badgeValue{
    _badgeValue = [badgeValue copy];
    
    [self setTitle:badgeValue forState:UIControlStateNormal];
    
    CGSize badgeValueSize = [badgeValue sizeWithFont:self.titleLabel.font];
    CGFloat bgW = self.currentBackgroundImage.size.width;
    if (badgeValueSize.width < bgW) {
        self.width = bgW;
    } else {
        self.width = badgeValueSize.width + 10;
    }
}



@end
