//
//  ZhB_3D_RoolView.h
//  ZhB_3D_UnlimitedRool
//
//  Created by 澳蜗科技 on 16/7/16.
//  Copyright © 2016年 澳蜗科技. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ZB_3D_CycleScrollView;

/**
 *  轮播方向
 */
typedef enum : NSInteger {
    DirectionRight = 0,
    DirectionLeft,
    DirectionTop,
    DirectionBottom
} CycleScrollDirction;

/**
 *  点击图片代理
 */
@protocol ZB_3D_CycleScrollViewDelegate <NSObject>
- (void)cycleScrollView:(ZB_3D_CycleScrollView *)cycleScrollView DidSelectItem:(NSInteger)indexPathItem;
@end

@interface ZB_3D_CycleScrollView : UIView

/**
 *  用于存放轮播图片链接的数组
 */
@property (nonatomic,copy) NSArray<NSString *> *urlImageNames;
/**
 *  用于存放本地轮播图片的数组
 */
@property (nonatomic,copy) NSArray<NSString *> *localImageNames;
/**
 *  轮播间隔时间,默认3s(必须大于默认动画时间)
 */
@property (nonatomic,assign) NSTimeInterval timeInterval;
/**
 *  滚动方向
 */
@property (nonatomic,assign) CycleScrollDirction dirction;
/**
 *  用于存放标题的数组
 */
@property (nonatomic,copy) NSArray<NSString *> *titles;
/**
 *  titleLabel显示样式
 */
@property (nonatomic,assign) NSTextAlignment titleLabelAlignment;
/**
 *  titleLabel字体颜色
 */
@property (nonatomic,strong) UIColor *titleLabelTextColor;
/**
 *  titleLabel字体
 */
@property (nonatomic,strong) UIFont *titleLabelFont;


/**
 *  UIPageControl当前点的颜色
 */
@property (nonatomic,strong) UIColor *currentPageIndicatorTintColor;
/**
 *  UIPageControl其他点的颜色
 */
@property (nonatomic,strong) UIColor *pageIndicatorTintColor;
/**
 *  UIPageControl页数为1时，是否隐藏(默认不隐藏)
 */
@property (nonatomic,assign) BOOL hidesForSinglePage;
/**
 *  正常时候的动画时间,默认0.8s
 */
@property (nonatomic,assign) CGFloat animationTimeWhenDefault;
/**
 *  拖动时候的动画时间,默认0.5s
 */
@property (nonatomic,assign) CGFloat animationTimeWhenGrag;
/**
 *  定时器必须在当前控制器中销毁
 */
- (void)releaseTimer;
/**
 *  声明代理
 */
@property (nonatomic,weak) id<ZB_3D_CycleScrollViewDelegate> delegate;

@end
