//
//  CJTopScrollMenu.h
//  CJTopScrollViewMenu
//
//  Created by 袁超杰 on 2017/6/26.
//  Copyright © 2017年 wangli.space. All rights reserved.
//

#import <UIKit/UIKit.h>
@class CJTopScrollMenu;

@protocol CJTopScrollMenuDelegate <NSObject>

- (void)CJTopScrollMenu:(CJTopScrollMenu *)topScrollMenu didSelectTitleAtIndex:(NSInteger)index;

@end

@interface CJTopScrollMenu : UIScrollView

/** 顶部标题数组 */
@property (nonatomic, strong) NSArray *titlesArr;
/** 存入所有Label */
@property (nonatomic, strong) NSMutableArray *allTitleLabel;

@property (nonatomic, weak) id<CJTopScrollMenuDelegate> topScrollMenuDelegate;


/** 类方法 */
+ (instancetype)topScrollMenuWithFrame:(CGRect)frame;


/** 选中label标题的标题颜色改变以及指示器位置变化（只是为了让外界去调用）*/
- (void)selectLabel:(UILabel *)label;

/** 选中的标题居中（只是为了让外界去调用）*/
- (void)setupTitleCenter:(UILabel *)centerLabel;

/** 选中时的label */
@property (nonatomic, strong) UILabel *selectedLabel;

@end
