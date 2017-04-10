//
//  ScrollMenuView.m
//  sliderMenu
//
//  Created by 轩辕神赋 on 2017/4/10.
//  Copyright © 2017年 轩辕神赋. All rights reserved.
//

#import "ScrollMenuView.h"

@interface ScrollMenuView ()

@property(nonatomic, strong) NSMutableArray *itemArray;
@property(nonatomic, weak) UIButton *selectedButton;
@property(nonatomic, strong) UIView *sliderBar;
@property(nonatomic, strong) UIScrollView *scrollView;

@end

@implementation ScrollMenuView

- (instancetype)init {
  if (self = [super init]) {
    self.backgroundColor = [UIColor lightGrayColor];
  }

  return self;
}

- (UIScrollView *)scrollView
{
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc]init];
        [self addSubview:_scrollView];
        _scrollView.frame=self.frame;
        _scrollView.showsHorizontalScrollIndicator=NO;
    }
    
   return  _scrollView;
}

- (UIView *)sliderBar {
  if (!_sliderBar) {
    _sliderBar = [UIView new];
    [self.scrollView addSubview:_sliderBar];
    _sliderBar.backgroundColor = [UIColor redColor];
     
  }

  return _sliderBar;
}

- (NSMutableArray *)itemArray {
  if (!_itemArray) {
    _itemArray = [[NSMutableArray alloc] init];
  }

  return _itemArray;
}

- (void)addItems:(NSArray *)items
       titleColor:(UIColor *)color
    SelectedColor:(UIColor *)selectedColor {

  for (int i = 0; i < items.count; i++) {
    NSString *title = items[i];
    UIButton *item = [UIButton buttonWithType:UIButtonTypeCustom];
      item.tag = i;
    [self.scrollView addSubview:item];
    [self.itemArray addObject:item];
    [item setTitle:title forState:UIControlStateNormal];
    [item.titleLabel setFont:[UIFont systemFontOfSize:17]];
    [item setTitleColor:color forState:UIControlStateNormal];
    [item setTitleColor:selectedColor forState:UIControlStateSelected];
//    item.backgroundColor = [UIColor blueColor];

    if (i == 0) {
      item.selected = YES;
      self.selectedButton = item;
    }
  }
}


/**
 点击项目
 */
- (void)click:(UIButton *)button {
    
   
  _selectedButton.selected = NO;
  button.selected = YES;
  _selectedButton = button;
    
    [_scrollView bringSubviewToFront:_sliderBar];

    CGFloat x= button.frame.origin.x;
    
//   底部滑条
    [UIView animateWithDuration:.25
                     animations:^{
                         [_sliderBar
                          setFrame:CGRectMake(x, CGRectGetMaxY(button.frame) - 2,
                                              button.frame.size.width, 2)];
                         [_sliderBar layoutIfNeeded];
                     }];
    

//    调整scrollView的偏移量
    [self adjustScrollView:button];
    
//    代理
    if ([self.delegate respondsToSelector:@selector(ScrollMenuViewClickWithIndex:)]) {
        [self.delegate ScrollMenuViewClickWithIndex:button.tag];
    }
    
}

- (void)adjustScrollView:(UIButton *)button
{
    CGFloat width =self.bounds.size.width;

    // 计算偏移量
    CGFloat offsetX = button.center.x - width * 0.5;
    
    if (offsetX < 0) offsetX = 0;
    
    // 获取最大滚动范围
    CGFloat maxOffsetX = _scrollView.contentSize.width - width;
    
    if (offsetX > maxOffsetX) offsetX = maxOffsetX;
    
    // 滚动标题滚动条
    [_scrollView setContentOffset:CGPointMake(offsetX, 0) animated:YES];
}

- (void)layoutSubviews {
  [super layoutSubviews];

  static CGFloat lastX = 0;

  for (int i = 0; i < _itemArray.count; i++) {

    UIButton *button = _itemArray[i];

    CGFloat width = [self getItemWidthWithTitle:button.currentTitle];

    CGFloat x = lastX + 10;

    button.frame = CGRectMake(x, 0, width, 44);

    lastX = CGRectGetMaxX(button.frame);

    [button addTarget:self
                  action:@selector(click:)
        forControlEvents:UIControlEventTouchUpInside];
      
      if (button.selected) {
          self.sliderBar.frame =
          CGRectMake(button.frame.origin.x, CGRectGetMaxY(button.frame) - 2,
                     button.frame.size.width, 2);
      }
      
  }
    
    
    [_scrollView setContentSize:CGSizeMake(lastX+10, 0)];

    lastX = 0;
}


/**
 计算每个项目的宽度

 @param title 标题
 @return 宽度
 */
- (CGFloat)getItemWidthWithTitle:(NSString *)title {

  CGFloat width = 0;

  NSDictionary *attributes =
      @{NSFontAttributeName : [UIFont systemFontOfSize:17]};
  width = [title sizeWithAttributes:attributes].width;

  //  NSLog(@"width=%f", width);

  return width;
}

@end
