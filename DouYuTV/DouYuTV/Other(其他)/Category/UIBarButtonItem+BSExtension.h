//
//  UIBarButtonItem+BSExtension.h
//  XMG-Bsbdj
//
//  Created by emiyajin on 16/8/24.
//  Copyright © 2016年 emiyajin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (BSExtension)
/**
 * 通过背景图片，高亮图片，点击事件来创建一个导航条按钮(图片是背景图片)
 */
+(instancetype)itemWithImage:(NSString *)image highLightedImage:(NSString *)highLightedImage target:(id)target action:(SEL)action;
/**
 * 通过图片，高亮图片，尺寸,点击事件来创建一个返回的导航条按钮
 */
+(instancetype)itemWithImage:(NSString *)image highLightedImage:(NSString *)hignLightedImage size:(CGSize)size target:(id)target action:(SEL)action;
/**
 * 通过图片，选择图片，点击事件来创建一个导航条按钮
 */
+(instancetype)itemWithImage:(NSString *)image selectedImage:(NSString *)selectedImage target:(id)target action:(SEL)action;
/**
 * 通过图片，高亮图片，点击事件来创建一个返回的导航条按钮
 */
+(instancetype)backItemWithTitle:(NSString *)title Image:(NSString *)image highLightedImage:(NSString *)hignLightedImage target:(id)target action:(SEL)action;
/**
 * 通过图片,点击事件来创建一个导航条按钮(图片就是图片)
 */
+(instancetype)itemWithImage:(NSString *)imageName target:(id)target action:(SEL)action;
@end
