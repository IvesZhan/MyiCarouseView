//
//  RollView.h
//  MyiCarouselDemo
//
//  Created by Devin on 15/11/27.
//  Copyright © 2015年 Devin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <iCarousel.h>
@interface RollView : UIView

// 视图
@property (nonatomic, strong) UIView *rollView;

// 外界传入数据源数组
@property (nonatomic, strong) NSArray *dataArr;

@property (nonatomic, assign) iCarouselType type;

// 这个可有可无
@property (nonatomic, strong) UIPageControl *pageControl;


// 定义一个block属性,传出点击的index和dataArr
@property (nonatomic, strong) void (^clickAction)(NSInteger index, NSArray *dataArr);

@end
