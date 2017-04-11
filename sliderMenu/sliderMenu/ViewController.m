//
//  ViewController.m
//  sliderMenu
//
//  Created by 轩辕神赋 on 2017/4/10.
//  Copyright © 2017年 轩辕神赋. All rights reserved.
//

#import "ViewController.h"
#import "ScrollMenuView.h"
@interface ViewController ()<ScrollMenuViewDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    ScrollMenuView *menuView = [[ScrollMenuView alloc]init];
    menuView.frame = CGRectMake(0, 64, WIDTH, 44);
    menuView.delegate=self;
    [self.view addSubview:menuView];
    NSArray *items = @[@"精选",@"鞋子",@"上装",@"裤装",];
    [menuView addItems:items titleColor:[UIColor grayColor] SelectedColor:[UIColor blackColor]];
    
    
    ScrollMenuView *menuView1 = [[ScrollMenuView alloc]init];
    menuView1.frame = CGRectMake(0, 230, WIDTH, 44);
    menuView1.delegate=self;
    [self.view addSubview:menuView1];
    NSArray *items1 = @[@"精选",@"鞋子",@"上装",@"裤装",@"头条",@"配饰",@"视频",@"折扣",@"潮牌",@"促销"];
    [menuView1 addItems:items1 titleColor:[UIColor grayColor] SelectedColor:[UIColor blackColor]];


}

- (void)ScrollMenuViewClickWithIndex:(NSInteger)index
{
    NSLog(@"index=%ld",index);
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
