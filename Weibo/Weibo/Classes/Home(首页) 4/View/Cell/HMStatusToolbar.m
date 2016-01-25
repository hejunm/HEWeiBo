//
//  HMStatusToolbar.m
//  Weibo
//
//  Created by 贺俊孟 on 15/11/21.
//  Copyright © 2015年 贺俊孟. All rights reserved.
//

#import "HMStatusToolbar.h"

typedef enum {
    /**转发 */
    HMStatusToolbarButtonType_retweet,
    /**评论 */
    HMStatusToolbarButtonType_comment,
    /**赞 */
    HMStatusToolbarButtonType_unlike,
}HMStatusToolbarButtonType;

/**
 self.repostsBtn = [self setupBtnWithIcon:@"timeline_icon_retweet" title:@"转发"];
 self.commentsBtn = [self setupBtnWithIcon:@"timeline_icon_comment" title:@"评论"];
 self.attitudesBtn =[self setupBtnWithIcon:@"timeline_icon_unlike" title:@"赞"];
 */
@interface HMStatusToolbar ()
// 转发
@property (nonatomic,weak) UIButton *repostsBtn;
// 评论
@property (nonatomic,weak) UIButton *commentsBtn;
// 赞
@property (nonatomic,weak) UIButton *attitudesBtn;

/** 存放加的button */
@property (nonatomic, strong)NSMutableArray *buttons;
@end

@implementation HMStatusToolbar

-(NSMutableArray *)buttons{
    if (_buttons == nil) {
        _buttons =  [NSMutableArray array];
    }
    return _buttons;
}

-(instancetype)initWithFrame:(CGRect)frame{
    if (self =  [super initWithFrame:frame]) {
        
        // 设置背景图
        self.backgroundColor = [UIColor whiteColor];
        self.repostsBtn = [self createButtonWithIcon:@"timeline_icon_retweet" title:@"转发" type:HMStatusToolbarButtonType_retweet];
        self.commentsBtn = [self createButtonWithIcon:@"timeline_icon_comment" title:@"评论" type:HMStatusToolbarButtonType_comment];
        self.attitudesBtn = [self createButtonWithIcon:@"timeline_icon_unlike" title:@"赞" type:
            HMStatusToolbarButtonType_unlike];
    }
    return self;
}

-(UIButton *)createButtonWithIcon:(NSString *)iconName title:(NSString *)title type:(HMStatusToolbarButtonType) type{
    
    UIButton *button = [[UIButton alloc]init];
    
    [button setImage:[UIImage imageWithName:iconName] forState:UIControlStateNormal];
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
     button.titleLabel.font = [UIFont systemFontOfSize:13];
    // 设置间距
    button.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
    
    // 高亮时显示背景显示灰色
    [button setBackgroundImage:[UIImage resizedImage:@"timeline_card_top_background_highlighted"] forState:UIControlStateHighlighted];
    
    
    // 设置点击事件
    button.tag = type;
    [button addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    // 添加到View中
    [self addSubview:button];
    [self.buttons addObject:button];
    return button;
}

-(void)layoutSubviews{
    CGFloat w = HMScreenW / self.buttons.count;
    CGFloat h = self.height;
    CGFloat y = 0;
    int i=0;
    for (UIButton *button in self.buttons) {
        CGFloat x = w *i;
        button.frame = CGRectMake(x, y, w, h);
        
        i++;
    }
}

/** 点击按钮*/
-(void) btnClick:(UIButton *)sender{
    HELog(@"按钮点击了");
}


@end
