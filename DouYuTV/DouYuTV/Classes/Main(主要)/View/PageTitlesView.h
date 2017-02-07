//
//  PageTitlesView.h
//  DouYuTV
//
//  Created by emiyajin on 17/2/5.
//  Copyright © 2017年 emiyajin. All rights reserved.

//  通用的标题设置页面

#import <UIKit/UIKit.h>

@class PageTitlesView;
@protocol PageTitlesViewDelegate <NSObject>
@optional
-(void)pageTitleView:(PageTitlesView *)titleView selectedIndex:(NSInteger)index;

@end

@interface PageTitlesView : UIView
/**
 重写构造方法
 */
-(instancetype)initWithFrame:(CGRect)frame titles:(NSArray *)titles;
/** titleView的代理 */
@property (weak,nonatomic) id<PageTitlesViewDelegate> delegate;
/**
 传递progress,sourceIndex和targetIndex
 */
-(void)setupTitleWithProgress:(CGFloat)progress sourceIndex:(NSInteger)sourceIndex targetIndex:(NSInteger)targetIndex;

@end
