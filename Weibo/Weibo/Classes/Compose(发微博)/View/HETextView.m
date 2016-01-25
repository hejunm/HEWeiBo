//
//  HETextView.m
//  Weibo
//
//  Created by 贺俊孟 on 15/11/23.
//  Copyright © 2015年 贺俊孟. All rights reserved.
//

#import "HETextView.h"

@interface HETextView()

@property (nonatomic,weak) UILabel *placehoderLabel;

@end

@implementation HETextView

-(instancetype) initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        
        // 设置自身的一些初始化信息
        self.font = [UIFont systemFontOfSize:14];
        self.backgroundColor = [UIColor clearColor];
        
        // 设置占位label
        UILabel *placehoderLabel = [[UILabel alloc]init];
        placehoderLabel.text = @"分享新鲜事";
        placehoderLabel.textColor = [UIColor grayColor];
        placehoderLabel.font = self.font;
        placehoderLabel.numberOfLines = 0;
        placehoderLabel.backgroundColor = [UIColor clearColor];
        [self addSubview:placehoderLabel];
        
        self.placehoderLabel = placehoderLabel;
        
        // 监听输入文字的通知
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textChanged) name:UITextViewTextDidChangeNotification object:self];
    }
    return self;
}

// 设置占位文字信息
-(void) setPlacehoder:(NSString *)placehoder{
    _placehoder = [placehoder copy];
    self.placehoderLabel.text = _placehoder;
    [self setNeedsDisplay];
}

// 设置文本
-(void) setText:(NSString *)text{
    super.text = [text copy];
    [self textChanged];
}

// 设置富文本
-(void) setAttributedText:(NSAttributedString *)attributedText{
    super.attributedText = attributedText;
    [self textChanged];
}

// 设置文字大小
-(void) setFont:(UIFont *)font{
    super.font = font;
    self.placehoderLabel.font = font;
    [self setNeedsDisplay];
}

/** 文字改变时调用*/
-(void) textChanged{
    self.placehoderLabel.hidden = self.hasText;
}

-(void) layoutSubviews{
    [super layoutSubviews];
    
    CGFloat x = 5;
    CGFloat y = 8;
    CGFloat w = self.width - 2 *x;
    CGSize maxSize = CGSizeMake(w, CGFLOAT_MAX);
    CGSize size = [self.placehoderLabel.text sizeWithFont:self.font constrainedToSize:maxSize];
    CGFloat h = size.height;
    
    self.placehoderLabel.frame = CGRectMake(x, y, w, h);
}

-(void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}




@end
