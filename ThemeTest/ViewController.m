//
//  ViewController.m
//  ThemeTest
//
//  Created by JyHu on 2017/2/13.
//  Copyright © 2017年 JyHu. All rights reserved.
//

#import "ViewController.h"
#import "AUUThemeConstants.h"
#import "AUUThemeManager.h"
#import "AUUThemeKits.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UISwitch *switchkit;

@property (weak, nonatomic) IBOutlet UILabel *label;

@property (weak, nonatomic) IBOutlet UISegmentedControl *segmentcontrol;

@property (weak, nonatomic) IBOutlet UITextView *textview;

@property (weak, nonatomic) IBOutlet UIImageView *image1;

@property (weak, nonatomic) IBOutlet UIImageView *image2;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [self.view setBackgroundColorWithIdentifier:AUUThemeColorBackground];
    
    [self.switchkit setOnTintColorWithIdentifier:AUUThemeColorColor1];
    [self.switchkit setTintColorWithIdentifier:AUUThemeColorColor2];
    [self.switchkit setBackgroundColorWithIdentifier:AUUThemeColorColor3];
    
    [self.label setTextColorWithIdentifier:AUUThemeColorTextColor];
    self.label.backgroundColor = [UIColor clearColor];
    
    [self.segmentcontrol setTintColorWithIdentifier:AUUThemeColorTextColor];
    [self.segmentcontrol addTarget:self action:@selector(segchanged:) forControlEvents:UIControlEventValueChanged];
    
    [self.textview setTextColorWithIdentifier:AUUThemeColorTextColor];
    [self.textview setBackgroundColorWithIdentifier:AUUThemeColorColor4];
    
    self.image1.contentMode = UIViewContentModeScaleAspectFit;
    self.image2.contentMode = UIViewContentModeScaleAspectFit;
    
    [self.image1 setImageWithIdentifier:AUUThemeImageHead1];
    [self.image2 setImageWithIdentifier:AUUThemeImageHead2];
}

- (void)segchanged:(UISegmentedControl *)seg
{
    if (seg.selectedSegmentIndex == 0)
    {
        [self changeWhiteTheme];
    }
    else
    {
        [self changeBlackTheme];
    }
}

- (void)changeBlackTheme
{
    [[AUUThemeManager sharedManager] changeThemeWithIdentifier:@"com.jyhu.theme.black"];
}

- (void)changeWhiteTheme
{
    [[AUUThemeManager sharedManager] changeThemeWithIdentifier:@"com.jyhu.theme.white"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
