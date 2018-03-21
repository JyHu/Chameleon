//
//  AUUUsersViewController.m
//  ThemeTest
//
//  Created by JyHu on 2017/2/24.
//  Copyright © 2017年 JyHu. All rights reserved.
//

#import "AUUUsersViewController.h"
#import "AUUTestThemeManager.h"
#import "AUUUserTableViewCell.h"
#import "AUUUserModel.h"
#import <Nimbus/NICellCatalog.h>
#import <Nimbus/NIMutableTableViewModel+Private.h>
#import "AUUThemeModel.h"
#import "AUUSubViewController.h"

@interface AUUUsersViewController ()

@end

@implementation AUUUsersViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.needRefreshHeader = YES;
    [self triggerToRefresh];
    
    [self.tableActions attachToClass:[NICellObject class] tapSelector:@selector(userAction:indexPath:)];
}

- (void)refreshData
{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self stopDataLoading];
        
        if (self.tableModel.sections.count > 0) {
            [self.tableModel removeSectionAtIndex:0];
        }
        
        NSMutableArray *cellObjects = [NSMutableArray array];
        for (NSInteger i = 0; i < arc4random_uniform(30) + 10; i ++) {
            [cellObjects addObject:[NICellObject objectWithCellClass:[AUUUserTableViewCell class] userInfo:[self generateUserModelWithIndex:i]]];
        }
        [self.tableModel addObjectsFromArray:cellObjects];
        [self.tableView reloadData];
    });
}

- (AUUUserModel *)generateUserModelWithIndex:(NSInteger)index
{
    AUUUserModel *model = [[AUUUserModel alloc] init];
    
    model.imageIdentifier = @[AUUImageHeadHead1, AUUImageHeadHead2, AUUImageHeadHead3][index % 3];
    
    return model;
}

- (void)userAction:(NICellObject *)object indexPath:(NSIndexPath *)indexPath {
//    NSArray *themes = [[AUUTestThemeManager sharedManager].themesDict allValues];
//    AUUThemeModel *themeModel = [themes objectAtIndex:indexPath.row % themes.count];
//    [[AUUTestThemeManager sharedManager] changeThemeWithIdentifier:themeModel.themeIdentifier];
    
    AUUSubViewController *subvc = [[AUUSubViewController alloc] init];
    [subvc subscribeDealloc:^(__unsafe_unretained id self) {
        NSLog(@"page dealloc %@", self);
    }];
    [subvc subscribeDealloc:^(__unsafe_unretained id self) {
        NSLog(@"page dealloc 2 %@", self);
    }];
    [subvc.testView subscribeDealloc:^(__unsafe_unretained id self) {
        NSLog(@"test view dealloc %@", self);
    }];
    [self.navigationController pushViewController:subvc animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
