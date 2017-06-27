//
//  ViewController.m
//  CJTopScrollViewMenu
//
//  Created by 袁超杰 on 2017/6/26.
//  Copyright © 2017年 wangli.space. All rights reserved.
//
// 欢迎来Github上下载最完整的Demo
// Github下载地址 https://github.com/DeadRabbit2016/CJTopScrollViewMenu.git

#import "ViewController.h"
#import "CJTopScrollMenu.h"
#import "UIView+CJExtension.h"
#import "TestViewController.h"

#define AddButtonWidth 44

@interface ViewController ()<CJTopScrollMenuDelegate, UIScrollViewDelegate ,CJAllMenuViewDelegate>

@property (nonatomic, strong) CJTopScrollMenu *topScrollMenu;
@property (nonatomic, strong) UIScrollView * mainScrollView;
@property (nonatomic, strong) NSArray *titles;
@property (nonatomic,strong) UIButton * rightFoldButton;//右侧折叠按钮
@property (nonatomic,strong) CJAllMenuView * coverView;

@end

@implementation ViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithWhite:0.9 alpha:1.0];
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    self.titles = @[@"全部", @"投资类", @"职业类", @"商业银行类", @"税务类",
                    @"审计类", @"第三板", @"财务会计类", @"战略规划",@"咨询类",
                    @"风险控制类",@"法律风险",@"业务流程",@"证件考试",@"留学类",
                    @"语言学系",@"金融产品",@"IPO",@"税务策划",@"企业管控",
                    @"商业模式",@"并购重组",@"政策解读",@"饮食健康",@"职场分享",
                    @"工具方法",@"实务操作",@"作品介绍",@"子女教育",@"投资经验",
                    @"尽职调查",@"私募基金",@"财务报表",@"财务分析",@"互联网+",
                    @"人工智能",@"宏观经济",@"行业研究",@"四大会计师事务所",@"投资策略",
                    @"投资银行"];
    
    // 1.添加所有子控制器
    [self setupChildViewController];
    
    // 2.初始化topScrollMenu
    self.topScrollMenu = [CJTopScrollMenu topScrollMenuWithFrame:CGRectMake(0, 64, self.view.frame.size.width - AddButtonWidth, 44)];
    _topScrollMenu.titlesArr = [NSArray arrayWithArray:_titles];
    _topScrollMenu.topScrollMenuDelegate = self;
    [self.view addSubview:_topScrollMenu];
    
    // 3.添加右侧折叠按钮
    UIButton * foldButton = [UIButton buttonWithType:UIButtonTypeCustom];
    foldButton.frame = CGRectMake(self.topScrollMenu.CJ_right, 64, 44, 44);
    [foldButton setImage:[UIImage imageNamed:@"jshop_category_arrow_down"] forState:UIControlStateNormal];
    foldButton.backgroundColor = [UIColor colorWithWhite:1.0 alpha:0.9];
    foldButton.layer.shadowOffset = CGSizeMake(-2, 0);
    foldButton.layer.shadowColor = [UIColor lightGrayColor].CGColor;
    //    foldButton.layer.shadowRadius = 4;
    foldButton.layer.shadowOpacity = 1.0;
    [foldButton addTarget:self action:@selector(showAllMenus:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:foldButton];
    self.rightFoldButton = foldButton;
    
    // 4.添加被折叠的菜单
    CJAllMenuView * menuView = [CJAllMenuView allMenuViewWithFrame:CGRectMake(0, 64, self.view.CJ_width, self.view.CJ_height-64-49)];
    menuView.titlesArr = self.titles;
    menuView.allMenuDelegate = self;
//    UIWindow * window = [[[UIApplication sharedApplication] delegate]window];
//    [window addSubview:menuView];//[UIApplication sharedApplication].keyWindow addSubview有时会无效 返回的结果为nil
//    window.backgroundColor = [UIColor yellowColor];
//    [window bringSubviewToFront:menuView];
    [self.view addSubview:menuView];
    [self.view bringSubviewToFront:menuView];
    _coverView = menuView;
    _coverView.hidden = YES;
    
    // 5.创建底部滚动视图
    self.mainScrollView = [[UIScrollView alloc] init];
    _mainScrollView.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    _mainScrollView.contentSize = CGSizeMake(self.view.frame.size.width * _titles.count, 0);
    _mainScrollView.backgroundColor = [UIColor clearColor];
    // 开启分页
    _mainScrollView.pagingEnabled = YES;
    // 没有弹簧效果
    _mainScrollView.bounces = NO;
    // 隐藏水平滚动条
    _mainScrollView.showsHorizontalScrollIndicator = NO;
    // 设置代理
    _mainScrollView.delegate = self;
    [self.view addSubview:_mainScrollView];
    
    TestViewController *oneVC = [[TestViewController alloc] init];
    [self.mainScrollView addSubview:oneVC.view];
    
    [self.view insertSubview:_mainScrollView belowSubview:_topScrollMenu];
}
#pragma mark title 被点击时调用的代理方法
-(void)CJTopScrollMenu:(CJTopScrollMenu *)topScrollMenu didSelectTitleAtIndex:(NSInteger)index{
    // 1 计算滚动的位置
    CGFloat offsetX = index * self.view.frame.size.width;
    self.mainScrollView.contentOffset = CGPointMake(offsetX, 0);
    
    // 2.给对应位置添加对应子控制器
    [self showVc:index];
}
- (void)buttonClicked:(UIButton *)button{
    
}
// 添加所有子控制器
- (void)setupChildViewController {
    for (int i=0; i < self.titles.count; i++) {
        TestViewController *oneVC = [[TestViewController alloc] init];
        [self addChildViewController:oneVC];
        
    }
}

// 显示控制器的view
- (void)showVc:(NSInteger)index {
    CGFloat offsetX = index * self.view.frame.size.width;
    UIViewController *vc = self.childViewControllers[index];
    // 判断控制器的view有没有加载过,如果已经加载过,就不需要加载
    if (vc.isViewLoaded) return;
    [self.mainScrollView addSubview:vc.view];
    vc.view.frame = CGRectMake(offsetX, 0, self.view.frame.size.width, self.view.frame.size.height);
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

#pragma mark - CJAllMenuViewDelegate
#pragma mark title 右侧折叠按钮被点击时调用的代理方法
- (void)CJAllMenuView:(CJAllMenuView *)allMenuView didSelectTitleAtIndex:(NSInteger)index{
    [UIView animateWithDuration:0.1 animations:^{
        [_topScrollMenu selectLabel:_topScrollMenu.allTitleLabel[index]];
        _coverView.hidden = YES;
    }];
}
#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    
    // 计算滚动到哪一页
    NSInteger index = scrollView.contentOffset.x / scrollView.bounds.size.width;
    
    // 1.添加子控制器view
    [self showVc:index];
    
    // 2.把对应的标题选中
    [[NSNotificationCenter defaultCenter] postNotificationName:@"change" object:@(index) userInfo:nil];
    
    // 2.把对应的标题选中
    UILabel *selLabel = self.topScrollMenu.allTitleLabel[index];
    
    [self.topScrollMenu selectLabel:selLabel];
    
    // 3.让选中的标题居中
    [self.topScrollMenu setupTitleCenter:selLabel];
}

// 展示全部分类
- (void)showAllMenus:(UIButton *)button{
    UILabel * cuttentTopSelectLabel = self.topScrollMenu.selectedLabel;
    UILabel * munuSelectLabel = self.coverView.allTitleLabel[cuttentTopSelectLabel.tag];
    [_coverView selectLabel:munuSelectLabel];
    [UIView animateWithDuration:0.1 animations:^{
        _coverView.hidden = NO;
    }];
}

@end
