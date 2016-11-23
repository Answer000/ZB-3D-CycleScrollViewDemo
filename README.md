# ZB-3D-CycleScrollViewDemo

### 框架作用
 * 实现3D无限轮播效果，可加载本地图片和网络图片
 * https://github.com/AnswerXu/ZB-3D-CycleScrollViewDemo.git
 
### 图文详情
 ![image]()
 
### 使用方法
 * 手动导入(暂不支持cocoapods导入):将ZB(3D)CycleScrollView文件夹拖入工程后声明ZB_3D_CycleScrollView.h头文件即可
 
 * 代码创建
```Objc
- (ZB_3D_CycleScrollView *)cycleScrollView{
    if (!_cycleScrollView) {
        _cycleScrollView = [[ZB_3D_CycleScrollView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 200)];
        //设置网络图片数组
        _cycleScrollView.urlImageNames = self.urlImageNames;
        //设置本地图片数组
        //_cycleScrollView.localImageNames = self.localImageNames;
        //设置标题数组
        _cycleScrollView.titles = self.titles;
        //设置标题填充样式
        _cycleScrollView.titleLabelAlignment = NSTextAlignmentCenter;
        //设置标题字体
        _cycleScrollView.titleLabelFont = [UIFont boldSystemFontOfSize:20];
        //设置轮播方向：Right，Left，Top，Bottom
        _cycleScrollView2.dirction = DirectionLeft;
        //轮播间隔时间:必须大于默认动画时间
        _cycleScrollView.timeInterval = 3;
        //默认动画时间
        _cycleScrollView.animationTimeWhenDefault = 0.5f;
        //拖动时的动画时间
        _cycleScrollView.animationTimeWhenGrag = 0.3f;
         //设置UIPageControl当前页的颜色
        _cycleScrollView.currentPageIndicatorTintColor = [UIColor redColor];
        //设置其他页的颜色
        _cycleScrollView.pageIndicatorTintColor = [UIColor cyanColor];
        //设置代理
        _cycleScrollView.delegate = self;
    }
    return _cycleScrollView;
}
```

```Objc 
//点击触发代理方法
- (void)cycleScrollView:(ZB_3D_CycleScrollView *)cycleScrollView DidSelectItem:(NSInteger)indexPathItem{
    NSLog(@"点击%@-tag:%ld的第%ld张图片",NSStringFromClass([cycleScrollView class]),cycleScrollView.tag, indexPathItem);
}

```

### 

	   谢谢支持，可能还有很多不完善的地方，期待您的建议！如果有帮到您，请不吝follow，您的支持与鼓励是我继续前行的动力。
	   邮箱：zhengbo073017@163.com

