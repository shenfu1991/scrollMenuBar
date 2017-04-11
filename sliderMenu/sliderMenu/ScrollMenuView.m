//
//  ScrollMenuView.m
//  sliderMenu
//
//  Created by 轩辕神赋 on 2017/4/10.
//  Copyright © 2017年 轩辕神赋. All rights reserved.
//

#import "ScrollMenuView.h"
#define kWidth self.frame.size.width
#define kHeight self.frame.size.height

@interface ScrollMenuView ()

/**
 项目
 */
@property(nonatomic, strong) NSMutableArray *itemArray;

/**
 选中的按钮
 */
@property(nonatomic, weak) UIButton *selectedButton;

/**
 底部滚动条
 */
@property(nonatomic, strong) UIView *sliderBar;

/**
 滚动
 */
@property(nonatomic, strong) UIScrollView *scrollView;

/**
 项目比较少的时候不能滚动
 */
@property(nonatomic, assign) BOOL canScroll;

/**
  是否完成计算
 */
@property(nonatomic, assign) BOOL finishCaculate;


@end

@implementation ScrollMenuView

- (instancetype)init {
  if (self = [super init]) {
    self.backgroundColor = [UIColor lightGrayColor];
    self.canScroll = YES;
    self.itemPadding = 10;
  }

  return self;
}

- (UIScrollView *)scrollView {
  if (!_scrollView) {
    _scrollView = [[UIScrollView alloc] init];
    [self addSubview:_scrollView];
    _scrollView.frame = CGRectMake(0, 0, kWidth, kHeight);
    _scrollView.showsHorizontalScrollIndicator = NO;
  }

  return _scrollView;
}

- (UIView *)sliderBar {
  if (!_sliderBar) {
    _sliderBar = [UIView new];
    [self.scrollView addSubview:_sliderBar];
    _sliderBar.backgroundColor = [UIColor blackColor];
  }

  return _sliderBar;
}

- (NSMutableArray *)itemArray {
  if (!_itemArray) {
    _itemArray = [[NSMutableArray alloc] init];
  }

  return _itemArray;
}

/**
 添加项目
 */
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
    [item.titleLabel setFont:[UIFont systemFontOfSize:14]];
    [item setTitleColor:color forState:UIControlStateNormal];
    [item setTitleColor:selectedColor forState:UIControlStateSelected];
      

    if (i == 0) {
      item.selected = YES;
      self.selectedButton = item;
      [item.titleLabel setFont:[UIFont systemFontOfSize:17]];

    }
  }
}

/**
 点击项目
 */
- (void)click:(UIButton *)button {

  _selectedButton.selected = NO;
    [_selectedButton.titleLabel setFont:[UIFont systemFontOfSize:14]];
  button.selected = YES;
    [button.titleLabel setFont:[UIFont systemFontOfSize:17]];

  _selectedButton = button;

  [_scrollView bringSubviewToFront:_sliderBar];

  CGFloat x = button.frame.origin.x;

  //   底部滑条
  [UIView animateWithDuration:.25
                   animations:^{
                     [_sliderBar
                         setFrame:CGRectMake(x, CGRectGetMaxY(button.frame) - 3,
                                             button.frame.size.width, 3)];
                     [_sliderBar layoutIfNeeded];
                   }];

  //    调整scrollView的偏移量
  if (_canScroll) {
    [self adjustScrollView:button];
  }

  //    代理
  if ([self.delegate
          respondsToSelector:@selector(ScrollMenuViewClickWithIndex:)]) {
    [self.delegate ScrollMenuViewClickWithIndex:button.tag];
  }
}

- (void)adjustScrollView:(UIButton *)button {

  // 计算偏移量
  CGFloat offsetX = button.center.x - kWidth * 0.5;

  if (offsetX < 0)
    offsetX = 0;

  // 获取最大滚动范围
  CGFloat maxOffsetX = _scrollView.contentSize.width - kWidth;

  if (offsetX > maxOffsetX)
    offsetX = maxOffsetX;

  // 滚动标题滚动条
  [_scrollView setContentOffset:CGPointMake(offsetX, 0) animated:YES];
}

- (void)layoutSubviews {
  [super layoutSubviews];
    
    if (!_finishCaculate) {
        
  static CGFloat lastX = 0;
  CGFloat totalWidth = 0;

  for (int i = 0; i < _itemArray.count; i++) {
    UIButton *button = _itemArray[i];

    CGFloat width = [self getItemWidthWithTitle:button.currentTitle];
    totalWidth += width;

    CGFloat x = lastX + _itemPadding;

    button.frame = CGRectMake(x, 0, width, 44);

    lastX = CGRectGetMaxX(button.frame);

    [button addTarget:self
                  action:@selector(click:)
        forControlEvents:UIControlEventTouchUpInside];

    if (button.selected) {
      self.sliderBar.frame =
          CGRectMake(button.frame.origin.x, CGRectGetMaxY(button.frame) - 3,
                     button.frame.size.width, 3);
    }

    if (i == _itemArray.count - 1) {

//      CGFloat kWidth = self.bounds.size.width;
      CGFloat offWidth = kWidth - lastX;
      //            如果项目比较少时，居中显示
      if (offWidth > 50) {
        lastX = 0;
        _canScroll = NO;
          
          CGFloat paddingX = 20;
          CGFloat padingItem = (kWidth-totalWidth-paddingX*2)/(_itemArray.count-1);

        for (int i = 0; i < _itemArray.count; i++) {
          UIButton *button = _itemArray[i];

          CGFloat width = [self getItemWidthWithTitle:button.currentTitle];

          CGFloat x = 0;
//          if (i == 0) {
//            x = (kWidth - totalWidth -
//                 (_itemPadding * (_itemArray.count - 1))) /
//                2.0;
//
//          } else {
//            x = lastX + _itemPadding;
//          }
            
            if (i == 0) {
                x = paddingX;
                
            } else {
                x = lastX + padingItem;
            }
            
          button.frame = CGRectMake(x, 0, width, 44);

          lastX = CGRectGetMaxX(button.frame);

          if (button.selected) {
            self.sliderBar.frame = CGRectMake(button.frame.origin.x,
                                              CGRectGetMaxY(button.frame) - 3,
                                              button.frame.size.width, 3);
          }
        }
      }
    }
  }

  [_scrollView setContentSize:CGSizeMake(lastX + _itemPadding, 0)];

  lastX = 0;
        
        _finishCaculate=YES;
        
    }
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

  return width;
}

@end
