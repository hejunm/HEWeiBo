//
//  HETabBar.m
//  Weibo
//
//  Created by 贺俊孟 on 15/9/14.
//  Copyright (c) 2015年 贺俊孟. All rights reserved.
//

#import "HETabBar.h"

@interface HETabBar()
@property(nonatomic,weak) UIButton *plusButton;
@end

@implementation HETabBar

-(id) initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self setPlusButton];
    }
    return self;
}

// 布局
- (void) layoutSubviews{
    HELog(@"%s",__func__);
    [super layoutSubviews];
    [self setUpPlusButtonFrame];
    [self setupAllTabBarButtonsFrame];
    
}

// 添加中间的按钮
- (void) setPlusButton{
    UIButton *plusButton = [[UIButton alloc]init];
    [plusButton setBackgroundImage:[UIImage imageWithName:@"tabbar_compose_button"] forState:UIControlStateNormal];
    [plusButton setBackgroundImage:[UIImage imageWithName:@"tabbar_compose_button_highlighted"]forState:UIControlStateHighlighted];
    [plusButton setImage:[UIImage imageWithName:@"tabbar_compose_icon_add"] forState:UIControlStateNormal];
    [plusButton setImage:[UIImage imageWithName:@"tabbar_compose_icon_add_highlighted"] forState:UIControlStateHighlighted];
    
    [plusButton addTarget:self action:@selector(plusBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    self.plusButton = plusButton;
    [self addSubview:plusButton];
     HELog(@"%s",__func__);
}

// 设置加号按钮的frame
- (void) setUpPlusButtonFrame{
    self.plusButton.size = self.plusButton.currentBackgroundImage.size;
    self.plusButton.center = CGPointMake(self.width*0.5, self.height*0.5);
}

// 设置所有控件的frame
- (void)setupAllTabBarButtonsFrame{
    int index = 0;
    for (UIView *tabBarButton in self.subviews) {
        if (![tabBarButton isKindOfClass:NSClassFromString(@"UITabBarButton")]) continue;
        
        // 设置每一个按钮的位置
        [self setupTabBarButtonFrame:tabBarButton  atIndex:index];
        index++;
    }
}

/**
 *  设置某个按钮的frame
 *
 *  @param tabBarButton 需要设置的按钮
 *  @param index        按钮所在的索引
 */
- (void)setupTabBarButtonFrame:(UIView *)tabBarButton atIndex:(int)index{
    float width = self.width/(self.items.count +1);
    float height = self.height;
    tabBarButton.width = width;
    tabBarButton.height = height;
    tabBarButton.y = 0;
    if (index>=2) {
        tabBarButton.x = width*(index+1);
    }else{
        tabBarButton.x = width*index;
    }
}


/**
    按钮点击事件
 */
-(void)plusBtnClick:(UIButton*)button{
    if ([self.tabBarDelegate respondsToSelector:@selector(tabBarDidClickedPlusButton:)]) {
        [self.tabBarDelegate tabBarDidClickedPlusButton:self];
    }
}



@end
