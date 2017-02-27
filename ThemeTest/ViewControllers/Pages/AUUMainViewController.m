//
//  AUUMainViewController.m
//  ThemeTest
//
//  Created by JyHu on 2017/2/24.
//  Copyright © 2017年 JyHu. All rights reserved.
//

#import "AUUMainViewController.h"
#import "AUUThemesListViewController.h"
#import "AUUUsersViewController.h"

@interface AUUMainViewController ()

@property (retain, nonatomic) AUUThemesListViewController *themeListVC;

@property (retain, nonatomic) AUUUsersViewController *usersVC;

@end

@implementation AUUMainViewController

- (instancetype)init
{
    return [super initWithPages:@[self.themeListVC, self.usersVC]];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"测试页面喽";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (AUUThemesListViewController *)themeListVC
{
    if (!_themeListVC)
    {
        _themeListVC = [[AUUThemesListViewController alloc] initWithStyle:UITableViewStyleGrouped];
        _themeListVC.title = @"主题列表";
    }
    
    return _themeListVC;
}

- (AUUUsersViewController *)usersVC
{
    if (!_usersVC)
    {
        _usersVC = [[AUUUsersViewController alloc] initWithStyle:UITableViewStyleGrouped];
        _usersVC.title = @"用户列表";
    }
    
    return _usersVC;
}

@end
