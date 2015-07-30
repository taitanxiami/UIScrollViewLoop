//
//  SHCarouselView.m
//  UIScrollViewLoop
//
//  Created by apple on 15/7/30.
//  Copyright (c) 2015年 jimsay. All rights reserved.
//

#import "SHCarouselView.h"
#import <Masonry.h>
#import <UIImageView+WebCache.h>


@interface SHCarouselView ()<UIScrollViewDelegate>

@property (nonatomic) CGFloat viewHeight;

@end


@implementation SHCarouselView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
//        [self initCarouserViewWithFrame:frame];
    }
    return self;
}

- (void)initScrollView {
    
    self.scrollView = [[UIScrollView alloc]initWithFrame:self.frame];
    self.scrollView.backgroundColor = [UIColor orangeColor];
    self.scrollView.pagingEnabled = YES;
    self.scrollView.showsHorizontalScrollIndicator = NO;
    self.scrollView.showsVerticalScrollIndicator = NO;
    self.scrollView.delegate = self;
    self.scrollView.bounces = NO;
    self.scrollView.directionalLockEnabled = YES;
    [self addSubview:self.scrollView];
    
    [self.scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.top.bottom.and.right.equalTo(self);
        
    }];
    
    CGFloat width = CGRectGetWidth(self.frame);
    
    self.scrollView.contentSize = CGSizeMake(width * self.imageUrls.count, 200) ;
    
    for (int i = 0; i<self.imageUrls.count; i++) {
        
        UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(width * i, 0, width, 200)];
        imageView.userInteractionEnabled = YES;
        [imageView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTapGesture:)]];
        imageView.tag = 100 + i;
        [imageView sd_setImageWithURL:self.imageUrls[i] placeholderImage:nil];
        [self.scrollView addSubview:imageView];
        
    }
    
    
    [self configShadowView];
}
- (void)configShadowView {
    
    self.shadowView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 414, 30)];
    self.shadowView.backgroundColor = [UIColor blackColor];
    self.shadowView.alpha = 0.5;
    [self addSubview:self.shadowView];
    
    [self.shadowView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.bottom.and.right.equalTo(self);
        make.height.equalTo([NSNumber numberWithFloat:(40) ]);
    }];
    
    [self configPageControl];
}
- (void)configPageControl {
    
    self.pageControl = [[UIPageControl alloc]initWithFrame:CGRectMake(0, 0, 120, 40)];
    self.pageControl.numberOfPages = self.imageUrls.count;
    
    [self.shadowView addSubview:self.pageControl];
    
    [self.pageControl mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.and.bottom.equalTo(self.shadowView);
        make.right.equalTo(self.shadowView).offset(-16);
        
    }];
    
    [self configTimer];
}
- (void)configTimer {
    
    self.timer = [NSTimer scheduledTimerWithTimeInterval:2 target:self selector:@selector(fireTimer) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:_timer forMode:NSRunLoopCommonModes];
    
    
}
- (void)fireTimer {
    NSInteger currentPage = self.pageControl.currentPage;
    NSInteger nextPage = currentPage + 1;
    if (nextPage == self.imageUrls.count) {
        nextPage = 0;
    }
    
    BOOL animated = YES;
    if (nextPage == 0) {
        animated = NO;
    }
    
    UIImageView *imageView = (UIImageView *)[self.scrollView viewWithTag:(nextPage + 100)];
    [self.scrollView scrollRectToVisible:imageView.frame animated:animated];
    self.pageControl.currentPage = nextPage;
}

#pragma makr - UIScrollView delegate

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    //开始的时候，先关闭
    [self.timer setFireDate:[NSDate distantFuture]];
    
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    [self.timer setFireDate:[NSDate dateWithTimeIntervalSinceNow:2]];
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    CGPoint offsetPoint = scrollView.contentOffset;
    CGFloat ScreenWidth = [UIScreen mainScreen].bounds.size.width;
    _pageControl.currentPage = offsetPoint.x / ScreenWidth;
    
}
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    
}

- (void)handleTapGesture:(UIGestureRecognizer *)tapGesture {
    
    UIImageView *imageView = (UIImageView *)tapGesture.view;
    NSInteger index = imageView.tag - 100;
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(imagePlayerView:didTapAtIndex:)]) {
        [self.delegate imagePlayerView:self didTapAtIndex:index];
    }
}

#pragma mark - setter 方法
-(void)setImageUrls:(NSArray *)imageUrls {
    
    _imageUrls = imageUrls;
}
@end
