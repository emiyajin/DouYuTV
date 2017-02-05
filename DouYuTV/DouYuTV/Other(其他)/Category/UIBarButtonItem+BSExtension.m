//
//  UIBarButtonItem+BSExtension.m
//  XMG-Bsbdj
//
//  Created by emiyajin on 16/8/24.
//  Copyright © 2016年 emiyajin. All rights reserved.
//

#import "UIBarButtonItem+BSExtension.h"

@implementation UIBarButtonItem (BSExtension)
+(instancetype)itemWithImage:(NSString *)image highLightedImage:(NSString *)highLightedImage target:(id)target action:(SEL)action
{
    //注意：把UIButton包装成UIBarButtonItem会扩大点击区域，注意
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setBackgroundImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    [button setBackgroundImage:[UIImage imageNamed:highLightedImage] forState:UIControlStateHighlighted];
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    [button sizeToFit];
    //所以封装一个UIView，让它做范围控制
    return [[self alloc]initWithCustomView:button];
}

+(instancetype)itemWithImage:(NSString *)image highLightedImage:(NSString *)hignLightedImage size:(CGSize)size target:(id)target action:(SEL)action
{
    //注意：把UIButton包装成UIBarButtonItem会扩大点击区域，注意
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:hignLightedImage] forState:UIControlStateHighlighted];
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    button.frame = CGRectMake(0, 0, size.width, size.height);
    //所以封装一个UIView，让它做范围控制
    return [[self alloc]initWithCustomView:button];
}

+(instancetype)itemWithImage:(NSString *)image selectedImage:(NSString *)selectedImage target:(id)target action:(SEL)action
{
    //注意：把UIButton包装成UIBarButtonItem会扩大点击区域，注意
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setBackgroundImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    [button setBackgroundImage:[UIImage imageNamed:selectedImage] forState:UIControlStateSelected];
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    [button sizeToFit];
    //所以封装一个UIView，让它做范围控制
    UIView *contanerView = [[UIView alloc]initWithFrame:button.frame];
    [contanerView addSubview:button];
    return [[self alloc]initWithCustomView:contanerView];
}

+(instancetype)backItemWithTitle:(NSString *)title Image:(NSString *)image highLightedImage:(NSString *)hignLightedImage target:(id)target action:(SEL)action
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [button setTitleColor:[UIColor redColor] forState:UIControlStateHighlighted];
    [button setImage:[UIImage imageNamed:image]forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:hignLightedImage]forState:UIControlStateHighlighted];
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    
    /**
     *  根据内容适配尺寸 --- 但是会修改尺寸
     */
    [button sizeToFit];
    
    //如果不想修改尺寸而改变按钮位置的话就设置这个--让按钮内部的所有内容做左对齐
    button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    
    /**
     *  设置contentEdgeInsets第二个参数为负数,让图片往左边“挤”，如此可以靠近左边，而看不出有缝隙
     */
    button.contentEdgeInsets = UIEdgeInsetsMake(0, -10, 0, 0);


    //设置导航栏左边的按钮设置，要用allocinit分配空间然后设置customView的
    return [[self alloc]initWithCustomView:button];
}

+(instancetype)itemWithImage:(NSString *)imageName target:(id)target action:(SEL)action
{
    //注意：把UIButton包装成UIBarButtonItem会扩大点击区域，注意
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setBackgroundImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    [button sizeToFit];
    //所以封装一个UIView，让它做范围控制
    return [[self alloc]initWithCustomView:button];
}
@end
