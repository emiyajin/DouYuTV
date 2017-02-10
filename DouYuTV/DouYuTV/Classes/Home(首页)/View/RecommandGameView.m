//
//  RecommandGameView.m
//  DouYuTV
//
//  Created by emiyajin on 17/2/10.
//  Copyright © 2017年 emiyajin. All rights reserved.
//

#import "RecommandGameView.h"
#import "CollectionGameCell.h"

@interface RecommandGameView()<UICollectionViewDataSource,UICollectionViewDelegate>
/**
 *  装游戏推荐的View
 */
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@end

@implementation RecommandGameView

-(void)awakeFromNib
{
    [super awakeFromNib];

    //问题跟cycleView一样，所以也要设置不随着父控件拉伸
    self.autoresizingMask = UIViewAutoresizingNone;
    //根据分析，FlowLayout布局，就在xib上设置了，至于细节，可以自己百度参考做法
    //注册cell
    [self.collectionView registerNib:[UINib nibWithNibName:@"CollectionGameCell" bundle:nil] forCellWithReuseIdentifier:recommandGameCell];
    self.collectionView.showsHorizontalScrollIndicator = NO;
    //设置左右内边距，让游戏推荐界面好看一些
    self.collectionView.contentInset = UIEdgeInsetsMake(0,5, 0, 5);
}

+(instancetype)gameView
{
    return [[[NSBundle mainBundle]loadNibNamed:NSStringFromClass(self) owner:nil options:nil]lastObject];
}
#pragma mark -- 监听属性改变
-(void)setGroups:(NSMutableArray<AnchorGroup *> *)groups
{
    _groups = groups;

    //以为前两个是之前请求添加的，不需要的，可以选择移除第0个，然后再刷新
    [groups removeObjectAtIndex:0];
    [groups removeObjectAtIndex:0];
    //添加"更多"组
    AnchorGroup *moreGroup = [[AnchorGroup alloc]init];
    moreGroup.tag_name = @"更多";
    [groups addObject:moreGroup];

    [self.collectionView reloadData];
}

#pragma mark -- UICollectionViewDataSource,UICollectionViewDelegate
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.groups.count == 0 ? 0 : self.groups.count;
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CollectionGameCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:recommandGameCell forIndexPath:indexPath];
    AnchorGroup *group = self.groups[indexPath.item];
    cell.group = group;
    return cell;
}
@end
