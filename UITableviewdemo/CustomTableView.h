//
//  CustomTableView.h
//  UITableviewdemo
//
//  Created by 张得丑 on 2021/4/28.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol CustomTableViewDataSource <NSObject>

// 获取一个tableview的字母索引条数据的方法
- (NSArray <NSString *> *)customTableViewTitlesForIndexTableView:(UITableView *)tableView;

@end


@interface CustomTableView : UITableView

@property(nonatomic, weak) id<CustomTableViewDataSource> customDataSource;

@end

NS_ASSUME_NONNULL_END
