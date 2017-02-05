//
//  UIView+Frame.m
//  BuDeJie
//
//  Created by xiaomage on 16/3/12.
//  Copyright © 2016年 小码哥. All rights reserved.
//

#import "UIView+Frame.h"

@implementation UIView (Frame)

- (void)setXmg_height:(CGFloat)xmg_height
{
    CGRect rect = self.frame;
    rect.size.height = xmg_height;
    self.frame = rect;
}

- (CGFloat)xmg_height
{
    return self.frame.size.height;
}

- (CGFloat)xmg_width
{
    return self.frame.size.width;
}
- (void)setXmg_width:(CGFloat)xmg_width
{
    CGRect rect = self.frame;
    rect.size.width = xmg_width;
    self.frame = rect;
}

- (CGFloat)xmg_x
{
    return self.frame.origin.x;
    
}

- (void)setXmg_x:(CGFloat)xmg_x
{
    CGRect rect = self.frame;
    rect.origin.x = xmg_x;
    self.frame = rect;
}

- (void)setXmg_y:(CGFloat)xmg_y
{
    CGRect rect = self.frame;
    rect.origin.y = xmg_y;
    self.frame = rect;
}

- (CGFloat)xmg_y
{

    return self.frame.origin.y;
}

- (void)setXmg_centerX:(CGFloat)xmg_centerX
{
    CGPoint center = self.center;
    center.x = xmg_centerX;
    self.center = center;
}

- (CGFloat)xmg_centerX
{
    return self.center.x;
}

- (void)setXmg_centerY:(CGFloat)xmg_centerY
{
    CGPoint center = self.center;
    center.y = xmg_centerY;
    self.center = center;
}

-(void)setXmg_size:(CGSize)xmg_size
{
    CGRect frame = self.frame;
    frame.size = xmg_size;
    self.frame = frame;
}

- (CGSize)xmg_size
{
    return self.frame.size;
}

-(void)setXmg_origin:(CGPoint)xmg_origin
{
    CGRect frame = self.frame;
    frame.origin = xmg_origin;
    self.frame = frame;
}

- (CGPoint)xmg_origin
{
    return self.frame.origin;
}

- (CGFloat)xmg_centerY
{
    return self.center.y;
}
/**
 *  是不是在主窗口上展示的
 */
-(BOOL)isShowingOnKeyWindow
{
    //主窗口
    UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
    //以主窗口左上角为原点，计算self的矩形框
    //转换坐标系方法:将子控件,即subview的frame从subview.superview转到新的坐标系，也就是到keywindow这里，成立一个新的坐标，由此来完成，如果只滚动了图片，按了statusbar之后，只让"图片"模块得到回滚的需求
    //目的：将坐标系转变为以窗口建立的新坐标系,得到subview在窗口中的frame
    CGRect newFrame = [self.superview convertRect:self.frame toView:keyWindow];
    CGRect windowBounds = keyWindow.bounds;
    //主窗口的bounds和self的矩形框 是否有重叠
    BOOL intersects = CGRectIntersectsRect(newFrame, windowBounds);
    //四个条件(1.子控件的window有且在keywindow上,2.控件没有隐藏;3.子控件的透明度>0.01;4.两个矩形框(也可以理解为frame)有没有交叉，也就是有没有交集)
    return (self.window == keyWindow) && !self.hidden && self.alpha > 0.01 && intersects;
}
+(instancetype)viewFromXib
{
    return [[[NSBundle mainBundle]loadNibNamed:NSStringFromClass(self) owner:nil options:nil]lastObject];
}
@end
