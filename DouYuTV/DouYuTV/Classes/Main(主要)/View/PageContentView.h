//
//  PageContentView.h
//  DouYuTV
//
//  Created by emiyajin on 17/2/6.
//  Copyright © 2017年 emiyajin. All rights reserved.
//  导航标题的内容

#import <UIKit/UIKit.h>

@class PageContentView;
@protocol PageContentViewDelegate <NSObject>
@optional
/**
 传递进度，源index和目标index
 */
-(void)PageContentView:(PageContentView *)contentView progress:(CGFloat)progress sourceIndex:(NSInteger)sourceIndex targetIndex:(NSInteger)targetIndex;

@end

@interface PageContentView : UIView
/**
 *  构造方法
 */
-(instancetype)initWithFrame:(CGRect)frame ChildViewControllers:(NSArray *)childVcs ParentViewController:(UIViewController *)parentVc;
/**
 *  通过当前导航标题的index来设置view
 */
-(void)setupCurrentIndex:(NSInteger )index;
/** 代理 */
@property (weak,nonatomic)id<PageContentViewDelegate> delegate;

@end
