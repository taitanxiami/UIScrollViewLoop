//
//  SHCarouselView.h
//  UIScrollViewLoop
//
//  Created by apple on 15/7/30.
//  Copyright (c) 2015年 jimsay. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SHCarouseDelegate;

@interface SHCarouselView : UIView

@property (nonatomic,strong) UIView        *shadowView;
@property (nonatomic,strong) NSArray       *imageUrls;
@property (nonatomic,strong) UIScrollView  *scrollView;
@property (nonatomic,strong) UIPageControl *pageControl;
@property (nonatomic,strong) NSTimer       * timer;
@property (nonatomic) NSTimeInterval timerInterval;
@property (nonatomic,assign) id<SHCarouseDelegate> delegate;
//初始化方法
- (void)initScrollView;

@end

@protocol SHCarouseDelegate <NSObject>

@optional

- (void)imagePlayerView:(SHCarouselView *)carouselView didTapAtIndex:(NSInteger)index;


@end
