//
//  ViewController.m
//  MyiCarouselDemo
//
//  Created by Devin on 15/11/27.
//  Copyright © 2015年 Devin. All rights reserved.
//

#import "ViewController.h"
#import <iCarousel.h>
#import "RollView.h"

#define kScreenWidth [UIScreen mainScreen].bounds.size.width
#define kScreenHeight [UIScreen mainScreen].bounds.size.height

@interface ViewController ()

@property (nonatomic, strong) RollView *rollView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 初始化rollView并设置属性
    self.rollView = [[RollView alloc] initWithFrame:(CGRectMake(0, 0, kScreenWidth, kScreenHeight))];
    
    //模拟网络请求,这里是用网络下载的图片,方便起见,我们注释掉,有需要可以打开,不过网络图片和本地图片不可同时进行,必须注释一个
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        //        NSString *s1 = @"http://img4.duitang.com/uploads/item/201409/07/20140907092042_nAGzk.thumb.700_0.jpeg";
        //        NSString *s2 = @"http://img5.duitang.com/uploads/item/201408/12/20140812170146_AGvzn.jpeg";
        //        NSString *s3 = @"http://img4q.duitang.com/uploads/item/201408/06/20140806174038_he5Fc.jpeg";
        
        
        //        NSArray *array = @[s1,s2,s3];
//        self.rollView.dataArr = array;
    });
    
    // 这里我们直接用本地图片进行模拟
    self.rollView.dataArr = @[@"0.jpg", @"1.jpg", @"2.jpg", @"3.jpg", @"5.jpg", @"6.jpg", @"7.jpg", @"8.jpg", @"9.jpg", @"10.jpg"];

    // 这里修改样式,type是一个枚举类型
    self.rollView.type = iCarouselTypeRotary;
    
    self.rollView.pageControl.pageIndicatorTintColor = [UIColor blackColor];
    self.rollView.pageControl.currentPageIndicatorTintColor = [UIColor orangeColor];
    
    [self.view addSubview:self.rollView];
    
    // 这里是一个block,当我们点击显示在视图中间的图片时,给我们返回对应的下标,这个接口就是我们以后把此类库用在其他项目中的对外接口
    self.rollView.clickAction = ^(NSInteger index, NSArray *dataArr){
        NSLog(@"%zd", index);
    };

}



@end
