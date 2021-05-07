//
//  CustomTableView.m
//  UITableviewdemo
//
//  Created by 张得丑 on 2021/4/28.
//

#import "CustomTableView.h"
#import "ViewReusePool.h"

@interface CustomTableView ()

@property (nonatomic, strong) UIView *containerView;

@property (nonatomic, strong) ViewReusePool *reusePool;


@end

@implementation CustomTableView

- (void)reloadData{
    [super reloadData];
    
    if (!_containerView) {
        [self.superview insertSubview:self.containerView aboveSubview:self];
    }
    
    // 标记所有view为可重置状态
    [self.reusePool reset];
    
    // reload字母索引条
    [self reloadIndexedBar];
}

- (void)reloadIndexedBar{
    
    NSArray <NSString *>*titleArray = nil;
    if ([self.customDataSource respondsToSelector:@selector(customTableViewTitlesForIndexTableView:)]) {
        titleArray = [self.customDataSource customTableViewTitlesForIndexTableView:self];
    }
    
    if (!titleArray.count) {
        self.containerView.hidden = YES;
        return;
    }
    
    NSInteger count = titleArray.count;
    float btnW = 60;
    float btnH = self.frame.size.height / count;
    for (int i = 0; i < count; i++) {
        UIButton *btn = (UIButton *)[self.reusePool takeOutTheReusableView];
        if (btn) {
            NSLog(@"btn被复用了");
        }else{
            btn = [UIButton buttonWithType:UIButtonTypeCustom];
            btn.backgroundColor = UIColor.whiteColor;
            [btn setTitleColor:UIColor.lightGrayColor forState:UIControlStateNormal];
            [self.reusePool addNewUsingView:btn];
            NSLog(@"创建了新的btn");
        }
        
        [btn setTitle:titleArray[i] forState:UIControlStateNormal];
        btn.frame = CGRectMake(0, i * btnH, btnW, btnH);
        [self.containerView addSubview:btn];
    }
    
    self.containerView.hidden = NO;
    self.containerView.frame = CGRectMake(self.frame.origin.x + self.frame.size.width - btnW, self.frame.origin.y, btnW, self.frame.size.height);
    
}

#pragma mark — getter
- (UIView *)containerView{
    if (!_containerView) {
        _containerView = [[UIView alloc] init];
        _containerView.backgroundColor = UIColor.whiteColor;
    }
    return _containerView;;
}

- (ViewReusePool *)reusePool{
    if (!_reusePool) {
        _reusePool = [[ViewReusePool alloc] init];
    }
    return _reusePool;
}

@end
