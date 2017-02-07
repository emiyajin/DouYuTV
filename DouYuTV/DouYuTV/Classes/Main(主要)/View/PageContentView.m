//
//  PageContentView.m
//  DouYuTV
//
//  Created by emiyajin on 17/2/6.
//  Copyright © 2017年 emiyajin. All rights reserved.
//

#import "PageContentView.h"

@interface PageContentView()<UICollectionViewDataSource,UICollectionViewDelegate>
/**
 *  存放子控制器的数组
 */
@property (strong,nonatomic) NSArray *childVcs;
/**
 *  父控制器 -- 用弱引用，因为外面传的父控件是"home"控制器,是强引用,如果这里也是强引用的话会造成循环引用，所以改成弱引用
 */
@property (weak,nonatomic) UIViewController *parentVc;
/**
 *  显示标题内容的CollectionView
 */
@property (weak,nonatomic) UICollectionView *collectionView;
/** 开始的x的偏移量 */
@property (assign,nonatomic)CGFloat startOffsetX;
/** 是不是禁止滚动代理 */
@property (assign,nonatomic)BOOL isForbidScrollDelegate;


@end

//设置标识
static NSString *contentCell = @"contentCell";
@implementation PageContentView

#pragma mark -- 懒加载
-(UICollectionView *)collectionView
{
    if (!_collectionView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
        layout.itemSize = self.bounds.size;
        layout.minimumLineSpacing = 0;
        layout.minimumInteritemSpacing = 0;
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;

        UICollectionView *cv = [[UICollectionView alloc]initWithFrame:self.bounds collectionViewLayout:layout];
        cv.showsHorizontalScrollIndicator = NO;
        cv.pagingEnabled = YES;
        cv.bounces = NO;
        //注册cell
        [cv registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:contentCell];
        [self addSubview:cv];
        _collectionView = cv;
    }
    return _collectionView;
}

#pragma mark -- UI设置
-(instancetype)initWithFrame:(CGRect)frame ChildViewControllers:(NSArray *)childVcs ParentViewController:(UIViewController *)parentVc
{
    self.childVcs = childVcs;
    self.parentVc = parentVc;
    self = [super initWithFrame:frame];
    if (self) {
        //遍历添加子控制器
        for (UIViewController *vc in self.childVcs) {
            [self.parentVc addChildViewController:vc];
        }
        //设置数据源和代理
        self.collectionView.dataSource = self;
        self.collectionView.delegate = self;
        self.isForbidScrollDelegate = NO;
    }
    return self;
}

#pragma mark -- UICollectionViewDataSource,UICollectionViewDelegate
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.childVcs.count;
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:contentCell forIndexPath:indexPath];
    //由于循环引用考虑所以在此之前，需要删除一次
    for (UIView *view in cell.contentView.subviews) {
        [view removeFromSuperview];
    }
    UIViewController *childVc = self.childVcs[indexPath.item];
    childVc.view.frame = cell.contentView.bounds;
    [cell.contentView addSubview:childVc.view];
    return cell;
}
//开始拖拽的时候调用
-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    self.isForbidScrollDelegate = NO;

    //获取开始拖拽时候的起点
    self.startOffsetX = scrollView.contentOffset.x;
}
//监听collectionView的滚动
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    //判断是否为点击事件
    if (self.isForbidScrollDelegate) {//是就直接返回
        return;
    }

    //定义需要获取的数据
    //滑动比例
    CGFloat progress = 0;
    //当前下标值
    NSInteger sourceIndex = 0;
    //目标下标值
    NSInteger targetIndex = 0;

    //判断是左滑还是右滑
    CGFloat currentOffsetX = scrollView.contentOffset.x;
    CGFloat scrollW = scrollView.bounds.size.width;
    CGFloat ratio = currentOffsetX / scrollW;
    if (currentOffsetX > self.startOffsetX) {//根据画图模拟，可以得知是左滑
        //计算比例 = 偏移量/滚动条的宽度(由于都是CGFloat,根据滑动原理，可能非整) - 取整的上述算式，就是一个比例
        progress = ratio - floor(ratio);
        //计算当前的下标值
        sourceIndex = currentOffsetX / scrollW;
        //计算目标下标值
        targetIndex = sourceIndex + 1;
        if (targetIndex >= self.childVcs.count) {//越界判定
            targetIndex = self.childVcs.count - 1;
        }

        if (currentOffsetX - self.startOffsetX == scrollW) {
            //如果完全滑过去，那么进度是满的
            progress = 1.0;
            //目标也等于了源
            targetIndex = sourceIndex;
        }

    }else{//右滑
        //计算targetIndex
        targetIndex = (currentOffsetX / scrollW);
        //计算sourceIndex
        sourceIndex = targetIndex + 1;
        if (sourceIndex >= self.childVcs.count) {
            sourceIndex = self.childVcs.count - 1;
        }
        //计算比例 = 偏移量/滚动条的宽度(由于都是CGFloat,根据滑动原理，可能非整) - 取整的上算式,得出的结果，再用1这个整量去减掉，即可
        progress = 1 - (ratio - floor(ratio));
    }

    //校验
    //XMGLog(@"progress=%f,sourceIndex=%ld,targetsource=%ld",progress,sourceIndex,targetIndex);
    //将progress/sourceIndex/targetIndex传递给titleView
    if ([self.delegate respondsToSelector:@selector(PageContentView:progress:sourceIndex:targetIndex:)]) {
        [self.delegate PageContentView:self progress:progress sourceIndex:sourceIndex targetIndex:targetIndex];
    }
}
#pragma mark -- 对外暴露的方法
-(void)setupCurrentIndex:(NSInteger)index
{
    //记录需要禁止执行代理方法
    self.isForbidScrollDelegate = YES;

    //滚动到正确位置
    CGFloat offsetX =  index * self.collectionView.xmg_width;
    //收到所在Index，设置collectionView的ContentOffset
    [self.collectionView setContentOffset:CGPointMake(offsetX, 0) animated:NO];
}
@end
