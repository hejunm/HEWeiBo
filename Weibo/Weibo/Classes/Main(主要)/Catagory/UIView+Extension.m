//
//  UIView+Extension.m
//  Weibo
//
//  Created by 贺俊孟 on 15/9/12.
//  Copyright (c) 2015年 贺俊孟. All rights reserved.
//

#import "UIView+Extension.h"

@implementation UIView (Extension)
- (float)x{
    return self.frame.origin.x;
}
- (void)setX:(float)x{
    CGRect frame = self.frame;
    frame.origin.x = x;
    self.frame = frame;
}
- (float)y{
    return self.frame.origin.y;
}
- (void)setY:(float)y{
    CGRect frame = self.frame;
    frame.origin.y = y;
    self.frame = frame;
}
- (float)width{
    return self.size.width;
}
- (void)setWidth:(float)width{
    CGRect frame = self.frame;
    frame.size.width = width;
    self.frame = frame;
}

- (float)height{
    return self.frame.size.height;
}
- (void)setHeight:(float)height{
    CGRect frame = self.frame;
    frame.size.height = height;
    self.frame = frame;
}
- (CGSize)size{
    return self.frame.size;
}
- (void)setSize:(CGSize)size{
    CGRect frame = self.frame;
    frame.size = size;
    self.frame = frame;
}

- (float)centerX{
    return self.center.x;
}
- (void)setCenterX:(float)centerX{
    CGPoint center = self.center;
    center.x = centerX;
    self.center = center;

}

- (float)centerY{
    return self.center.y;
}
- (void)setCenterY:(float)centerY{
    CGPoint center = self.center;
    center.y = centerY;
    self.center = center;
}

@end
