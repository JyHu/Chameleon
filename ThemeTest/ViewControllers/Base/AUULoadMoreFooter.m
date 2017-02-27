//
//  AUULoadMoreFooter.m
//  ThemeTest
//
//  Created by JyHu on 2017/2/24.
//  Copyright © 2017年 JyHu. All rights reserved.
//

#import "AUULoadMoreFooter.h"
#import <Masonry/Masonry.h>

@interface AUULoadMoreFooter()

@property (retain, nonatomic) UILabel *tipsLabel;

@end

@implementation AUULoadMoreFooter

- (void)prepare
{
    [super prepare];
    
    self.backgroundColor = [UIColor greenColor];
    
    self.tipsLabel = [[UILabel alloc] init];
    self.tipsLabel.textColor = [UIColor whiteColor];
    self.tipsLabel.text = @"加载更多...";
    [self addSubview:self.tipsLabel];
    
    [self.tipsLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.mas_centerX);
        make.centerY.equalTo(self.mas_centerY);
    }];
}

- (void)setState:(MJRefreshState)state
{
    MJRefreshCheckState;
    
    switch (state) {
        case MJRefreshStateIdle:
            self.tipsLabel.text = @"上拉即可加载更多";
            break;
            
        case MJRefreshStatePulling:
            self.tipsLabel.text = @"松开即可加载";
            break;
            
        case MJRefreshStateRefreshing:
            self.tipsLabel.text = @"正在加载...";
            break;
            
        default:
            break;
    }
}

@end
