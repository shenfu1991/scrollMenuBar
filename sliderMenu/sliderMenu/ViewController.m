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
    menuView.frame = CGRectMake(0, 0, WIDTH, 44);
    menuView.delegate=self;
    [self.view addSubview:menuView];
    NSArray *items = @[@"头条",@"时尚榜",@"焦点新闻",@"军事报",@"明星",@"搞笑",@"百思不解",@"精品汇"];
    
    [menuView addItems:items titleColor:[UIColor whiteColor] SelectedColor:[UIColor redColor]];

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
