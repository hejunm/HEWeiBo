//
//  HMStatusCell.m
//  Weibo
//
//  Created by 贺俊孟 on 15/11/21.
//  Copyright © 2015年 贺俊孟. All rights reserved.
//

#import "HMStatusCell.h"
#import "HMStatusFrame.h"
#import "HMStatusDetailView.h"
#import "HMStatusToolbar.h"
#import "HMStatusToolbarFrame.h"

@interface HMStatusCell ()
@property (nonatomic, weak) HMStatusDetailView *detailView;
@property (nonatomic,weak) HMStatusToolbar *statusToolbar;
@end

@implementation HMStatusCell

+(instancetype) cellWithTableView:(UITableView *)tableView{
    static NSString *cellId = @"HMStatusCell";
    HMStatusCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell = [[HMStatusCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
    }else{
         HELog(@"重用cell  %s",__func__);
    }
    return cell;
}

-(instancetype) initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // cell 的背景色
        self.backgroundColor = [UIColor clearColor];
        
        // 微博详细内容
        HMStatusDetailView * statusDetailView = [[HMStatusDetailView alloc]init];
        [self.contentView addSubview:statusDetailView];
        self.detailView = statusDetailView;
        
        // 微博工具栏
        HMStatusToolbar *statusToolbar = [[HMStatusToolbar alloc]init];
        [self.contentView addSubview:statusToolbar];
        self.statusToolbar = statusToolbar;
    }
    HELog(@"创建cell  %s",__func__);
    return self;
}

-(void) setStatusFrame:(HMStatusFrame *)statusFrame{
    HELog(@"设置HMStatusFrame    %s",__func__);
    _statusFrame = statusFrame;
    self.detailView.detailFrame = statusFrame.detailFrame;
    self.statusToolbar.frame = statusFrame.toolbarFrame.frame;
}



@end
