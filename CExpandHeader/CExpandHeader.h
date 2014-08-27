//
//  CExpandHeader.h
//  CExpandHeaderViewExample
//
//
//  Created by cml on 14-8-27.
//  Copyright (c) 2014年 Mei_L. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CExpandHeader : NSObject <UIScrollViewDelegate>

#pragma mark - 类方法 
/**
 *  生成一个CExpandHeader实例
 *
 *  @param scrollView
 *  @param expandView 可以伸展的背景View
 *
 *  @return CExpandHeader 对象
 */
+ (id)expandWithScrollView:(UIScrollView*)scrollView expandView:(UIView*)expandView;


#pragma mark - 成员方法
/**
 *
 *
 *  @param scrollView
 *  @param expandView
 */
- (void)expandWithScrollView:(UIScrollView*)scrollView expandView:(UIView*)expandView;

/**
 *  监听scrollViewDidScroll方法
 *
 *  @param scrollView
 */
- (void)scrollViewDidScroll:(UIScrollView*)scrollView;

@end
