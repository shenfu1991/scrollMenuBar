# scrollMenuBar
A top scroll menu bar

类似网易顶部分类滑条。滚动到中间过一点右边时，自动调整位置。
  用法：
  
      ScrollMenuView *menuView = [[ScrollMenuView alloc]init];
      menuView.frame = CGRectMake(0, 0, WIDTH, 44);
      menuView.delegate=self;
      [self.view addSubview:menuView];
      NSArray *items = @[@"头条",@"时尚榜",@"头条",@"时尚榜",@"头条",@"时尚榜"];
      [menuView addItems:items titleColor:[UIColor whiteColor] SelectedColor:[UIColor redColor]];


![image](https://raw.githubusercontent.com/mengzhihoing/scrollMenuBar/master/ss.png)

对于项目比较少的，居中显示：   

![image](https://raw.githubusercontent.com/mengzhihoing/scrollMenuBar/master/short.png)


