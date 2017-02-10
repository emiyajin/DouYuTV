//
//  RecommandCycleView.m
//  DouYuTV
//
//  Created by emiyajin on 17/2/10.
//  Copyright © 2017年 emiyajin. All rights reserved.
//

#import "RecommandCycleView.h"
#import "CycleModel.h"
#import "CollectionCycleCell.h"

@interface RecommandCycleView()<UICollectionViewDataSource,UICollectionViewDelegate>
/**
 *  轮播器
 */
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
/**
 *  页码
 */
@property (weak, nonatomic) IBOutlet UIPageControl *pageView;
/**
 *  无限滚动的定时器
 */
@property (strong,nonatomic) NSTimer *cycleTimer;
@end

@implementation RecommandCycleView
-(void)awakeFromNib
{
    [super awakeFromNib];
    // 设置控件不随父控件拉伸而拉伸
    // 设置原因:出现BUG,在添加view的时候发现view根本没有显示
    // 分析原因:因为父控件，也就是collectionView的尺寸是self.view.bounds,也就是手机屏幕(0,0)坐标的位置，然后为了需求考虑，对collectionView进行拉伸考虑，使其宽度，高度随父控件变化而变化，由于xib建立的view是默认随父控件拉伸的，可能经过这一系列处理，导致该子控件就此“消失了，所以用这一句话，不让该控件随着父控件拉伸而拉伸，然后控件就出现了
    self.autoresizingMask = UIViewAutoresizingNone;

    //注册cell
    [self.collectionView registerNib:[UINib nibWithNibName:@"CollectionCycleCell" bundle:nil] forCellWithReuseIdentifier:CycleCell];
    self.collectionView.showsHorizontalScrollIndicator = NO;
    //设置分页
    self.collectionView.pagingEnabled = YES;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    //由于从xib加载，在awakefromnib设置布局不准确，所以在这里设置collectionLayout的布局
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    layout.itemSize = self.bounds.size;
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    layout.minimumLineSpacing = 0;
    layout.minimumInteritemSpacing = 0;
    self.collectionView.collectionViewLayout = layout;
}

+(instancetype)cycleView
{
    return [[[NSBundle mainBundle]loadNibNamed:NSStringFromClass(self) owner:nil options:nil]lastObject];
}
#pragma mark -- 数据的set方法
-(void)setCycleModels:(NSMutableArray *)cycleModels
{
    _cycleModels = cycleModels;
    //刷新表格
    [self.collectionView reloadData];
    //设置pagecontrol的个数
    self.pageView.numberOfPages = cycleModels.count == 0 ? 0 : cycleModels.count;
    //由于涉及到无限滚动，所以在这里也要设计一下下标值，不仅仅能左滑滚动，右滑也是ok的
    NSIndexPath *indexPath = [NSIndexPath indexPathForItem:(self.cycleModels.count == 0 ? 0 : self.cycleModels.count) * 10 inSection:0];
    [self.collectionView scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionLeft animated:YES];
    //添加定时器 -- 但是在添加之前先移除
    [self removeCycleTimer];
    [self addCycleTimer];
}
#pragma mark -- UICollectionViewDataSource & UICollectionViewDelegate
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    //设计无限滚动，就拉大展示的数据，例如*100
    return (self.cycleModels.count == 0 ? 0 : self.cycleModels.count) * 100;
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CollectionCycleCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:CycleCell forIndexPath:indexPath];
    //由于设计了无限滚动，所以取的下标值也得模一下来获取
    CycleModel *cycle = self.cycleModels[indexPath.item % self.cycleModels.count];
    cell.cycle = cycle;
    return cell;
}
/**
 * 监听scrollView的滚动
 */
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    //获取滚动的偏移量 -- 根据需求组，滚动超过一半了就设计跳过去
    CGFloat offsetX = scrollView.contentOffset.x + scrollView.xmg_width * 0.5;
    //计算pageControl的currentIndex
    NSInteger looper = self.cycleModels.count == 0 ? 1 : self.cycleModels.count;
    //由于下标值改变了，所以当前页码也要模一下才能获取到正确的数据
    self.pageView.currentPage = (int)(offsetX / scrollView.xmg_width) % looper;
}
//如果用户手动拖拽，那么在代理方法里监听定时器的取消和添加
-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self removeCycleTimer];
}
-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    [self addCycleTimer];
}
#pragma mark -- 自动无限滚动定时器方法
//添加定时器
-(void)addCycleTimer
{
    self.cycleTimer = [NSTimer timerWithTimeInterval:3.0 target:self selector:@selector(scrollToNext) userInfo:nil repeats:YES];
    [[NSRunLoop mainRunLoop]addTimer:self.cycleTimer forMode:NSRunLoopCommonModes];
}
-(void)scrollToNext{
    //获取要滚动的偏移量
    CGFloat currentOffsetX = self.collectionView.contentOffset.x;
    CGFloat offsetX = currentOffsetX + self.collectionView.bounds.size.width;
    //滚动到该位置
    [self.collectionView setContentOffset:CGPointMake(offsetX, 0) animated:YES];
}
//移除定时器
-(void)removeCycleTimer
{
    //从运行循环中移除
    [self.cycleTimer invalidate];
    self.cycleTimer = nil;
}

@end
