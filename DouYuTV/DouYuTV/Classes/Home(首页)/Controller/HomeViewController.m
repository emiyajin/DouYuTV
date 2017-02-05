//
//  HomeViewController.m
//  DouYuTV
//
//  Created by emiyajin on 17/2/5.
//  Copyright © 2017年 emiyajin. All rights reserved.
//

#import "HomeViewController.h"
#import "UIBarButtonItem+BSExtension.h"

@interface HomeViewController ()

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self setupUi];
}

#pragma mark -- 设置UI界面
-(void)setupUi{
    [self setupNav];
}
/**
 设置导航栏
 */
-(void)setupNav{
    //设置左边的item
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImage:@"logo" target:self action:@selector(logoClick)];

    //设置右边的item -- 设计封装一个有间距的item
    CGSize size = CGSizeMake(40, 40 );
    UIBarButtonItem *historyItem = [UIBarButtonItem itemWithImage:@"image_my_history" highLightedImage:@"Image_my_history_click" size:size target:self action:@selector(historyClick)];
    UIBarButtonItem *searchItem = [UIBarButtonItem itemWithImage:@"btn_search" highLightedImage:@"btn_search_clicked" size:size target:self action:@selector(searchClick)];
    UIBarButtonItem *qrcodeItem = [UIBarButtonItem itemWithImage:@"Image_scan" highLightedImage:@"Image_scan_click" size:size target:self action:@selector(scanClick)];
    self.navigationItem.rightBarButtonItems = @[historyItem,searchItem,qrcodeItem];
}
-(void)logoClick
{
    
}
-(void)searchClick
{

}
-(void)historyClick
{

}
-(void)scanClick
{

}
@end
