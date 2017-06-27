//
//  UIView+CJExtension.m
//  CJTopScrollViewMenu
//
//  Created by 袁超杰 on 2017/6/26.
//  Copyright © 2017年 wangli.space. All rights reserved.
//

#import "UIView+CJExtension.h"

@implementation UIView (CJExtension)
- (void)setCJ_x:(CGFloat)CJ_x{
    CGRect frame = self.frame;
    frame.origin.x = CJ_x;
    self.frame = frame;
}

- (void)setCJ_y:(CGFloat)CJ_y{
    CGRect frame = self.frame;
    frame.origin.y = CJ_y;
    self.frame = frame;
}

- (void)setCJ_width:(CGFloat)CJ_width{
    CGRect frame = self.frame;
    frame.size.width = CJ_width;
    self.frame = frame;
}

- (void)setCJ_height:(CGFloat)CJ_height{
    CGRect frame = self.frame;
    frame.size.height = CJ_height;
    self.frame = frame;
}

- (CGFloat)CJ_x{
    return self.frame.origin.x;
}

- (CGFloat)CJ_y{
    return self.frame.origin.y;
}

- (CGFloat)CJ_width{
    return self.frame.size.width;
}

- (CGFloat)CJ_height{
    return self.frame.size.height;
}

- (CGFloat)CJ_centerX{
    return self.center.x;
}
- (void)setCJ_centerX:(CGFloat)CJ_centerX{
    CGPoint center = self.center;
    center.x = CJ_centerX;
    self.center = center;
}

- (CGFloat)CJ_centerY{
    return self.center.y;
}
- (void)setCJ_centerY:(CGFloat)CJ_centerY{
    CGPoint center = self.center;
    center.y = CJ_centerY;
    self.center = center;
}

- (void)setCJ_size:(CGSize)CJ_size{
    CGRect frame = self.frame;
    frame.size = CJ_size;
    self.frame = frame;
}
- (CGSize)CJ_size{
    return self.frame.size;
}


- (CGFloat)CJ_right{
    //    return self.CJ_x + self.CJ_width;
    return CGRectGetMaxX(self.frame);
}
- (CGFloat)CJ_bottom{
    //    return self.CJ_y + self.CJ_height;
    return CGRectGetMaxY(self.frame);
}

- (void)setCJ_right:(CGFloat)CJ_right{
    self.CJ_x = CJ_right - self.CJ_width;
}
- (void)setCJ_bottom:(CGFloat)CJ_bottom{
    self.CJ_y = CJ_bottom - self.CJ_height;
}

+ (instancetype)CJ_viewFromXib {
    return [[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil].lastObject;
}
@end
