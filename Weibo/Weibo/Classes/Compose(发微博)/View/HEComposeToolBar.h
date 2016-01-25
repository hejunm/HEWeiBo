//
//  HEComposeToolBar.h
//  Weibo
//
//  Created by 贺俊孟 on 15/11/23.
//  Copyright © 2015年 贺俊孟. All rights reserved.
//  发微博上面的工具栏

#import <UIKit/UIKit.h>
typedef enum {
    HEComposeToolbarButtonTypeCamera, // 照相机
    HEComposeToolbarButtonTypePicture, // 相册
    HEComposeToolbarButtonTypeMention, // 提到@
    HEComposeToolbarButtonTypeTrend, // 话题
    HEComposeToolbarButtonTypeEmotion // 表情
} HEComposeToolbarButtonType;

@class HEComposeToolBar;
@protocol HEComposeToolbarDelegate <NSObject>
@optional
- (void)composeTool:(HEComposeToolBar *)toolbar didClickedButton:(HEComposeToolbarButtonType)buttonType;
@end


@interface HEComposeToolBar : UIView
    /**HEComposeToolbarDelegate */
    @property (nonatomic, weak) id<HEComposeToolbarDelegate> delegate;
    /**是否要显示表情按钮*/
    @property (nonatomic, assign, getter = isShowEmotionButton) BOOL showEmotionButton;
@end
