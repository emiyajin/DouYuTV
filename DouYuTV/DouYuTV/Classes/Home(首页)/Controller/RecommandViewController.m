//
//  RecommandViewController.m
//  DouYuTV
//
//  Created by emiyajin on 17/2/7.
//  Copyright © 2017年 emiyajin. All rights reserved.
//

#import "RecommandViewController.h"
#import "CollectionHeaderView.h"
#import "CollectionBaseCell.h"
#import "CollectionNormalCell.h"
#import "CollectionPrettyCell.h"
#import <NJAFNetworking.h>
#import "RecommandResponse.h"
#import "Anchor.h"
#import "AnchorGroup.h"
#import "RecommandCycleView.h"
#import "RecommandGameView.h"

@interface RecommandViewController ()<UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
/**
 *  collectionView
 */
@property (strong,nonatomic) UICollectionView *collectionView;
/**
 *  轮播器View
 */
@property (strong,nonatomic) RecommandCycleView *cycleView;
/**
 *  游戏推荐View
 */
@property (strong,nonatomic) RecommandGameView *gameView;
@end

@implementation RecommandViewController

#pragma mark -- 懒加载
-(UICollectionView *)collectionView
{
    if (!_collectionView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
        //求出item的宽高,高度是宽度的3/4,宽是手机宽度-3*间距后的一半
        CGFloat itemW = (IPHONE_WIDTH - 3 * recommandCellItemMargin)/2;
        CGFloat itemH = itemW * 3 / 4;
        layout.itemSize = CGSizeMake(itemW, itemH);
        layout.minimumLineSpacing = 0;
        //这次需要中间有间距
        layout.minimumInteritemSpacing = recommandCellItemMargin;
        //根据最小间距的问题，得出是最小有那么大的空间，但是最大就不能控制了，所以要设置下Inset
        layout.sectionInset = UIEdgeInsetsMake(0, recommandCellItemMargin, 0, recommandCellItemMargin);
        layout.headerReferenceSize = CGSizeMake(IPHONE_WIDTH, 54);

        _collectionView = [[UICollectionView alloc]initWithFrame:self.view.bounds collectionViewLayout:layout];
        _collectionView.dataSource = self;
        _collectionView.delegate = self;
        _collectionView.backgroundColor = [UIColor whiteColor];
        //注册cell
        [_collectionView registerNib:[UINib nibWithNibName:@"CollectionNormalCell" bundle:nil] forCellWithReuseIdentifier:recommandNormalCell];
        [_collectionView registerNib:[UINib nibWithNibName:@"CollectionPrettyCell" bundle:nil] forCellWithReuseIdentifier:recommandPrettyCell];
        //注册headerView
        [_collectionView registerNib:[UINib nibWithNibName:@"CollectionHeaderView" bundle:nil] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:recommandCellHeader];
    }
    return _collectionView;
}

-(RecommandCycleView *)cycleView
{
    if (!_cycleView) {
        _cycleView = [RecommandCycleView cycleView];
        //根据测量，由于要放在collectionView上方，所以Y值，其实是一个负数，而且是大于屏幕宽度的3/8这个位置，当然这个也就是cycleView的高度了，也可以根据具体需求来测量
        CGFloat cycleH = IPHONE_WIDTH * 3 / 8;
        //根据测量gameView的高度为90
        CGFloat gameViewH = 90;
        //因为又加入一个gameView所以y值又得高出一部分
        _cycleView.frame = CGRectMake(0, -(cycleH + gameViewH), IPHONE_WIDTH, cycleH);
    }
    return _cycleView;
}

-(RecommandGameView *)gameView
{
    if (!_gameView) {
        _gameView = [RecommandGameView gameView];
        //根据测量gameView的高度为90
        CGFloat gameViewH = 90;
        _gameView.frame = CGRectMake(0, -gameViewH, IPHONE_WIDTH, gameViewH);
    }
    return _gameView;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    //设置UI界面
    [self setupUI];

    //发送网络请求
    [self loadData];
}

#pragma mark -- 设置UI界面
-(void)setupUI
{
    //添加collectionView
    [self.view addSubview:self.collectionView];

    //由于collectionView尺寸问题，self.view.bounds，宽高还是模拟器所在的高度，所以适配下高度问题 -- 固定下宽高
    self.collectionView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;

    //collectionView添加一个cycleView
    [self.collectionView addSubview:self.cycleView];

    //collectionView添加一个gameView
    [self.collectionView addSubview:self.gameView];

    //设置collectionView的内边距，让cycleView出现(包括一个轮播器一个游戏推荐)
    CGFloat cycleH = IPHONE_WIDTH * 3 / 8;
    CGFloat gameViewH = 90;
    self.collectionView.contentInset = UIEdgeInsetsMake(cycleH + gameViewH, 0, 0, 0);
}

#pragma mark -- 请求数据
-(void)loadData
{
    //请求推荐数据
    [[RecommandResponse shareRecommandResponse]requestRecommandData:^{
        //展示推荐数据
        [self.collectionView reloadData];
        //将数据传递给GameView
        self.gameView.groups = [RecommandResponse shareRecommandResponse].anchorGroups;
    }];
    //请求轮播数据
    [[RecommandResponse shareRecommandResponse]requestCycleData:^
    {
        self.cycleView.cycleModels = [RecommandResponse shareRecommandResponse].cycles;
    }];
}

#pragma mark -- UICollectionViewDataSource
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    //根据模块，有12组
    return [RecommandResponse shareRecommandResponse].anchorGroups.count;
}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    //根据模块，第一组8个其他4个
    AnchorGroup *group = [RecommandResponse shareRecommandResponse].anchorGroups[section];
    return group.anchors.count;
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    //取出数据
    AnchorGroup *group = [RecommandResponse shareRecommandResponse].anchorGroups[indexPath.section];
    Anchor *anchor = group.anchors[indexPath.item];

    CollectionBaseCell *cell = nil;
    //根据section不同来判断使用什么cell，然后传递模型数据
    if (indexPath.section == 1) {
        cell = (CollectionNormalCell *)[collectionView dequeueReusableCellWithReuseIdentifier:recommandPrettyCell forIndexPath:indexPath];
    }else{
        cell = (CollectionPrettyCell *)[collectionView dequeueReusableCellWithReuseIdentifier:recommandNormalCell forIndexPath:indexPath];
    }
    cell.anchor = anchor;

    return cell;
}
/**
 设置collection的header，通过kind(这个kind传的是在代码里注册里设置的kind，这里设置的是header) collection 和所在indexpath创建UICollectionReusableView
 返回这个view
 */
-(UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    CollectionHeaderView *view = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:recommandCellHeader forIndexPath:indexPath];
    //取出模型
    AnchorGroup *group = [RecommandResponse shareRecommandResponse].anchorGroups[indexPath.section];
    view.group = group;
    return view;
}
#pragma mark -- UICollectionViewDelegateFlowLayout
/**
 设置布局的尺寸，用UICollectionViewDelegateFlowLayout这个代理方法，这个方法继承于UICollectionViewDelegate，也就是可以用UICollectionView的代理方法
 */
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat itemW = (IPHONE_WIDTH - 3 * recommandCellItemMargin)/2;
    //根据section的不同设置高度
    if (indexPath.section == 1) {
        return CGSizeMake(itemW, itemW * 4 / 3);
    }
    return CGSizeMake(itemW, itemW * 3 / 4);
}
@end
