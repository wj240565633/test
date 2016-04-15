//
//  DrawerViewController.h
//  DrawerDemo
//
//  Created by xalo on 16/1/30.
//  Copyright © 2016年 岳朝逢. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DrawerViewController : UIViewController

@property (nonatomic, strong) UIViewController *rootVC;

@property (nonatomic, strong) NSArray *menuList;

@property (nonatomic, strong) NSArray *menuListVC;

- (void)setRootVC:(UIViewController *)root isNeedNavi:(BOOL)isNeedNavi;

@end
