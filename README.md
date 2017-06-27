## 效果图
![](https://github.com/DeadRabbit2016/CJTopScrollViewMenu/blob/master/GIF/CJTopScrollMenu.gif)

##代码介绍
* 将项目中 CJTopScollViewMenu 文件夹导入工程
* 导入 #import "CJTopScrollMenu.h" 头文件

#### 使用举例
```Objective-C 
    //1.初始化topScrollMenu
    self.topScrollMenu = [CJTopScrollMenu topScrollMenuWithFrame:CGRectMake(0, 64, self.view.frame.size.width - AddButtonWidth, 44)];
    _topScrollMenu.titlesArr = [NSArray arrayWithArray:_titles];
    _topScrollMenu.topScrollMenuDelegate = self;
    [self.view addSubview:_topScrollMenu];
    
    // 2.添加右侧折叠按钮
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

```

#### 代理方法
```Objective-C

#pragma mark title 被点击时调用的代理方法
-(void)CJTopScrollMenu:(CJTopScrollMenu *)topScrollMenu didSelectTitleAtIndex:(NSInteger)index{
    // 1 计算滚动的位置
    CGFloat offsetX = index * self.view.frame.size.width;
    self.mainScrollView.contentOffset = CGPointMake(offsetX, 0);
    
    // 2.给对应位置添加对应子控制器
    [self showVc:index];
}

#pragma mark title 右侧折叠按钮被点击时调用的代理方法
- (void)CJAllMenuView:(CJAllMenuView *)allMenuView didSelectTitleAtIndex:(NSInteger)index{
    [UIView animateWithDuration:0.1 animations:^{
        [_topScrollMenu selectLabel:_topScrollMenu.allTitleLabel[index]];
        _coverView.hidden = YES;
    }];
}
```
## 写在最后
* 如在使用中, 遇到什么问题或有更好建议者, 请记得 [Issues me](https://github.com/kingsic/SGAdvertScrollView/issues) 或 yuanchaojie2014@163.com 邮箱联系我
