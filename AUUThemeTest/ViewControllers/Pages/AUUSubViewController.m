//
//  AUUSubViewController.m
//  AUUThemeTest
//
//  Created by 胡金友 on 2018/3/20.
//

#import "AUUSubViewController.h"

@interface AUUSubViewController ()

@end

@implementation AUUSubViewController

- (void)dealloc {
    NSLog(@"vc dealloc");
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.app_backgroundColor = [UIColor backgroundColor];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(tttmethod) name:UIKeyboardDidHideNotification object:nil];
    
    self.testView = [[UIView alloc] initWithFrame:CGRectMake(20, 100, 200, 120)];
    self.testView.app_backgroundColor = [UIColor vcBackgroundColor];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitle:@"title" forState:UIControlStateNormal];
    [button setApp_TitleColor:[UIColor textTitleColor] forState:UIControlStateNormal];
    [self.view addSubview:button];
    
    NSLog(@"%@", self.view.app_backgroundColor);
}

- (void)tttmethod {
    
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
