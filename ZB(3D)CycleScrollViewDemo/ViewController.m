//
//  ViewController.m
//  ZB(3D)CycleScrollViewDemo
//
//  Created by 澳蜗科技 on 2016/11/21.
//  Copyright © 2016年 AnswerXu. All rights reserved.
//

#import "ViewController.h"
#import "ZB_3D_CycleScrollView.h"
#import "XIBViewController.h"

@interface ViewController ()<ZB_3D_CycleScrollViewDelegate>
@property (nonatomic,strong) ZB_3D_CycleScrollView *cycleScrollView;
@property (nonatomic,strong) ZB_3D_CycleScrollView *cycleScrollView2;
@property (nonatomic,copy) NSMutableArray<NSString *> *localImageNames;
@property (nonatomic,copy) NSMutableArray<NSString *> *urlImageNames;
@property (nonatomic,copy) NSMutableArray<NSString *> *titles;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.cycleScrollView];
    [self.view addSubview:self.cycleScrollView2];
}

#pragma mark  添加本地图片名字到数组
- (NSMutableArray *)localImageNames{
    if (!_localImageNames) {
        _localImageNames = [NSMutableArray array];
        for(NSInteger i=1;i<11;i++){
            [_localImageNames addObject:[NSString stringWithFormat:@"%ld.jpg",i]];
        }
    }
    return _localImageNames;
}
#pragma mark-  添加网络图片链接到数组
-(NSMutableArray<NSString *> *)urlImageNames{
    if (!_urlImageNames) {
        _urlImageNames = [NSMutableArray array];
        [_urlImageNames addObject:@"http://image.nbd.com.cn/uploads/articles/images/129396/3.x_large.jpg"];
        [_urlImageNames addObject:@"http://img1.cache.netease.com/catchpic/2/2D/2D364D5F3D9CEB8B2BBCF12C8990793A.jpg"];
        [_urlImageNames addObject:@"http://image.tianjimedia.com/uploadImages/upload/20150212/5drbkcecu34jpg.jpg"];
        [_urlImageNames addObject:@"http://img0w.pconline.com.cn/pconline/1503/01/spcgroup/width_640,qua_30/6159336_110717560.png"];
        [_urlImageNames addObject:@"http://img.25pp.com/ppnews/zixun_img/a16/45d/1425936355658384.jpg"];
        [_urlImageNames addObject:@"http://www.keke289.com/Uploads/upload/image/20151005/1444017205943479.jpg"];
        [_urlImageNames addObject:@"http://cdn2.bjweekly.com/news/image2/281/10800211306145030937.jpg"];
        [_urlImageNames addObject:@"http://www.qqtn.com/up/2015-3/201503061152539418242.png"];
    }
    return _urlImageNames;
}

-(NSMutableArray<NSString *> *)titles{
    if (!_titles) {
        _titles = [NSMutableArray array];
        for (NSInteger i=0; i<100; i++) {
            [_titles addObject:[NSString stringWithFormat:@"我是第%ld张轮播图",i]];
        }
    }
    return _titles;
}

- (ZB_3D_CycleScrollView *)cycleScrollView{
    if (!_cycleScrollView) {
        _cycleScrollView = [[ZB_3D_CycleScrollView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 200)];
        _cycleScrollView.urlImageNames = self.urlImageNames;
        _cycleScrollView.titles = self.titles;
        _cycleScrollView.tag = 1000;
        _cycleScrollView.titleLabelAlignment = NSTextAlignmentCenter;
        _cycleScrollView.currentPageIndicatorTintColor = [UIColor redColor];
        //轮播间隔时间必须大于默认动画时间
        _cycleScrollView.timeInterval = 3;
        _cycleScrollView.animationTimeWhenDefault = 0.5f;
        _cycleScrollView.animationTimeWhenGrag = 0.3f;
        _cycleScrollView.pageIndicatorTintColor = [UIColor cyanColor];
        _cycleScrollView.delegate = self;
    }
    return _cycleScrollView;
}

- (ZB_3D_CycleScrollView *)cycleScrollView2{
    if (!_cycleScrollView2) {
        _cycleScrollView2 = [[ZB_3D_CycleScrollView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.cycleScrollView.frame) + 50, self.view.bounds.size.width, 200)];
        _cycleScrollView2.localImageNames = self.localImageNames;
        _cycleScrollView2.titles = self.titles;
        _cycleScrollView2.tag = 2000;
        _cycleScrollView2.titleLabelAlignment = NSTextAlignmentCenter;
        _cycleScrollView2.dirction = DirectionLeft;
        _cycleScrollView2.currentPageIndicatorTintColor = [UIColor yellowColor];
        _cycleScrollView2.pageIndicatorTintColor = [UIColor purpleColor];
        _cycleScrollView2.titleLabelTextColor = [UIColor orangeColor];
        _cycleScrollView2.titleLabelFont = [UIFont boldSystemFontOfSize:20];
        _cycleScrollView2.delegate = self;
    }
    return _cycleScrollView2;
}



#pragma mark  ZB_3D_CycleScrollViewDelegate 代理方法
- (void)cycleScrollView:(ZB_3D_CycleScrollView *)cycleScrollView DidSelectItem:(NSInteger)indexPathItem{
    NSLog(@"点击%@-tag:%ld的第%ld张图片",NSStringFromClass([cycleScrollView class]),cycleScrollView.tag, indexPathItem);
    [self.navigationController pushViewController:[XIBViewController new] animated:YES];
}

@end
