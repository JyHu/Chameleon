//
//  AUUThemesListViewController.m
//  ThemeTest
//
//  Created by JyHu on 2017/2/24.
//  Copyright © 2017年 JyHu. All rights reserved.
//

#import "AUUThemesListViewController.h"
#import "AUUTestThemeManager.h"
#import "AUUThemeInfoTableViewCell.h"
#import "AUUThemeModel.h"
#import <Nimbus/NICellCatalog.h>
#import <Nimbus/NIMutableTableViewModel+Private.h>

@interface AUUThemesListViewController ()

@end

@implementation AUUThemesListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.needRefreshHeader = YES;
    [self triggerToRefresh];
}

- (void)refreshData
{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self stopDataLoading];
        
        if (self.tableModel.sections.count > 0) {
            [self.tableModel removeSectionAtIndex:0];
        }
        
        NSMutableArray *themesObject = [[NSMutableArray alloc] init];
        for (AUUThemeModel *model in [[AUUTestThemeManager sharedManager].themesDict allValues]) {
            NICellObject *object = [NICellObject objectWithCellClass:[AUUThemeInfoTableViewCell class] userInfo:model];
            [themesObject addObject:[self.tableActions attachToObject:object tapBlock:^BOOL(id object, id target, NSIndexPath *indexPath) {
                AUUThemeModel *themeModel = ((NICellObject *)object).userInfo;
                [[AUUTestThemeManager sharedManager] changeThemeWithIdentifier:themeModel.themeIdentifier];
                return YES;
            }]];
        }
        [self.tableModel addObjectsFromArray:themesObject];
        [self.tableView reloadData];
    });
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
