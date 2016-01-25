//
//  HEHomeViewController.m
//  Weibo
//
//  Created by 贺俊孟 on 15/9/12.
//  Copyright (c) 2015年 贺俊孟. All rights reserved.
//

#import "HEHomeViewController.h"

#import "HEStatusTool.h"
#import "HMHomeStatusesParam.h"
#import "HMHomeStatusesResult.h"
#import "HMStatus.h"
#import "HMStatusFrame.h"

#import "HEAccountTool.h"
#import "HEAccount.h"

#import "HEUserTool.h"

#import "MBProgressHUD+MJ.h"
#import "MJRefresh.h"

#import "HMStatusCell.h"



@interface HEHomeViewController ()
@property (nonatomic ,strong)NSMutableArray *statusFrames;

@end
@implementation HEHomeViewController

- (void)viewDidLoad{
    
    // 1,  设置导航栏左右按钮
    
    [self setUpNavBar];
    
    // 2,  设置 tableViewfooter/header
    
    self.tableView.header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self loadNewStatuses];
    }];
    self.tableView.footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        [self loadMoreStatus];
    }];
    
    // 3, 设置用户信息
    
    [self setUpUserInfo];
    
    // 4,  加载数据
    [self loadNewStatuses];
    
    // 5, 设置tableView 的属性
    self.tableView.backgroundColor = [UIColor lightGrayColor];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
}
#pragma mark 初始化函数
-(NSMutableArray *)statusFrames{
    if (_statusFrames == nil) {
        _statusFrames = [NSMutableArray array];
    }
    return _statusFrames;
}

-(void) setUpNavBar{
    // 添加左右两边的导航 BarButtonItem
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImageName:@"navigationbar_friendsearch" highLightImageName:@"navigationbar_friendsearch_highlighted" target:self action:@selector(friendSeach)];
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithImageName:@"navigationbar_pop" highLightImageName:@"navigationbar_pop_highlighted" target:self action:@selector(pop)];
}

-(void) setUpUserInfo{
    HMUserInfoParam *param = [[HMUserInfoParam alloc]init];
    param.access_token = [HEAccountTool account].access_token;
    param.uid = [HEAccountTool account].uid;
    [HEUserTool getUserInfoWithParam:param success:^(HMUserInfoResult *responseObject) {
        
        // 有值才设置，否则显示首页
        if ( responseObject.name) {
            self.navigationItem.title =  responseObject.name;
            HELog(@"%@ 成功设置主页用户名",responseObject.name);
            // 将用户数据保存起来
            HEAccount *account = [HEAccountTool account];
            account.name = responseObject.name;
            [HEAccountTool save:account];
        }
    } failure:^(NSError *error) {
        HELog(@"%s--- 失败",__func__);
    }];

}




#pragma mark UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.statusFrames.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    HMStatusCell *cell = [HMStatusCell cellWithTableView:tableView];
    HMStatusFrame* statusFrame = self.statusFrames[indexPath.row];
    cell.statusFrame = statusFrame;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

// 点击某一行时跳转都下一个界面
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

}

#pragma mark  UITableViewDelegate

-(CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    HMStatusFrame* statusFrame = self.statusFrames[indexPath.row];
    return statusFrame.cellHeight;
}



#pragma mark 事件相关函数
-(void)friendSeach{
}

-(void)pop{

}

#pragma mark 加载数据

// 下拉刷新
-(void)loadNewStatuses{
    HELog(@"下拉刷新 加载最新数据");
    HMHomeStatusesParam *param = [[HMHomeStatusesParam alloc]init];
    param.access_token = [HEAccountTool account].access_token;
    HMStatusFrame *firstStatusFrame = [self.statusFrames firstObject];
    HMStatus *firstStatus = firstStatusFrame.status;
    if (firstStatus) {
        param.since_id = @([firstStatus.idstr longLongValue]);
    }
    [HEStatusTool homeStatusesWithParam:param success:^(HMHomeStatusesResult *responseObject) {
        NSArray *newStatus = responseObject.statuses;
        NSArray *newStatusFrames = [self statusFramesWithStatuses:newStatus];
        
        NSRange range = NSMakeRange(0, newStatusFrames.count);
        NSIndexSet *set = [[NSIndexSet alloc]initWithIndexesInRange:range];
        [self.statusFrames insertObjects:newStatusFrames atIndexes:set];
        [self.tableView reloadData];
        /**显示出最新的数据*/
        [self showNewStatusesCount:newStatusFrames.count];
        
         [self endRefresh];
    } failure:^(NSError *error) {
        [self endRefresh];
        HELog(@"%@",error);
    }];
}
// 上啦加载更多
-(void) loadMoreStatus{
    HELog(@"上拉 加载更多数据");
    HMHomeStatusesParam *param = [[HMHomeStatusesParam alloc]init];
    param.access_token = [HEAccountTool account].access_token;
    HMStatusFrame *lastStatusFrame = [self.statusFrames lastObject];
    HMStatus *lastStatus = lastStatusFrame.status;
    if (lastStatus) {
        param.max_id = @([lastStatus.idstr longLongValue]-1);
    }
    [HEStatusTool homeStatusesWithParam:param success:^(HMHomeStatusesResult *responseObject) {
        NSArray *newStatus = responseObject.statuses;
        NSArray *newStatusFrames = [self statusFramesWithStatuses:newStatus];
        
        [self.statusFrames addObjectsFromArray:newStatusFrames];
        [self.tableView reloadData];
        
        /**显示出最新的数据*/
        [self showNewStatusesCount:newStatusFrames.count];
        
        [self endRefresh];
    } failure:^(NSError *error) {
        [self endRefresh];
        HELog(@"%@",error);
    }];
}

/** 提示用户最新加载的微博数量*/
- (void)showNewStatusesCount:(long)count{
    UILabel *label = [[UILabel alloc]init];
    if (count) {
        label.text = [NSString stringWithFormat:@"共有%ld条新的微博数据",count];
    }else{
        label.text = @"没有最新的微博数据";
    }
    
    label.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageWithName:@"timeline_new_status_background"]];
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = [UIColor whiteColor];
    
    label.width = self.view.width;
    label.height = 35;
    label.x = 0;
    label.y = 64-label.height;
    [self.navigationController.view insertSubview:label belowSubview:self.navigationController.navigationBar];
    float duration = 0.75;
    [UIView animateWithDuration:duration animations:^{
        // 向下移动label 的高度
        label.transform = CGAffineTransformMakeTranslation(0, label.height);
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:duration delay:1.0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
            // 向上移动到运来的高度
            label.transform = CGAffineTransformIdentity;
        } completion:^(BOOL finished) {
            [label removeFromSuperview];
        }];
        
    }];
}

/** 停止刷新指示器转动*/
-(void) endRefresh{
    if (self.tableView.header.isRefreshing) {
        [self.tableView.header endRefreshing];
    }
    if (self.tableView.footer.isRefreshing) {
        [self.tableView.footer endRefreshing];
    }
}

/** 当点击tabbar， 是否刷新数据*/
-(void) refreshFromSelf:(BOOL)fromSelf{
    if (fromSelf) {
        HELog(@"%s",__func__);
        [self.tableView.header beginRefreshing];
    }

}

/** 将微博数据转换为微博frame数据   statuses: 微博模型
 */
- (NSArray *)statusFramesWithStatuses:(NSArray *)statuses{
    NSMutableArray *statusFrames = [NSMutableArray array];
    for (HMStatus *status in statuses) {
        HMStatusFrame *statusFrame = [[HMStatusFrame alloc]init];
        statusFrame.status = status;
        [statusFrames addObject:statusFrame];
    }
    return statusFrames;
}



@end
