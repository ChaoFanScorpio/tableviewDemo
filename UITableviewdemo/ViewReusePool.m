//
//  ViewReusePool.m
//  UITableviewdemo
//
//  Created by 张得丑 on 2021/4/28.
//

#import "ViewReusePool.h"

@interface ViewReusePool ()

// 使用中队列
@property (nonatomic, strong) NSMutableSet *usingQueue;
// 等待中的队列
@property (nonatomic, strong) NSMutableSet *waitQueue;

@end

@implementation ViewReusePool

#pragma mark — private action
// 取出可重用的view
- (UIView *)takeOutTheReusableView{
    UIView *view = self.waitQueue.anyObject;
    if (view) {
        [self.waitQueue removeObject:view];
        [self.usingQueue addObject:view];
    }
    return view;
}

// 添加一个新view
- (void)addNewUsingView:(UIView *)newView{
    if (newView) [self.usingQueue addObject:newView];
}

// 重置方法 将使用中的视图回收到等待队列中 使用队列删除
- (void)reset{
    [self.usingQueue enumerateObjectsUsingBlock:^(id  _Nonnull obj, BOOL * _Nonnull stop) {
        [self.waitQueue addObject:obj];
        [self.usingQueue removeObject:obj];
    }];
}

#pragma mark — getter
- (NSMutableSet *)usingQueue{
    if (!_usingQueue) {
        _usingQueue = NSMutableSet.set;
    }
    return _usingQueue;
}

- (NSMutableSet *)waitQueue{
    if (!_waitQueue) {
        _waitQueue = NSMutableSet.set;
    }
    return _waitQueue;
}


@end
