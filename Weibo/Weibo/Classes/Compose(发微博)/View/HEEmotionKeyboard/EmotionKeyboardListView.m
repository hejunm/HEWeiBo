//
//  EmotionKeyboardListView.m
//  Weibo
//
//  Created by 贺俊孟 on 15/11/23.
//  Copyright © 2015年 贺俊孟. All rights reserved.
//  

/**
 // 表情的最大行数
 #define HMEmotionMaxRows 3
 // 表情的最大列数
 #define HMEmotionMaxCols 7
 // 每页最多显示多少个表情
 #define HMEmotionMaxCountPerPage (HMEmotionMaxRows * HMEmotionMaxCols - 1)
 */

#import "EmotionKeyboardListView.h"
#import "EmotionKeyboardGridView.h"

@interface EmotionKeyboardListView ()<UIScrollViewDelegate>
@property (nonatomic ,weak) UIScrollView *scrollView;
@property (nonatomic ,weak) UIPageControl *pageControl;


@end

@implementation EmotionKeyboardListView

-(instancetype) initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        
        // 滚动view
        UIScrollView *scrollView = [[UIScrollView alloc]init];
        scrollView.showsHorizontalScrollIndicator = NO;
        scrollView.showsVerticalScrollIndicator = NO;
        scrollView.pagingEnabled = YES;
        [self addSubview:scrollView];
        self.scrollView = scrollView;
        self.scrollView.delegate = self;
        
        // pageControl
        UIPageControl *pageControl = [[UIPageControl alloc]init];
        UIImage * currentPageImage = [UIImage imageWithName:@"compose_keyboard_dot_selected"] ;
        [pageControl setValue:currentPageImage forKeyPath:@"_currentPageImage"];
        UIImage * pageImage = [UIImage imageWithName:@"compose_keyboard_dot_normal"];
        [pageControl setValue:pageImage forKeyPath:@"_pageImage"];
        [self addSubview:pageControl];
        
        self.pageControl = pageControl;
        self.pageControl.pageIndicatorTintColor = [UIColor blackColor];
        
    }
    return self;
}

-(void) layoutSubviews{
    [super layoutSubviews];
    
    //设置pageControl frame
    CGFloat pageControlX = 0;
    CGFloat pageControlW = self.width;
    CGFloat pageControlH = 35;
    CGFloat pageControlY = self.height - pageControlH;
    self.pageControl.frame = CGRectMake(pageControlX, pageControlY, pageControlW, pageControlH);
    
    
    //设置scrollView frame
    CGFloat scrollViewX = 0;
    CGFloat scrollViewY = 0;
    CGFloat scrollViewW = self.width;
    CGFloat scrollViewH = self.height - pageControlH;
    self.scrollView.frame = CGRectMake(scrollViewX, scrollViewY, scrollViewW, scrollViewH);
    
    //设置 scrollView内容size
    self.scrollView.contentSize = CGSizeMake(self.scrollView.width *self.pageControl.numberOfPages, self.scrollView.height);
    
    //设置 scrollView里面 gridView的frame
    NSInteger totalGridViews = self.scrollView.subviews.count;
    for (int i=0; i<totalGridViews; i++) {
        EmotionKeyboardGridView *gridView = self.scrollView.subviews[i];
        gridView.frame = self.scrollView.bounds;
        gridView.x = scrollViewW *i;
    }
    
  }

-(void) setEmotions:(NSArray *)emotions{
    _emotions = emotions;
    
    // 1,设置pageControl总的页数
    self.pageControl.numberOfPages = (emotions.count + HMEmotionMaxCountPerPage - 1) / HMEmotionMaxCountPerPage;
    
    
    // 3,将所有的表情分页赋值到对应的页里面
    NSInteger totalEmotions = self.emotions.count;
    NSInteger totalPages = self.pageControl.numberOfPages;
    NSInteger numOfSubViewInScrollView = self.scrollView.subviews.count;
    
    for (int i=0; i<totalPages; i++) {
        // 表情的范围
        NSInteger loc = i*HMEmotionMaxCountPerPage;
        NSInteger len = HMEmotionMaxCountPerPage;
        if ((loc + len) > totalEmotions) {
            len = totalEmotions - loc;
        }
        NSRange rangForOnePage = NSMakeRange(loc,len);
        //所需表情的集合
        NSIndexSet *indexSetForOnePage = [NSIndexSet indexSetWithIndexesInRange:rangForOnePage];
        //获得表情模型数组
        NSArray *emotionForPerPage = [self.emotions objectsAtIndexes:indexSetForOnePage];
      
        if (i>=numOfSubViewInScrollView) { // EmotionKeyboardGridView不够， 需要创建
            EmotionKeyboardGridView *gridView = [[EmotionKeyboardGridView alloc]init];
            gridView.emotionsForPerPage = emotionForPerPage;
            
            //将创建的gridView添加到scrollView中
            [self.scrollView addSubview:gridView];
        }else{
            EmotionKeyboardGridView *gridView = self.scrollView.subviews[i]; //循环利用
            gridView.emotionsForPerPage = emotionForPerPage;
            gridView.hidden = NO;
        }
     }
    // 当subViews 的数量大于当前需要显示的页数时，将后面的隐藏
    for (NSInteger j=totalPages; j<numOfSubViewInScrollView; j++) {
        EmotionKeyboardGridView *gridView = self.scrollView.subviews[j];
        gridView.hidden = YES;
    }
    
    // 4,重新布局
    [self setNeedsLayout];
    
    // 5,表情滑动到最左边第一页上
    self.scrollView.contentOffset  = CGPointZero;
    
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
     HELog(@"%s",__func__);
     HELog(@"%f",scrollView.contentOffset.x);
     HELog(@"%ld",(long)self.pageControl.currentPage);
    
    self.pageControl.currentPage = (int)(scrollView.contentOffset.x / scrollView.width + 0.5);
}


@end
