//
//  PageTitlesView.m
//  DouYuTV
//
//  Created by emiyajin on 17/2/5.
//  Copyright © 2017年 emiyajin. All rights reserved.
//

#import "PageTitlesView.h"

//滚动线条的高度
static CGFloat scrollLineH = 2;
//设置普通的RGB颜色
static CGFloat NormalColorR = 85;
static CGFloat NormalColorG = 85;
static CGFloat NormalColorB = 85;
//设置选中的RGB颜色
static CGFloat SelectedColorR = 255;
static CGFloat SelectedColorG = 128;
static CGFloat SelectedColorB = 0;

@interface PageTitlesView()
/**
 *  标题数组
 */
@property (strong,nonatomic) NSArray *titles;
/**
 *  存放标题Label的数组
 */
@property (strong,nonatomic) NSMutableArray *titleLabels;
/** 当前label的下标值 */
@property (assign,nonatomic) NSInteger currentLabelIndex;

/**
 *  放置标题的滚动条
 */
@property (weak,nonatomic) UIScrollView *titleScrollView;
/**
 *  滚动线条
 */
@property (weak,nonatomic) UIView *scrollLine;
@end

@implementation PageTitlesView

#pragma mark -- 懒加载
-(NSArray *)titles
{
    if (_titles == nil) {
        _titles = [[NSArray alloc]init];
    }
    return _titles;
}
-(NSMutableArray *)titleLabels
{
    if(_titleLabels == nil)
    {
        _titleLabels = [[NSMutableArray alloc]init];
    }
    return _titleLabels;
}
-(UIScrollView *)titleScrollView
{
    if (_titleScrollView == nil) {
        UIScrollView *scrollView = [[UIScrollView alloc]init];
        scrollView.showsHorizontalScrollIndicator = NO;
        //不需要点击自动滚到顶部
        scrollView.scrollsToTop = NO;
        //不需要弹簧效果
        scrollView.bounces = NO;
        _titleScrollView = scrollView;
        [self addSubview:self.titleScrollView];
    }
    return _titleScrollView;
}
-(UIView *)scrollLine
{
    if (!_scrollLine) {
        UIView *view = [[UIView alloc]init];
        view.backgroundColor = [UIColor orangeColor];
        [self.titleScrollView addSubview:view];
        _scrollLine = view;
    }
    return _scrollLine;
}

-(instancetype)initWithFrame:(CGRect)frame titles:(NSArray *)titles
{
    self.titles = titles;
    self = [super initWithFrame:frame];
    if (self) {
        //设置UI界面
        [self setupUI];
    }
    return self;
}

#pragma mark -- 界面布局
-(void)setupUI
{
    self.titleScrollView.frame = self.bounds;
    //设置标题label
    [self setupTitlesLabel];
    //添加一条底部的线
    [self setupBottomLine];
    //设置滚动线条
    [self setupSrollLine];
}
-(void)setupTitlesLabel
{
    //设置label一些固定属性
    CGFloat labelW = IPHONE_WIDTH / self.titles.count;
    //其中的2像素是给下面的一条线
    CGFloat labelH = self.xmg_height - scrollLineH;
    CGFloat labelY = 0;
    for (int index = 0; index < self.titles.count; index ++) {
        UILabel *label = [[UILabel alloc]init];
        label.frame = CGRectMake(index * labelW, labelY, labelW, labelH);
        label.font = [UIFont systemFontOfSize:16.0];
        label.textColor = XMGRGBColor(NormalColorR, NormalColorG, NormalColorB);
        label.tag = index + 10;
        label.text = self.titles[index];
        //设置文字居中
        label.textAlignment = NSTextAlignmentCenter;
        [self.titleScrollView addSubview:label];
        //添加label
        [self.titleLabels addObject:label];

        //给label添加手势
        label.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapClick:)];
        [label addGestureRecognizer:tap];
    }
}
-(void)setupBottomLine
{
    UIView *bottomLine = [[UIView alloc]initWithFrame:CGRectMake(0, self.xmg_height - 0.5, self.xmg_width, 0.5)];
    bottomLine.backgroundColor = [UIColor lightGrayColor];
    [self addSubview:bottomLine];
}
-(void)setupSrollLine
{
    UILabel *firstLabel = self.titleLabels.firstObject;
    firstLabel.textColor = XMGRGBColor(SelectedColorR, SelectedColorG, SelectedColorB);
    self.scrollLine.frame = CGRectMake(firstLabel.xmg_x, self.xmg_height - scrollLineH, firstLabel.xmg_width, scrollLineH);
}
#pragma mark -- 手势点击
-(void)tapClick:(UITapGestureRecognizer *)tap
{
    //获取点击的view
    UIView *view = tap.view;
    //获取它所在的index
    NSInteger index = (view.tag - 10);
    //滚动到指定下标
    [self scrollToIndex:index];

    //通知代理
    if ([self.delegate respondsToSelector:@selector(pageTitleView:selectedIndex:)]) {
        [self.delegate pageTitleView:self selectedIndex:index];
    }
}
//滚动到指定下标
-(void)scrollToIndex:(NSInteger)index
{
    //获得新旧label
    UILabel *oldLabel = self.titleLabels[self.currentLabelIndex];
    UILabel *currentLabel = self.titleLabels[index];

    //切换文字的颜色
    currentLabel.textColor = XMGRGBColor(SelectedColorR, SelectedColorG, SelectedColorB);
    oldLabel.textColor = XMGRGBColor(NormalColorR, NormalColorG, NormalColorB);

    //滚动条x位置发生改变
    CGFloat scrollLinePositionX = (currentLabel.tag - 10) * self.scrollLine.xmg_width;
    [UIView animateWithDuration:0.15 animations:^{
        self.scrollLine.xmg_x = scrollLinePositionX;
    }];

    //记录index
    self.currentLabelIndex = index;
}

-(void)setupTitleWithProgress:(CGFloat)progress sourceIndex:(NSInteger)sourceIndex targetIndex:(NSInteger)targetIndex
{
    //取出sourceLabel/targetLabel
    UILabel *sourceLabel = self.titleLabels[sourceIndex];
    UILabel *targetLabel = self.titleLabels[targetIndex];

    //处理滑块逻辑
    CGFloat moveTotalX =  targetLabel.xmg_x - sourceLabel.xmg_x;
    CGFloat moveX = moveTotalX * progress;
    self.scrollLine.xmg_x = sourceLabel.xmg_x + moveX;

    //颜色的渐变设置
    NSArray *colorDelta = @[@(SelectedColorR-NormalColorR),@(SelectedColorG-NormalColorG),@(SelectedColorB-NormalColorB)];

    //变化sourceLabel
    CGFloat sourceLabelDeltaR =  SelectedColorR - [colorDelta[0] floatValue] * progress;
    CGFloat sourceLabelDeltaG =  SelectedColorG - [colorDelta[1] floatValue] * progress;
    CGFloat sourceLabelDeltaB =  SelectedColorB - [colorDelta[2] floatValue] * progress;
    sourceLabel.textColor = XMGRGBColor(sourceLabelDeltaR, sourceLabelDeltaG, sourceLabelDeltaB);

    //变化targetLabel
    CGFloat targetLabelDeltaR =  NormalColorR + [colorDelta[0] floatValue] * progress;
    CGFloat targetLabelDeltaG =  NormalColorG + [colorDelta[1] floatValue] * progress;
    CGFloat targetLabelDeltaB =  NormalColorB +  [colorDelta[2] floatValue] * progress;
    targetLabel.textColor = XMGRGBColor(targetLabelDeltaR, targetLabelDeltaG, targetLabelDeltaB);

    //此时index会有变化，在此记录最新的index
    self.currentLabelIndex = targetIndex;

}
@end
