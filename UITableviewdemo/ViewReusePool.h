//
//  ViewReusePool.h
//  UITableviewdemo
//
//  Created by 张得丑 on 2021/4/28.
//
// 视图重用池

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ViewReusePool : NSObject

// 取出可重用的view
- (UIView *)takeOutTheReusableView;
// 添加一个新view
- (void)addNewUsingView:(UIView *)newView;
// 重置方法 将使用中的视图回收到等待
- (void)reset;
@end

NS_ASSUME_NONNULL_END
