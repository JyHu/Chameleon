//
//  AUNavigationController.m
//  ThemeTest
//
//  Created by JyHu on 2017/2/24.
//  Copyright © 2017年 JyHu. All rights reserved.
//

#import "AUNavigationController.h"
#import "UIImage+AUUHelper.h"

@interface AUNavigationController ()

@end

@implementation AUNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.app_backgroundColor = [UIColor backgroundColor];
    self.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName : [UIColor whiteColor]};
    self.navigationBar.app_titleColor = [UIColor textTitleColor];
    [self.navigationBar setApp_BackgroundImage:[UIImage navbarBackgroundImage] forBarMetrics:UIBarMetricsDefault];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
