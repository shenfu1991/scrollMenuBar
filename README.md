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

新样式：选中时的字体稍微大一点：

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


![image](https://raw.githubusercontent.com/mengzhihoing/scrollMenuBar/master/new.png)

