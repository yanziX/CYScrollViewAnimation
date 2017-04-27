//
//  CYNonCarouselView.m
//  XRCarouselViewDemo
//
//  Created by storm on 17/4/26.
//  Copyright © 2017年 肖睿. All rights reserved.
//

#import "CYNonCarouselView.h"

#define LEFT      30    //左右内边距
#define TOP       20    //上下内边距
#define HORMARGIN 60   //
#define VERMARGIN 40
@interface CYNonCarouselView ()<UIScrollViewDelegate>

{
    BOOL endDragging;
    NSInteger nextPage;
}

@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UIPageControl *pageControl;
@property (nonatomic, strong) NSTimer *timer;
@property (nonatomic, assign) NSInteger currentIndex;  //手势开始的时候的Page
@property (nonatomic, assign) CGRect currentFrame;
@end

@implementation CYNonCarouselView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self initSubViews];
    }
    return self;
}

- (void)initSubViews {

    [self addSubview:self.scrollView];
    [self addSubview:self.pageControl];
}

- (void)setImagesArr:(NSArray *)imagesArr {
    
    _imagesArr = imagesArr;
    _scrollView.contentSize = CGSizeMake(_imagesArr.count * self.frame.size.width, self.frame.size.height);
    self.pageControl.numberOfPages = _imagesArr.count;
    for (int i = 0; i < imagesArr.count; i++) {
        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"%@",_imagesArr[i]]];
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(self.frame.size.width * i + LEFT, 0, self.frame.size.width - LEFT * 2, self.frame.size.height)];
        imageView.image = image;
        [self.scrollView addSubview:imageView];
    }
    
    self.pageControl.currentPage = 0;
  
}

#pragma mark - 设置圆角
- (void)setCornerNum:(CGFloat)cornerNum {
    _cornerNum = cornerNum;
    [self.scrollView.subviews enumerateObjectsUsingBlock:^(UIImageView * imageView, NSUInteger index, BOOL * stop) {
        imageView.layer.cornerRadius = _cornerNum;
        imageView.layer.masksToBounds = YES;
    }];
}

- (UIScrollView *)scrollView {
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
        _scrollView.bounces = YES;
        _scrollView.showsVerticalScrollIndicator = NO;
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.contentSize = CGSizeMake(self.imagesArr.count * self.frame.size.width, self.frame.size.height);
        _scrollView.delegate = self;
        _scrollView.pagingEnabled = YES;
    }
    return _scrollView;
}

- (UIPageControl *)pageControl {
    if (!_pageControl) {
        _pageControl = [[UIPageControl alloc] init];
        _pageControl.numberOfPages = self.imagesArr.count;
        CGSize size = [_pageControl sizeForNumberOfPages:self.imagesArr.count];
        _pageControl.bounds = CGRectMake(0, 0, size.width, size.height);
        _pageControl.center = CGPointMake(self.center.x, self.center.y);
        _pageControl.currentPageIndicatorTintColor = [UIColor whiteColor];
        _pageControl.pageIndicatorTintColor = [UIColor grayColor];
        [self.pageControl setValue:[UIImage imageNamed:@"other"] forKey:@"_currentPageImage"];
        [self.pageControl setValue:[UIImage imageNamed:@"current"] forKey:@"_pageImage"];
    }
    return _pageControl;
}



/**
 *  开始移动scrollview
 */
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    int current = (scrollView.contentOffset.x / scrollView.frame.size.width + 0.5);
    self.currentIndex = current;
}


/**
 *  拖拽将要结束结束
 */
- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset {
    
}

/**
 *  拖拽结束
 */
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    
}

/**
 *  scrollView停止滚动，更新页数
 ＊  nextPage 一直拖拽结束后的page，和拖拽开始的page相比，如果值有变化，要做出相应的view变化
 */
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    
}


/**
 *  判断向左滑动还是向右滑动，处理imageView的变化
 *  除去当前current的imageView不做变化，是为了适应长按scrollview进行滑动时的情况，所有长按滑动的ImageView都应该变小，手势结束后再处理。
 */
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    int current = (scrollView.contentOffset.x / scrollView.frame.size.width + 0.5);
    
    [self.pageControl setCurrentPage:current];
    
    for (int i = 0; i < self.imagesArr.count; i++) {
            if (i != current){
            
                [UIView transitionWithView:[self.scrollView subviews][i] duration:3.0 options:0 animations:^{
                    
                } completion:^(BOOL finished) {
                    [scrollView subviews][i].frame = CGRectMake(self.scrollView.frame.size.width * (i) + HORMARGIN, VERMARGIN, self.scrollView.frame.size.width - HORMARGIN * 2, self.scrollView.frame.size.height - VERMARGIN * 2);
                }];
                
            }else{
                
                [scrollView subviews][i].transform = CGAffineTransformIdentity;
                [UIView animateWithDuration:0.4f animations:^{
                     [scrollView subviews][i].frame = CGRectMake(self.frame.size.width * (i) + LEFT, 0, self.frame.size.width - LEFT * 2, self.scrollView.frame.size.height);
                }];
            }
        }
    
}


@end
