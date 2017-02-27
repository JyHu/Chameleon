//
//  AUUTableViewController.h
//  ThemeTest
//
//  Created by JyHu on 2017/2/24.
//  Copyright © 2017年 JyHu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Nimbus/NITableViewModel.h>
#import "AUUTableViewActions.h"
#import <Nimbus/NIMutableTableViewModel.h>

@interface AUUTableViewController : UIViewController <UITableViewDelegate, NIMutableTableViewModelDelegate>

- (instancetype)initWithStyle:(UITableViewStyle)style;

@property (retain, nonatomic) UITableView *tableView;

@property (retain, nonatomic) NIMutableTableViewModel *tableModel;

@property (retain, nonatomic) AUUTableViewActions *tableActions;

/**
 是否需要下拉刷心的头
 */
@property (assign, nonatomic) BOOL needRefreshHeader;

/**
 主动的去刷新页面数据
 */
- (void)triggerToRefresh;

/**
 停止数据的刷新，包括上拉、下拉
 */
- (void)stopDataLoading;

#pragma mark - 子类实现

/**
 当下拉刷新的时候，会调用这个方法，需要在子类里去实现实际网络请求
 */
- (void)refreshData;

@end
