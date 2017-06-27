//
//  CJAllMenuView.m
//  CJTopScrollViewMenu
//
//  Created by 袁超杰 on 2017/6/26.
//  Copyright © 2017年 wangli.space. All rights reserved.
//

#import "CJAllMenuView.h"
#import "UIView+CJExtension.h"

#define labelFontOfSize [UIFont systemFontOfSize:16]
#define CJ_ScreenWidth [UIScreen mainScreen].bounds.size.width
#define MenusContentView_y 44
#define MenusContentView_height 200
static CGFloat const radio = 1.0;

@interface CJAllMenuView ()

@property (nonatomic, strong) UILabel *titleLabel;
/** 选中时的label */
@property (nonatomic, strong) UILabel *selectedLabel;

/**显示内容区域*/
 
@property (nonatomic,strong) UIScrollView * menusContentView;

@property (nonatomic,strong) UIImageView * downImage;
@property (nonatomic,strong) UIView * titleView;

@end

@implementation CJAllMenuView

- (NSMutableArray *)allTitleLabel {
    if (_allTitleLabel == nil) {
        _allTitleLabel = [NSMutableArray array];
    }
    return _allTitleLabel;
}
- (UIScrollView *)menusContentView{
    if (_menusContentView == nil) {
        _menusContentView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, MenusContentView_y, CJ_ScreenWidth, MenusContentView_height)];
        _menusContentView.backgroundColor = [UIColor whiteColor];
        [self addSubview:_menusContentView];
    }
    return _menusContentView;
}
- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor colorWithWhite:1.0 alpha:0.8];
        
        /* titleView */
        UIView * titleView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, CJ_ScreenWidth, 44)];
        titleView.backgroundColor = [UIColor whiteColor];
        
        UILabel * titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(15, 0, 36, 16)];
        titleLabel.font = labelFontOfSize;
        titleLabel.text = @"全部";
        titleLabel.CJ_centerY = titleView.CJ_centerY;
        [titleView addSubview:titleLabel];
        
        UIImage * image = [UIImage imageNamed:@"jshop_category_arrow_up"];
        UIImageView * downImage = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 44, 44)];
        downImage.image = image;
        downImage.contentMode = UIViewContentModeRight;
        downImage.CJ_right = titleView.CJ_right-15;
        [titleView addSubview:downImage];
        _downImage = downImage;
        
        UIView * line = [[UIView alloc]initWithFrame:CGRectMake(0, titleView.CJ_height-1, CJ_ScreenWidth, 1)];
        line.backgroundColor = [UIColor lightGrayColor];
        [titleView addSubview:line];
        
        [self addSubview:titleView];
        self.titleView = titleView;
    }
    return self;
}

+ (instancetype)allMenuViewWithFrame:(CGRect)frame{
    return [[self alloc]initWithFrame:frame];
}
- (void)setTitlesArr:(NSArray *)titlesArr{
    _titlesArr = titlesArr;
    // 固定字体大小 调整width
    [self layoutLabels:titlesArr withConstantFont:labelFontOfSize];
    // 固定width 调整字体大小
//    [self layoutLabels:titlesArr withConstansWidth:(CJ_ScreenWidth-4*15)/3.0];
    
}
// 固定字体大小 调整width
- (void)layoutLabels:(NSArray *)titlesArr withConstantFont:(UIFont *)font{
    __block CGFloat boradY = 15;
    __block CGFloat boradX = 15;
    __block CGFloat buttonHight = 26;
    __block CGFloat buttonX = 15;
    __block CGFloat buttonY = 15;
    
    [titlesArr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSString * title = obj;
        UILabel * munuLabel = [[UILabel alloc]init];
        munuLabel.font = font;
        munuLabel.text = title;
        munuLabel.textColor = [UIColor grayColor];
        munuLabel.highlightedTextColor = [UIColor whiteColor];
        munuLabel.textAlignment = NSTextAlignmentCenter;
        munuLabel.userInteractionEnabled = YES;
        munuLabel.layer.cornerRadius = 26/2.0;
        munuLabel.layer.masksToBounds = YES;
        munuLabel.backgroundColor = [UIColor groupTableViewBackgroundColor];
        munuLabel.tag = idx;
        
        CGSize size = [self sizeWithText:title font:font maxSize:CGSizeMake(MAXFLOAT, buttonHight)];
        CGFloat buttonWidth = size.width +10;
        if (buttonX + buttonWidth >CJ_ScreenWidth) {
            buttonY += (boradY +buttonHight);
            buttonX = boradX;
            munuLabel.frame = CGRectIntegral(CGRectMake(buttonX, buttonY, buttonWidth, buttonHight));// 高度为非整数的情况下 会造成右侧出现小竖线
            buttonX +=(boradX +buttonWidth);
        }else{
            munuLabel.frame = CGRectIntegral(CGRectMake(buttonX, buttonY, buttonWidth, buttonHight));
            buttonX +=(boradX +buttonWidth);
        }
        
        [self.allTitleLabel addObject:munuLabel];
        // 添加点按手势
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(titleClick:)];
        [munuLabel addGestureRecognizer:tap];
        [self.menusContentView addSubview:munuLabel];
    }];
    self.menusContentView.contentSize = CGSizeMake(CJ_ScreenWidth, buttonY +buttonHight+10);
}
 
// 固定width 调整字体大小
- (void)layoutLabels:(NSArray*)titlesArr withConstansWidth:(CGFloat)width{
    CGFloat boradY = 15;
    CGFloat boradX = 15;
    CGFloat buttonHight = 26;
    for (NSInteger i=0;i<titlesArr.count;i++) {
        UILabel * munuLabel = [[UILabel alloc]init];
        munuLabel.font = labelFontOfSize;
        munuLabel.text = titlesArr[i];
        munuLabel.textColor = [UIColor grayColor];
        munuLabel.highlightedTextColor = [UIColor whiteColor];
        munuLabel.textAlignment = NSTextAlignmentCenter;
        munuLabel.userInteractionEnabled = YES;
        munuLabel.layer.cornerRadius = 26/2.0;
        munuLabel.layer.masksToBounds = YES;
        munuLabel.adjustsFontSizeToFitWidth = YES;
        munuLabel.backgroundColor = [UIColor groupTableViewBackgroundColor];
        
        munuLabel.frame = CGRectMake(boradX +i%3*(width +boradX), boradY + i/3*(buttonHight +boradY), width, buttonHight);
        // 添加点按手势
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(titleClick:)];
        [munuLabel addGestureRecognizer:tap];
        [self.menusContentView addSubview:munuLabel];
    }
    self.menusContentView.contentSize = CGSizeMake(CJ_ScreenWidth, (titlesArr.count/3 +1)*(buttonHight+boradY) +boradY);
}
- (void)titleClick:(UITapGestureRecognizer *)tap{
    
    UILabel * selLabel = (UILabel *)tap.view;
    
    [self selectLabel:selLabel];
    
    NSInteger index = selLabel.tag;
    if ([self.allMenuDelegate respondsToSelector:@selector(CJAllMenuView:didSelectTitleAtIndex:)]) {
        [self.allMenuDelegate CJAllMenuView:self didSelectTitleAtIndex:index];
    }

    
}
/** 选中label标题颜色变成红色以及指示器位置 */
- (void)selectLabel:(UILabel *)label {
    // 取消高亮
    _selectedLabel.highlighted = NO;
    // 取消形变
    _selectedLabel.transform = CGAffineTransformIdentity;
    // 颜色恢复
    _selectedLabel.textColor = [UIColor grayColor];
    // 背景颜色恢复
    _selectedLabel.backgroundColor = [UIColor groupTableViewBackgroundColor];
    
    // 高亮
    label.highlighted = YES;
    // 形变
    label.transform = CGAffineTransformMakeScale(radio, radio);
    label.backgroundColor = [UIColor grayColor];
    
    _selectedLabel = label;
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
- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    CGPoint point = [[touches anyObject] locationInView:self];
    if (point.y > self.menusContentView.CJ_y) {
       self.hidden = YES;
        return;
    }
    point = [self.downImage.layer convertPoint:point fromLayer:self.layer];
    
    if ([self.downImage.layer containsPoint:point]) {
        self.hidden = YES;
        return;
    }
    
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
