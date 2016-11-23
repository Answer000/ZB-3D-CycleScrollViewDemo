//
//  XIBViewController.m
//  ZB(3D)CycleScrollViewDemo
//
//  Created by 澳蜗科技 on 2016/11/22.
//  Copyright © 2016年 AnswerXu. All rights reserved.
//

#import "XIBViewController.h"
#import "ZB_3D_CycleScrollView.h"

@interface XIBViewController ()<ZB_3D_CycleScrollViewDelegate>
@property (weak, nonatomic) IBOutlet ZB_3D_CycleScrollView *xibCycleView;
@property (nonatomic,copy) NSMutableArray<NSString *> *urlImageNames;
@property (nonatomic,copy) NSMutableArray<NSString *> *titles;
@property (nonatomic,assign) CGFloat RValue;
@property (nonatomic,assign) CGFloat GValue;
@property (nonatomic,assign) CGFloat BValue;
@property (nonatomic,assign) NSInteger changBtnTag;


@end

#define KChangeColor   [UIColor colorWithRed:self.RValue green:self.GValue blue:self.BValue alpha:1]

@implementation XIBViewController
- (IBAction)changeColorBtn:(UIButton *)sender {
    self.changBtnTag = sender.tag;
}


- (IBAction)changeValue:(UISlider *)sender {
    switch (sender.tag) {
        case 1000:
            self.RValue = sender.value;
            break;
        case 1001:
            self.GValue = sender.value;
            break;
        case 1002:
            self.BValue = sender.value;
            break;
        default:
            break;
    }
    switch (self.changBtnTag) {
        case 2000:
            self.xibCycleView.titleLabelTextColor = KChangeColor;
            break;
        case 2001:
            self.xibCycleView.currentPageIndicatorTintColor = KChangeColor;
            break;
        case 2002:
            self.xibCycleView.pageIndicatorTintColor = KChangeColor;
            break;
        default:
            break;
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.changBtnTag = 2000;
    [self setupXIBCycleScrollView];
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


-(void)setupXIBCycleScrollView{
    self.xibCycleView.urlImageNames = self.urlImageNames;
    self.xibCycleView.titles = self.titles;
    self.xibCycleView.titleLabelAlignment = NSTextAlignmentCenter;
    self.xibCycleView.dirction = DirectionTop;
    self.xibCycleView.currentPageIndicatorTintColor = [UIColor blueColor];
    self.xibCycleView.pageIndicatorTintColor = [UIColor magentaColor];
    self.xibCycleView.delegate = self;
}

#pragma mark  ZB_3D_CycleScrollViewDelegate 代理方法
- (void)cycleScrollView:(ZB_3D_CycleScrollView *)cycleScrollView DidSelectItem:(NSInteger)indexPathItem{
    NSLog(@"点击%@-tag:%ld的第%ld张图片",NSStringFromClass([cycleScrollView class]),cycleScrollView.tag, indexPathItem);
}

#pragma mark-  销毁定时器
- (void)dealloc{
    NSLog(@"%s----%s",__FILE__,__func__);
//    [self.xibCycleView releaseTimer];
}


@end
