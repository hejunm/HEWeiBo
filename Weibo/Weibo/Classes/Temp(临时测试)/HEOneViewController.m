//
//  HEOneViewController.m
//  Weibo
//
//  Created by 贺俊孟 on 15/9/12.
//  Copyright (c) 2015年 贺俊孟. All rights reserved.
//

#import "HEOneViewController.h"
#import "HETwoViewController.h"

@interface HEOneViewController ()
- (IBAction)jump2TwoVc:(id)sender;

@end

@implementation HEOneViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)jump2TwoVc:(id)sender {
    HETwoViewController *twoVc = [[HETwoViewController alloc]init];
    //twoVc.view.backgroundColor = HERandomColor;
    [self.navigationController pushViewController:twoVc animated:YES];
}
@end
