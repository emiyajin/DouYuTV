//
//  HomeViewController.m
//  DouYuTV
//
//  Created by emiyajin on 17/2/5.
//  Copyright © 2017年 emiyajin. All rights reserved.
//

#import "HomeViewController.h"
#import "UIBarButtonItem+BSExtension.h"
#import "PageTitlesView.h"
#import "PageContentView.h"
#import "RecommandViewController.h"

@interface HomeViewController ()<PageTitlesViewDelegate,PageContentViewDelegate>
/**
 *  标题页面
 */
@property (weak,nonatomic) PageTitlesView *titlesView;
/**
 *  标题内容页面
 */
@property (strong,nonatomic) PageContentView *contentView;
@end

@implementation HomeViewController

#pragma mark -- 懒加载
-(PageTitlesView *)titlesView
{
    if (_titlesView == nil) {
        PageTitlesView *view = [[PageTitlesView alloc]initWithFrame:CGRectMake(0, NavBarMaxY, IPHONE_WIDTH, titleViewH) titles:@[@"推荐",@"游戏",@"娱乐",@"趣玩"]];
        [self.view addSubview:view];
        _titlesView = view;
    }
    return _titlesView;
}

-(PageContentView *)contentView
{
    if (!_contentView) {
        //内容尺寸设置，特别是针对Y和高度
        CGFloat contentY = NavBarMaxY + titleViewH;
        //针对高度调控，防止contentView展示的view有点位置拉伸不出来
        CGRect contentF = CGRectMake(0, contentY, IPHONE_WIDTH, IPHONE_HEIGHT - contentY - TabbarH);
        NSMutableArray *childVcs = [[NSMutableArray alloc]init];
        [childVcs addObject:[[RecommandViewController alloc]init]];
        for (int i = 0; i < 3; i++) {//这个4是根据titles判断的
            UIViewController *vc = [[UIViewController alloc]init];
            vc.view.backgroundColor = XMGRandomColor;
            [childVcs addObject:vc];
        }
        _contentView = [[PageContentView alloc]initWithFrame:contentF ChildViewControllers:childVcs ParentViewController:self];
        _contentView.backgroundColor = [UIColor purpleColor];
        _contentView.delegate = self;
    }
    return _contentView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    //设置UI界面
    [self setupUi];
}

#pragma mark -- 设置UI界面
-(void)setupUi{
    //不需要调整UIScrollView的内边距
    self.automaticallyAdjustsScrollViewInsets = NO;
    //设置导航栏
    [self setupNav];
    //设置标题栏和它的代理
    self.titlesView.delegate = self;
    //添加标题标题内容界面
    [self.view addSubview:self.contentView];
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

#pragma mark -- PageTitlesViewDelegate
-(void)pageTitleView:(PageTitlesView *)titleView selectedIndex:(NSInteger)index
{
    //把index直接传进来
    [self.contentView setupCurrentIndex:index];
}
#pragma mark -- PageContentViewDelegate
-(void)PageContentView:(PageContentView *)contentView progress:(CGFloat)progress sourceIndex:(NSInteger)sourceIndex targetIndex:(NSInteger)targetIndex
{
    [self.titlesView setupTitleWithProgress:progress sourceIndex:sourceIndex targetIndex:targetIndex];
}
@end
