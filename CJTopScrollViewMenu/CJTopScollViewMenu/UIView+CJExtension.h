//
//  UIView+CJExtension.h
//  CJTopScrollViewMenu
//
//  Created by 袁超杰 on 2017/6/26.
//  Copyright © 2017年 wangli.space. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (CJExtension)

@property (nonatomic ,assign) CGFloat CJ_x;
@property (nonatomic ,assign) CGFloat CJ_y;
@property (nonatomic ,assign) CGFloat CJ_width;
@property (nonatomic ,assign) CGFloat CJ_height;
@property (nonatomic ,assign) CGFloat CJ_centerX;
@property (nonatomic ,assign) CGFloat CJ_centerY;

@property (nonatomic ,assign) CGSize CJ_size;

@property (nonatomic, assign) CGFloat CJ_right;
@property (nonatomic, assign) CGFloat CJ_bottom;

+ (instancetype)CJ_viewFromXib;
/** 在分类中声明@property， 只会生成方法的声明， 不会生成方法的实现和带有_线成员变量 */

@end
