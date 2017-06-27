//
//  CJTopScrollMenu.m
//  CJTopScrollViewMenu
//
//  Created by 袁超杰 on 2017/6/26.
//  Copyright © 2017年 wangli.space. All rights reserved.
//

#import "CJTopScrollMenu.h"
#import "UIView+CJExtension.h"

#define labelFontOfSize [UIFont systemFontOfSize:17]
#define CJ_ScreenWidth [UIScreen mainScreen].bounds.size.width

@interface CJTopScrollMenu ()

@property (nonatomic, strong) UILabel *titleLabel;

/** 指示器 */
@property (nonatomic, strong) UIView *indicatorView;

@end
@implementation CJTopScrollMenu

/** label之间的间距 */
static CGFloat const labelMargin = 15;
/** 指示器的高度 */
static CGFloat const indicatorHeight = 3;
/** 形变的度数 */
static CGFloat const radio = 1.0;

- (NSMutableArray *)allTitleLabel {
    if (_allTitleLabel == nil) {
        _allTitleLabel = [NSMutableArray array];
    }
    return _allTitleLabel;
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor colorWithWhite:1.0 alpha:0.9];
        self.showsHorizontalScrollIndicator = NO;
        self.bounces = NO;
    }
    return self;
}

+ (instancetype)topScrollMenuWithFrame:(CGRect)frame {
    return [[self alloc] initWithFrame:frame];
}


/**
 *  计算文字尺寸
 *
 *  @param text    需要计算尺寸的文字
 *  @param font    文字的字体
 *  @param maxSize 文字的最大尺寸
 */
- (CGSize)sizeWithText:(NSString *)text font:(UIFont *)font maxSize:(CGSize)maxSize {
    NSDictionary *attrs = @{NSFontAttributeName : font};
    return [text boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:attrs context:nil].size;
}

- (void)setTitlesArr:(NSArray *)titlesArr {
    _titlesArr = titlesArr;
    
    /** 创建标题Label */
    CGFloat labelX = 0;
    CGFloat labelY = 0;
    CGFloat labelH = self.frame.size.height - indicatorHeight;
    
    for (NSUInteger i = 0; i < self.titlesArr.count; i++) {
        self.titleLabel = [[UILabel alloc] init];
        _titleLabel.userInteractionEnabled = YES;
        _titleLabel.text = self.titlesArr[i];
        // 设置高亮文字颜色
        _titleLabel.highlightedTextColor = [UIColor redColor];
        
        _titleLabel.tag = i;
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        
        // 计算内容的Size
        CGSize labelSize = [self sizeWithText:_titleLabel.text font:labelFontOfSize maxSize:CGSizeMake(MAXFLOAT, labelH)];
        // 计算内容的宽度
        CGFloat labelW = labelSize.width + 2 * labelMargin;
        
        _titleLabel.frame = CGRectMake(labelX, labelY, labelW, labelH);
        
        // 计算每个label的X值
        labelX = labelX + labelW;
        
        // 添加到titleLabels数组
        [self.allTitleLabel addObject:_titleLabel];
        
        // 添加点按手势
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(titleClick:)];
        [_titleLabel addGestureRecognizer:tap];
        
        // 默认选中第0个label
        if (i == 0) {
            [self titleClick:tap];
        }
        
        [self addSubview:_titleLabel];
    }
    
    // 计算scrollView的宽度
    CGFloat scrollViewWidth = CGRectGetMaxX(self.subviews.lastObject.frame);
    self.contentSize = CGSizeMake(scrollViewWidth, self.frame.size.height);
    
    // 取出第一个子控件
    UILabel *firstLabel = self.subviews.firstObject;
    
    // 添加指示器
    self.indicatorView = [[UIView alloc] init];
    _indicatorView.backgroundColor = [UIColor redColor];
    _indicatorView.CJ_height = indicatorHeight;
    _indicatorView.CJ_y = self.frame.size.height - indicatorHeight;
    [self addSubview:_indicatorView];
    
    
    // 立刻根据文字内容计算第一个label的宽度
    _indicatorView.CJ_width = firstLabel.CJ_width - 2 * labelMargin;
    _indicatorView.CJ_centerX = firstLabel.CJ_centerX;
}

#pragma mark - - - Label的点击事件
- (void)titleClick:(UITapGestureRecognizer *)tap {
    // 0.获取选中的label
    UILabel *selLabel = (UILabel *)tap.view;
    
    // 1.标题颜色变成红色,设置高亮状态下的颜色， 以及指示器位置
    [self selectLabel:selLabel];
    
    // 2.让选中的标题居中
    [self setupTitleCenter:selLabel];
    
    
    NSInteger index = selLabel.tag;
    if ([self.topScrollMenuDelegate respondsToSelector:@selector(CJTopScrollMenu:didSelectTitleAtIndex:)]) {
        [self.topScrollMenuDelegate CJTopScrollMenu:self didSelectTitleAtIndex:index];
    }
}

/** 选中label标题颜色变成红色以及指示器位置 */
- (void)selectLabel:(UILabel *)label {
    // 取消高亮
    _selectedLabel.highlighted = NO;
    // 取消形变
    _selectedLabel.transform = CGAffineTransformIdentity;
    // 颜色恢复
    _selectedLabel.textColor = [UIColor blackColor];
    
    // 高亮
    label.highlighted = YES;
    // 形变
    label.transform = CGAffineTransformMakeScale(radio, radio);
    
    _selectedLabel = label;
    
    // 改变指示器位置
    [UIView animateWithDuration:0.20 animations:^{
        self.indicatorView.CJ_width = label.CJ_width - 2 * labelMargin;
        self.indicatorView.CJ_centerX = label.CJ_centerX;
    }];
}

/** 设置选中的标题居中 */
- (void)setupTitleCenter:(UILabel *)centerLabel {
    // 计算偏移量
    CGFloat offsetX = centerLabel.center.x - CJ_ScreenWidth * 0.5;
    
    if (offsetX < 0) offsetX = 0;
    
    // 获取最大滚动范围
    CGFloat maxOffsetX = self.contentSize.width - CJ_ScreenWidth + 44;
    
    if (offsetX > maxOffsetX) offsetX = maxOffsetX;
    
    // 滚动标题滚动条
    [self setContentOffset:CGPointMake(offsetX, 0) animated:YES];
}


@end
