//
//  MainViewController.m
//  DouYuTV
//
//  Created by emiyajin on 17/2/4.
//  Copyright © 2017年 emiyajin. All rights reserved.
//

#import "MainViewController.h"

@interface MainViewController ()

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    //添加通过故事版创建四个控制器
    [self addChildVC:@"Home"];
    [self addChildVC:@"Live"];
    [self addChildVC:@"Follow"];
    [self addChildVC:@"Profile"];
}

-(void)addChildVC:(NSString *)storyboardName
{
    UIViewController *childVC = [UIStoryboard storyboardWithName:storyboardName bundle:nil].instantiateInitialViewController;
    [self addChildViewController:childVC];
}
@end
