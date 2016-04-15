//
//  UIView+FrameExtension.h
//  加速计demo
//
//  Created by xalo on 16/1/25.
//  Copyright © 2016年 岳朝逢. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (FrameExtension)

@property (nonatomic, assign) CGFloat x;
@property (nonatomic, assign) CGFloat y;
@property (nonatomic, assign) CGFloat maxX;
@property (nonatomic, assign) CGFloat maxY;
@property (nonatomic, assign) CGFloat centerX;
@property (nonatomic, assign) CGFloat centerY;
@property (nonatomic, assign) CGFloat width;
@property (nonatomic, assign) CGFloat height;
@property (nonatomic, assign) CGSize size;

@end
