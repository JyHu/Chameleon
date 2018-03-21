//
//  AUUPagerViewController.m
//  ThemeTest
//
//  Created by JyHu on 2017/2/24.
//  Copyright © 2017年 JyHu. All rights reserved.
//

#import "AUUPagerViewController.h"
#import <UIView_Borders/UIView+Borders.h>

#define kPageControlHeight 30

@interface AUUPagerViewController ()

@property (assign, nonatomic) UIEdgeInsets containerInsets;

@property (retain, nonatomic) NSArray *pri_pages;

@end

@implementation AUUPagerViewController

- (instancetype)initWithPages:(NSArray *)pages
{
    return [self initWithPages:pages containerInsets:UIEdgeInsetsMake(0, 0, 49, 0)];
}

- (instancetype)initWithPages:(NSArray *)pages containerInsets:(UIEdgeInsets)insets
{
    self = [super init];
    
    if (self)
    {
        self.containerInsets = insets;
        self.pri_pages = pages;
    }
    
    return self;
}

- (void)viewDidLoad {
    self.contentContainer = [[UIView alloc] initWithFrame:CGRectMake(self.containerInsets.left, self.containerInsets.top + kPageControlHeight,
                                                                     CGRectGetWidth(self.view.bounds) - self.containerInsets.left - self.containerInsets.right,
                                                                     CGRectGetHeight(self.view.bounds) - self.containerInsets.top - self.containerInsets.bottom)];
    self.contentContainer.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    self.contentContainer.backgroundColor = [UIColor clearColor];
    [self.view addSubview:self.contentContainer];
    
    [self setPages:[self.pri_pages mutableCopy]];
    
    self.pageControl = [[HMSegmentedControl alloc] initWithFrame:CGRectMake(0, self.containerInsets.top, CGRectGetWidth(self.view.bounds), kPageControlHeight)];
    self.pageControl.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    [self.view addSubview:self.pageControl];
    
    [super viewDidLoad];
    
    self.pageControl.selectionIndicatorLocation = HMSegmentedControlSelectionIndicatorLocationDown;
    self.pageControl.selectionStyle = HMSegmentedControlSelectionStyleTextWidthStripe;
    self.pageControl.verticalDividerEnabled = NO;
    self.pageControl.selectionIndicatorHeight = 2;
    self.pageControl.appearanceIdentifier = AUUAppearanceSegment;
    
    self.view.app_backgroundColor = [UIColor backgroundColor];
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
