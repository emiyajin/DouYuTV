//
//  RecommandViewController.m
//  DouYuTV
//
//  Created by emiyajin on 17/2/7.
//  Copyright © 2017年 emiyajin. All rights reserved.
//

#import "RecommandViewController.h"
#import "CollectionHeaderView.h"
#import "CollectionNormalCell.h"

@interface RecommandViewController ()<UICollectionViewDataSource>
/**
 *  collectionView
 */
@property (strong,nonatomic) UICollectionView *collectionView;
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
        _collectionView.backgroundColor = [UIColor whiteColor];
        //注册cell
        [_collectionView registerNib:[UINib nibWithNibName:@"CollectionNormalCell" bundle:nil] forCellWithReuseIdentifier:recommandNormalCell];
        //注册headerView
        [_collectionView registerNib:[UINib nibWithNibName:@"CollectionHeaderView" bundle:nil] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:recommandCellHeader];
    }
    return _collectionView;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    //设置UI界面
    [self setupUI];
}

#pragma mark -- 设置UI界面
-(void)setupUI
{
    [self.view addSubview:self.collectionView];
    //由于collectionView尺寸问题，self.view.bounds，宽高还是模拟器所在的高度，所以适配下高度问题 -- 固定下宽高
    self.collectionView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
}

#pragma mark -- UICollectionViewDataSource
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    //根据模块，有12组
    return 12;
}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    //根据模块，第一组8个其他4个
    if (section == 0) {
        return 8;
    }else{
        return 4;
    }
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CollectionNormalCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:recommandNormalCell forIndexPath:indexPath];
    return cell;
}
-(UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    CollectionHeaderView *view = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:recommandCellHeader forIndexPath:indexPath];
    return view;
}
@end
