//
//  CJAllMenuView.h
//  CJTopScrollViewMenu
//
//  Created by 袁超杰 on 2017/6/26.
//  Copyright © 2017年 wangli.space. All rights reserved.
//
// 欢迎来Github上下载最完整的Demo
// Github下载地址 https://github.com/DeadRabbit2016/CJTopScrollViewMenu.git

#import <UIKit/UIKit.h>
@class CJAllMenuView;

@protocol CJAllMenuViewDelegate <NSObject>

- (void)CJAllMenuView:(CJAllMenuView *)allMenuView didSelectTitleAtIndex:(NSInteger)index;

@end

@interface CJAllMenuView : UIView

/**标题数组*/
@property (nonatomic,strong) NSArray * titlesArr;

/** 存入所有Label */
@property (nonatomic, strong) NSMutableArray *allTitleLabel;

@property (nonatomic, weak) id<CJAllMenuViewDelegate> allMenuDelegate;

/** 选中label标题的标题颜色改变（只是为了让外界去调用）*/
- (void)selectLabel:(UILabel *)label;

+ (instancetype)allMenuViewWithFrame:(CGRect)frame;

@end
