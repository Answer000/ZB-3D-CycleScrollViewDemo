//
//  ZhB_3D_RoolView.m
//  ZhB_3D_UnlimitedRool
//
//  Created by 澳蜗科技 on 16/7/16.
//  Copyright © 2016年 澳蜗科技. All rights reserved.
//

#import "ZB_3D_CycleScrollView.h"
#import "SDWebImageManager.h"
#import "UIImageView+WebCache.h"

@interface ZB_3D_CycleScrollView()<CAAnimationDelegate>
//展示图片的UIImageView
@property (nonatomic,strong) UIImageView *dispalyImageView;
//标题
@property (nonatomic,strong) UILabel *titleLable;
//UIPageControl
@property (nonatomic,strong) UIPageControl *pageControl;
//当前展示图片的下标
@property (nonatomic,assign) NSUInteger currentImg;
//0：自然滚动状态；1：右划；2：左划
@property (nonatomic,assign) NSInteger roolTag;
//定时器
@property (nonatomic,weak) NSTimer *timer;
//存放图片的数组
@property (nonatomic,strong) NSMutableArray<NSString *> *images;
//滑动手势
@property (nonatomic,strong) UISwipeGestureRecognizer *followGesture;
@property (nonatomic,strong) UISwipeGestureRecognizer *reverseGesture;
//顺方向
@property (nonatomic,assign) CycleScrollDirction followDirction;
//反方向
@property (nonatomic,assign) CycleScrollDirction reverseDirction;
//手势滑动方向
@property (nonatomic,assign) UISwipeGestureRecognizerDirection followRecongizerDireciton;
@property (nonatomic,assign) UISwipeGestureRecognizerDirection reverseRecongizerDireciton;
//动画已经停止的标记
@property (nonatomic,assign) BOOL animationDidStop;
//动画时间
@property (nonatomic,assign) CGFloat animationTime;

@end

#define KDefaultTimeInterval  2

@implementation ZB_3D_CycleScrollView

#pragma mark-  懒加载
-(NSMutableArray<NSString *> *)images{
    if (!_images) {
        _images = [NSMutableArray array];
    }
    return _images;
}

-(UIImageView *)dispalyImageView{
    if (!_dispalyImageView) {
        _dispalyImageView = [[UIImageView alloc] initWithFrame:CGRectZero];
    }
    return _dispalyImageView;
}

-(UIPageControl *)pageControl{
    if (!_pageControl) {
        _pageControl = [[UIPageControl alloc] initWithFrame:CGRectZero];
    }
    return _pageControl;
}

-(UISwipeGestureRecognizer *)followGesture{
    if (!_followGesture) {
        _followGesture = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(followDirctionSwipe)];
        [self addGestureRecognizer:_followGesture];
    }
    return _followGesture;
}
-(UISwipeGestureRecognizer *)reverseGesture{
    if (!_reverseGesture) {
        _reverseGesture = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(reverseDirctionSwipe)];
        [self addGestureRecognizer:_reverseGesture];
    }
    return _reverseGesture;
}

-(NSTimer *)timer{
    if (!_timer) {
        _timer = [NSTimer scheduledTimerWithTimeInterval:_timeInterval > 0 ? _timeInterval : KDefaultTimeInterval target:self selector:@selector(fire:) userInfo:nil repeats:YES];
        [[NSRunLoop mainRunLoop] addTimer:_timer forMode:NSRunLoopCommonModes];
    }
    return _timer;
}

-(UILabel *)titleLable{
    if (!_titleLable) {
        _titleLable = [[UILabel alloc] initWithFrame:CGRectZero];
    }
    return _titleLable;
}

#pragma mark-  xib
-(void)awakeFromNib{
    [super awakeFromNib];
    [self setupSubviews];
}

#pragma mark-  init方法
-(instancetype)init{
    if (self = [super init]) {
        [self setupSubviews];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupSubviews];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame urlImageNames:(NSArray<NSString *> *)urlImageNames{
    self = [super initWithFrame:frame];
    if (self) {
        self.images = [urlImageNames copy];
        [self setupSubviews];
    }
    return self;
}

#pragma mark-  init方法
- (instancetype)initWithFrame:(CGRect)frame localImageNames:(NSArray<NSString *> *)localImageNames{
    self = [super initWithFrame:frame];
    if (self) {
        self.images = [localImageNames copy];
        [self setupSubviews];
    }
    return self;
}

-(void)setupSubviews{
    self.dirction = DirectionRight;
    self.currentImg = 0;
    self.animationDidStop = YES;
    self.animationTimeWhenDefault = 0.8f;
    self.animationTimeWhenGrag = 0.5f;
}

-(void)layoutSubviews{
    [self setupSubviewsForFrame];
    [self addSubview:self.dispalyImageView];
    [self.dispalyImageView addSubview:self.titleLable];
    [self addSubview:self.pageControl];
    [self addFollowDirctionSwipeGesture];
    [self addReverseDirctionSwipeGesture];
    [self timer];
}

-(void)setupSubviewsForFrame{
    self.animationTime = self.animationTimeWhenDefault;
    self.dispalyImageView.frame = self.bounds;
    self.titleLable.center = CGPointMake(self.bounds.size.width/2, self.bounds.size.height - 50);
    self.titleLable.bounds = CGRectMake(0, 0, self.bounds.size.width - 20, 30);
    self.pageControl.center = CGPointMake(self.bounds.size.width/2, self.bounds.size.height - 20);
    self.pageControl.bounds = CGRectMake(0, 0, self.bounds.size.width, 10);
}

#pragma mark-  set方法
-(void)setUrlImageNames:(NSArray<NSString *> *)urlImageNames{
    _urlImageNames = urlImageNames;
    self.images = [urlImageNames copy];
    [self setImageView];
}

-(void)setLocalImageNames:(NSArray<NSString *> *)localImageNames{
    _localImageNames = localImageNames;
    self.images = [localImageNames copy];
    [self setImageView];
}

-(void)setTitleLabelAlignment:(NSTextAlignment)titleLabelAlignment{
    _titleLabelAlignment = titleLabelAlignment;
    self.titleLable.textAlignment = titleLabelAlignment;
}

-(void)setTitleLabelTextColor:(UIColor *)titleLabelTextColor{
    _titleLabelTextColor = titleLabelTextColor;
    self.titleLable.textColor = titleLabelTextColor;
}

-(void)setTitleLabelFont:(UIFont *)titleLabelFont{
    _titleLabelFont = titleLabelFont;
    self.titleLable.font = titleLabelFont;
}

-(void)setTitles:(NSArray<NSString *> *)titles{
    _titles = titles;
    self.titleLable.text = titles.firstObject;
}

-(void)setCurrentPageIndicatorTintColor:(UIColor *)currentPageIndicatorTintColor{
    _currentPageIndicatorTintColor = currentPageIndicatorTintColor;
    self.pageControl.currentPageIndicatorTintColor = currentPageIndicatorTintColor;
}

-(void)setPageIndicatorTintColor:(UIColor *)pageIndicatorTintColor{
    _pageIndicatorTintColor = pageIndicatorTintColor;
    self.pageControl.pageIndicatorTintColor = pageIndicatorTintColor;
}

-(void)setHidesForSinglePage:(BOOL)hidesForSinglePage{
    _hidesForSinglePage = hidesForSinglePage;
    self.pageControl.hidesForSinglePage = hidesForSinglePage;
}

-(void)setAnimationTimeWhenGrag:(CGFloat)animationTimeWhenGrag{
    _animationTimeWhenGrag = animationTimeWhenGrag;
}

-(void)setAnimationTimeWhenDefault:(CGFloat)animationTimeWhenDefault{
    _animationTimeWhenDefault = animationTimeWhenDefault;
}

- (void)setImageView{
    if ([self.images.firstObject containsString:@"http://"] || [self.images.firstObject containsString:@"https://"]) {
        [self.dispalyImageView sd_setImageWithURL:[NSURL URLWithString:self.images.firstObject] placeholderImage:_placeholderImage ? _placeholderImage : [UIImage imageNamed:@"loadFail.jpg"]];
    }else{
        self.dispalyImageView.image = [UIImage imageNamed:self.images.firstObject];
    }
    self.dispalyImageView.userInteractionEnabled = YES;
    self.pageControl.numberOfPages = self.images.count;
    //添加点击手势
    [self.dispalyImageView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(cycleScrollViewDidSelectedItem)]];
}

-(void)setDirction:(CycleScrollDirction)dirction{
    _dirction = dirction;
    self.followDirction = dirction;
    switch (dirction) {
        case DirectionLeft:
            self.reverseDirction = DirectionRight;
            self.followRecongizerDireciton = UISwipeGestureRecognizerDirectionRight;
            self.reverseRecongizerDireciton = UISwipeGestureRecognizerDirectionLeft;
            break;
        case DirectionRight:
            self.reverseDirction = DirectionLeft;
            self.followRecongizerDireciton = UISwipeGestureRecognizerDirectionLeft;
            self.reverseRecongizerDireciton = UISwipeGestureRecognizerDirectionRight;
            break;
        case DirectionTop:
            self.reverseDirction = DirectionBottom;
            self.followRecongizerDireciton = UISwipeGestureRecognizerDirectionDown;
            self.reverseRecongizerDireciton = UISwipeGestureRecognizerDirectionUp;
            break;
        case DirectionBottom:
            self.reverseDirction = DirectionTop;
            self.followRecongizerDireciton = UISwipeGestureRecognizerDirectionUp;
            self.reverseRecongizerDireciton = UISwipeGestureRecognizerDirectionDown;
            break;
        default:
            break;
    }
}

#pragma mark  添加顺方向滑动手势
- (void)addFollowDirctionSwipeGesture{
    self.followGesture.direction = self.followRecongizerDireciton;
}
#pragma mark  顺方向滑动手势触发方法
- (void)followDirctionSwipe{
    self.animationTime = self.animationTimeWhenGrag;
    [self setFollowDirctionSwipeCurrentImg];
    self.roolTag = 2;
    //暂停定时器
    [self suspendTimer:self.timer];
    [self addAnimationWithDirction:self.reverseDirction];
}
- (void)setFollowDirctionSwipeCurrentImg{
    if (_currentImg  == 0) {
        _currentImg = _images.count - 1;
    }else{
        _currentImg --;
    }
}
#pragma mark  反方向滑动手势
- (void)addReverseDirctionSwipeGesture{
    self.reverseGesture.direction = self.reverseRecongizerDireciton;
}
#pragma mark  反方向滑动触发方法
- (void)reverseDirctionSwipe{
    self.animationTime = self.animationTimeWhenGrag;
    [self setReverseDirctionSwipeCurrentImg];
    self.roolTag = 1;
    //暂停定时器
    [self suspendTimer:self.timer];
    [self addAnimationWithDirction:self.followDirction];
}

- (void)setReverseDirctionSwipeCurrentImg{
    if (_currentImg  == _images.count - 1) {
        _currentImg = 0;
    }else{
        _currentImg ++;
    }
}

//定时器重复执行方法
- (void)fire:(NSTimer *)timer{
    if (self) {
        if (_currentImg  == _images.count - 1) {
            _currentImg = 0;
        }else{
            _currentImg ++;
        }
        //开启定时器
        [self addAnimationWithDirction:self.dirction];
    }else{
        //关闭定时器
        [_timer invalidate];
        _timer = nil;
    }
}

#pragma mark  转场动画
- (void)addAnimationWithDirction:(CycleScrollDirction)dirction{
    if (!self.animationDidStop) {
        return;
    }
    if(_currentImg < self.images.count){
        if ([self.images[_currentImg] containsString:@"http://"] || [self.images[_currentImg] containsString:@"https://"]) {
            [self.dispalyImageView sd_setImageWithURL:[NSURL URLWithString:self.images[_currentImg]] placeholderImage:[UIImage imageNamed:@"loadFail.jpg"]];
        }else{
            self.dispalyImageView.image = [UIImage imageNamed:self.images[_currentImg]];
        }
        self.titleLable.text = self.titles[_currentImg];
        self.pageControl.currentPage = _currentImg;
        [self setupSwipeDirction:dirction];
    }
}

- (void)setupSwipeDirction:(CycleScrollDirction)dirction{
    self.animationDidStop = NO;
    switch (dirction) {
        case DirectionLeft:
            [self setTransactionWithDirction:kCATransitionFromRight];
            break;
        case DirectionRight:
            [self setTransactionWithDirction:kCATransitionFromLeft];
            break;
        case DirectionTop:
            [self setTransactionWithDirction:kCATransitionFromTop];
            break;
        case DirectionBottom:
            [self setTransactionWithDirction:kCATransitionFromBottom];
            break;
        default:
            break;
    }
}

#pragma mark   设置转场动画
- (CATransition *)setTransactionWithDirction:(NSString *)subType{
    CATransition *transAnimation = [[CATransition alloc] init];
    transAnimation.type = @"cube";
    transAnimation.delegate = self;
    transAnimation.duration = self.animationTime;
    transAnimation.subtype = subType;
    [self.dispalyImageView.layer addAnimation:transAnimation forKey:@"KCTransitionAnimation"];
    return transAnimation;
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag{
    //继续定时器
    [self continueTimer:self.timer];
    self.animationDidStop = YES;
    self.animationTime = self.animationTimeWhenDefault;
}

#pragma  mark  点击手势实现方法
- (void)cycleScrollViewDidSelectedItem{
    //设置代理
    if ([self.delegate respondsToSelector:@selector(cycleScrollView:DidSelectItem:)]) {
        [self.delegate cycleScrollView:self DidSelectItem:_currentImg];
    }
}

#pragma mark-  解决拖动手势冲突问题
-(void)setLowPriorityWithGesture:(UIGestureRecognizer *)gesture{
    [gesture requireGestureRecognizerToFail:self.followGesture];
    [gesture requireGestureRecognizerToFail:self.reverseGesture];
}

#pragma mark  暂停计时器
- (void)suspendTimer:(NSTimer *)timer{
    [timer setFireDate:[NSDate distantFuture]];
}
#pragma mark  继续定时器
- (void)continueTimer:(NSTimer *)timer{
    [timer setFireDate:[NSDate dateWithTimeIntervalSinceNow:_timeInterval > 0 ? _timeInterval : KDefaultTimeInterval]];
}
#pragma mark   释放定时器
- (void)releaseTimer{
    [self.timer invalidate];
    self.timer = nil;
}
#pragma mark   解决当父视图被释放时，当前视图因被_timer强引用而无法释放问题
-(void)willMoveToSuperview:(UIView *)newSuperview{
    if (!newSuperview) {
        [self releaseTimer];
    }
}

@end
