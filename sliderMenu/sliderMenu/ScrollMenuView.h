//
//  ScrollMenuView.h
//  sliderMenu
//
//  Created by 轩辕神赋 on 2017/4/10.
//  Copyright © 2017年 轩辕神赋. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ScrollMenuViewDelegate<NSObject>

- (void)ScrollMenuViewClickWithIndex:(NSInteger)index;

@end

@interface ScrollMenuView : UIView

/**
 每个项目中的间距
 */
@property (assign,nonatomic)CGFloat itemPadding;
@property (nonatomic,weak)id<ScrollMenuViewDelegate>delegate;


/**
 添加项目
 @param color 正常标题颜色
 @param selectedColor 选中标题颜色
 */
- (void)addItems:(NSArray *)items titleColor:(UIColor *)color SelectedColor:(UIColor *)selectedColor;
@end
