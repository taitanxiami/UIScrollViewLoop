//
//  ViewController.m
//  UIScrollViewLoop
//
//  Created by apple on 15/7/30.
//  Copyright (c) 2015年 jimsay. All rights reserved.
//

#import "ViewController.h"
#import <Masonry.h>
#import <UIImageView+WebCache.h>
#import "SHCarouselView.h"

#define  kStartTag = 100
@interface ViewController ()<UIScrollViewDelegate,SHCarouseDelegate>


@property (nonatomic,strong) NSArray       *imageUrls;
@property (nonatomic,strong) SHCarouselView *carouseView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.imageUrls = @[[NSURL URLWithString:@"http://pic15.nipic.com/20110630/7862725_131816557150_2.jpg"],
                       [NSURL URLWithString:@"http://photos.tuchong.com/15432/f/826097.jpg"],[NSURL URLWithString:@"http://pic15.nipic.com/20110630/7862725_131816557150_2.jpg"],
                       [NSURL URLWithString:@"http://photos.tuchong.com/15432/f/826097.jpg"]];
    

    self.carouseView = [[SHCarouselView alloc]initWithFrame:CGRectMake(0, 300, CGRectGetWidth(self.view.bounds), 200)];
    self.carouseView.delegate  =self;
    self.carouseView.imageUrls = self.imageUrls;

    [self.carouseView initScrollView];
//    self.carouseView.timerInterval = 2.0f;
    [self.view addSubview:self.carouseView];
    
}
- (void)imagePlayerView:(SHCarouselView *)carouselView didTapAtIndex:(NSInteger)index {
    
    NSLog(@"%ld",index);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
