//
//  AUUTableViewController.m
//  ThemeTest
//
//  Created by JyHu on 2017/2/24.
//  Copyright © 2017年 JyHu. All rights reserved.
//

#import "AUUTableViewController.h"
#import <Nimbus/NICellFactory.h>
#import "AUURefreshHeader.h"
#import <MJRefresh/MJRefresh.h>
#import "AUULoadMoreFooter.h"

@interface AUUTableViewController ()

@property (retain, nonatomic) UITableView *pri_tableView;

@property (assign, nonatomic) UITableViewStyle pri_style;

@end

@implementation AUUTableViewController

- (instancetype)initWithStyle:(UITableViewStyle)style
{
    if ((self = [super init])) {
        self.pri_style = style;
    }
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.pri_tableView];
    self.needRefreshHeader = YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 10e-10;
}

#pragma mark - NIMutableTableViewModelDelegate

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    CGFloat height = tableView.rowHeight;
    id object = [(NITableViewModel *)tableView.dataSource objectAtIndexPath:indexPath];
    id class = [object cellClass];
    if ([class respondsToSelector:@selector(heightForObject:atIndexPath:tableView:)])
    {
        height = [class heightForObject:object atIndexPath:indexPath tableView:tableView];
    }
    return height;
}

- (UITableViewCell *)tableViewModel:(NITableViewModel *)tableViewModel cellForTableView:(UITableView *)tableView
                        atIndexPath:(NSIndexPath *)indexPath withObject:(id)object
{
    UITableViewCell *cell = [NICellFactory tableViewModel:tableViewModel cellForTableView:tableView atIndexPath:indexPath withObject:object];
    
    return cell;
}

#pragma mark - getter and setter

- (UITableView *)pri_tableView
{
    if (!_pri_tableView)
    {
        _pri_tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:self.pri_style];
        _pri_tableView.dataSource = self.tableModel;
        _pri_tableView.delegate = [self.tableActions forwardingTo:self];
        _pri_tableView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        _pri_tableView.backgroundColor = [UIColor clearColor];
        _pri_tableView.tableFooterView = [UIView new];
        _pri_tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        _pri_tableView.separatorColorIdentifier = AUUColorText;
        _pri_tableView.separatorInset = UIEdgeInsetsMake(0, 10, 0, 10);
    }
    
    return _pri_tableView;
}

- (void)refreshData
{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.35 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self stopDataLoading];
    });
}

- (void)triggerToRefresh
{
    [self.pri_tableView.mj_header beginRefreshing];
}

- (void)stopDataLoading
{
    if (self.pri_tableView.mj_header.state == MJRefreshStateRefreshing)
    {
        [self.pri_tableView.mj_header endRefreshing];
    }
}

- (UITableView *)tableView
{
    return self.pri_tableView;
}

- (NIMutableTableViewModel *)tableModel
{
    if (!_tableModel)
    {
        _tableModel = [[NIMutableTableViewModel alloc] initWithDelegate:self];
    }
    
    return _tableModel;
}

- (AUUTableViewActions *)tableActions
{
    if (!_tableActions)
    {
        _tableActions = [[AUUTableViewActions alloc] initWithTarget:self];
    }
    
    return _tableActions;
}

- (void)setNeedRefreshHeader:(BOOL)needRefreshHeader
{
    if (needRefreshHeader && !_needRefreshHeader)
    {
        self.pri_tableView.mj_header = [AUURefreshHeader headerWithRefreshingTarget:self refreshingAction:@selector(refreshData)];
    }
    else if (!needRefreshHeader && _needRefreshHeader)
    {
        self.pri_tableView.mj_header = nil;
    }
    
    _needRefreshHeader = needRefreshHeader;
}

@end
