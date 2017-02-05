//
//  UIView+Frame.h
//  BuDeJie
//
//  Created by xiaomage on 16/3/12.
//  Copyright © 2016年 小码哥. All rights reserved.
//

#import <UIKit/UIKit.h>
/*
 
    写分类:避免跟其他开发者产生冲突,加前缀
 
 */
@interface UIView (Frame)

@property CGFloat xmg_width;
@property CGFloat xmg_height;
@property CGFloat xmg_x;
@property CGFloat xmg_y;
@property CGFloat xmg_centerX;
@property CGFloat xmg_centerY;
@property (assign, nonatomic) CGSize xmg_size;
@property (assign, nonatomic) CGPoint xmg_origin;
/**
 *  判断一个控件是否真正显示在主窗口
 */
-(BOOL)isShowingOnKeyWindow;
/**
 *  通过xib设计的view的调用方法
 */
+(instancetype)viewFromXib;
@end
