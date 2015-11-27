//
//  RollView.m
//  MyiCarouselDemo
//
//  Created by Devin on 15/11/27.
//  Copyright © 2015年 Devin. All rights reserved.
//

#import "RollView.h"
#import <UIImageView+WebCache.h>
#import <iCarousel.h>

#define kRollWidth [UIScreen mainScreen].bounds.size.width

@interface RollView ()<iCarouselDataSource, iCarouselDelegate>

@property (nonatomic, strong) iCarousel *carousel;
@property (nonatomic, strong) NSTimer *timer;

@property (nonatomic, strong) UIImageView *backImageV;

@end

@implementation RollView

- (instancetype)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    if (self) {
        
        self.rollView = [[UIView alloc] initWithFrame:frame];

        // 初始化carousel并设置代理,数据源,和type
        self.carousel = [[iCarousel alloc] initWithFrame:self.rollView.bounds];
        
        self.carousel.delegate = self;
        self.carousel.dataSource = self;
        // 这个type我们在初始化的时候就随便给一个,这样即使我们不转动视图也可以显示背景图片
        self.carousel.type = iCarouselTypeInvertedWheel;
        self.carousel.scrollSpeed = 6;
        self.carousel.pagingEnabled = YES;
        [self.rollView addSubview:self.carousel];
        
        // 初始化pageControl
        self.pageControl = [[UIPageControl alloc] init];
        self.pageControl.numberOfPages = self.dataArr.count;
        self.pageControl.center = CGPointMake(self.rollView.center.x, self.rollView.bounds.size.height - 10);
        [self.rollView addSubview:self.pageControl];
        
        
        [self addSubview:self.rollView];
        
        
        // 这里我们设置一个背景图,并且插入在旋转图下方,在代理方法里面改变图片
        self.backImageV = [[UIImageView alloc] initWithFrame:frame];
        [self insertSubview:self.backImageV belowSubview:self.rollView];
        
        // 启动时就打开计时器,很多时候都用不上,就先关上
//        [self addTimer];
        
        
        // 毛玻璃效果
        UIBlurEffect *blur = [UIBlurEffect effectWithStyle:(UIBlurEffectStyleLight)];
        UIVisualEffectView *effectView = [[UIVisualEffectView alloc] initWithEffect:blur];
        effectView.frame = frame;
        effectView.alpha = 0.8;
    
        // 这里把毛玻璃效果放在对应的视图下方
        [self insertSubview:effectView belowSubview:self.rollView];
        
        
    }
    return self;
}

// 数据源传入的时候,需要刷新carousel
- (void)setDataArr:(NSArray *)dataArr{
    _dataArr = dataArr;
    
    self.pageControl.numberOfPages = dataArr.count;
    [self.carousel reloadData];
}
- (void)setType:(iCarouselType)type{
    
    _type = type;
    self.carousel.type = type;
}


#pragma mark ---delegate,datasource
// 下面是carousel的代理方法和数据源方法,根据每个方法名可以清晰的指导其作用
- (NSInteger)numberOfItemsInCarousel:(iCarousel *)carousel{
    
    return self.dataArr.count;
}
- (UIView *)carousel:(iCarousel *)carousel viewForItemAtIndex:(NSInteger)index reusingView:(UIView *)view{
    
    if (view == nil) {
        
        // 这里可以控制每张图的大小, 当然最好写在外部,方便我们调节
        UIImageView *imageV = [[UIImageView alloc] initWithFrame:(CGRectMake(0, 0, 200, 200))];
        
        imageV.contentMode = UIViewContentModeScaleAspectFit;
        NSString *str = self.dataArr[index];
        
        // 下面的判断是调用网络请求还是本地图片
        if ([str hasPrefix:@"http"]) {
            
            [imageV sd_setImageWithURL:[NSURL URLWithString:str] placeholderImage:[UIImage imageNamed:@"load.jpg"]];
        }else{
            
            imageV.image = [UIImage imageNamed:str];
        }
        
        view = imageV;
    }
    return view;
}
- (void)carousel:(iCarousel *)carousel didSelectItemAtIndex:(NSInteger)index{
    
    if (self.clickAction) {
        self.clickAction(index, self.dataArr);
    }
}
- (void)carouselDidScroll:(iCarousel *)carousel{
    
    self.pageControl.currentPage = carousel.currentItemIndex;
    
    UIImageView *imageV = (UIImageView *)self.carousel.currentItemView;
    
    self.backImageV.image = imageV.image;
    
}
- (void)carouselWillBeginDragging:(iCarousel *)carousel{
    
    //    [self removeTimer];
}
- (void)carouselDidEndDragging:(iCarousel *)carousel willDecelerate:(BOOL)decelerate{
    
    //    [self addTimer];
}


#pragma mark NSTimer计时器的使用
- (void)addTimer{
    
    self.timer = [NSTimer scheduledTimerWithTimeInterval:2.0 target:self selector:@selector(nextImage) userInfo:nil repeats:YES];
    
    [[NSRunLoop mainRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
}
- (void)nextImage{
    
    NSInteger index = self.carousel.currentItemIndex + 1;
    if (index == self.dataArr.count) {
        index = 0;
    }
    [self.carousel scrollToItemAtIndex:index animated:YES];
    
    UIImageView *imageV = (UIImageView *)self.carousel.currentItemView;
    
    self.backImageV.image = imageV.image;
}
- (void)removeTimer{
    
    [self.timer invalidate];
}



@end
