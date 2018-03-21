//
//  AUURefreshHeader.m
//  ThemeTest
//
//  Created by JyHu on 2017/2/24.
//  Copyright © 2017年 JyHu. All rights reserved.
//

#import "AUURefreshHeader.h"
#import <Masonry/Masonry.h>
#import "UIImage+AUUHelper.h"

@interface AUURefreshHeader()

@property (retain, nonatomic) UILabel *tipsLabel;

@property (retain, nonatomic) UILabel *updateTimeLabel;

@property (retain, nonatomic) UIImageView *directionArrowImageView;

@property (retain, nonatomic) NSDate *lastUpdateDate;

@end

@implementation AUURefreshHeader

/** 初始化 */
- (void)prepare
{
    [super prepare];
    
    self.mj_h = 44;
    
    self.tipsLabel = [[UILabel alloc] init];
    self.tipsLabel.backgroundColor = [UIColor clearColor];
    self.tipsLabel.app_textColor = [UIColor textTitleColor];
    self.tipsLabel.text = @"下拉可以刷新";
    [self addSubview:self.tipsLabel];
    
    self.updateTimeLabel = [[UILabel alloc] init];
    self.updateTimeLabel.backgroundColor = [UIColor clearColor];
    self.updateTimeLabel.app_textColor = [UIColor textTitleColor];
    [self addSubview:self.updateTimeLabel];
    
    self.directionArrowImageView = [[UIImageView alloc] init];
    self.directionArrowImageView.app_image = [UIImage referArrowImage];
    [self addSubview:self.directionArrowImageView];
    
    [self.tipsLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.mas_centerX);
        make.top.equalTo(self.mas_top);
        make.bottom.equalTo(self.updateTimeLabel.mas_top);
    }];
    
    [self.updateTimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.mas_centerX);
        make.bottom.equalTo(self.mas_bottom);
    }];
    
    [self.directionArrowImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.mas_centerX).offset(-60);
        make.centerY.equalTo(self.mas_centerY);
        make.size.equalTo([NSValue valueWithCGSize:CGSizeMake(20, 30)]);
    }];
    
    self.lastUpdateDate = [NSDate date];
}

/** 摆放子控件frame */
- (void)placeSubviews
{
    [super placeSubviews];
}

/** 当scrollView的contentOffset发生改变的时候调用 */
- (void)scrollViewContentOffsetDidChange:(NSDictionary *)change
{
    [super scrollViewContentOffsetDidChange:change];
}

/** 当scrollView的contentSize发生改变的时候调用 */
- (void)scrollViewContentSizeDidChange:(NSDictionary *)change
{
    [super scrollViewContentSizeDidChange:change];
}

/** 当scrollView的拖拽状态发生改变的时候调用 */
- (void)scrollViewPanStateDidChange:(NSDictionary *)change
{
    [super scrollViewPanStateDidChange:change];
}

/** 状态改变时 */
- (void)setState:(MJRefreshState)state
{
    MJRefreshCheckState;
    switch (state) {
            
        case MJRefreshStateIdle:
        {
            [UIView animateWithDuration:0.35 animations:^{
                self.directionArrowImageView.transform = CGAffineTransformIdentity;
            }];
            self.tipsLabel.text = @"下拉可以刷新";
            NSCalendar *calendar = [NSCalendar currentCalendar];
#if defined(__IPHONE_8_0) && (__IPHONE_OS_VERSION_MIN_REQUIRED >= __IPHONE_8_0)
            NSUInteger unitFlags = NSCalendarUnitYear| NSCalendarUnitMonth | NSCalendarUnitDay |NSCalendarUnitHour |NSCalendarUnitMinute;
#else
            NSUInteger unitFlags = NSYearCalendarUnit| NSMonthCalendarUnit | NSDayCalendarUnit |NSHourCalendarUnit |NSMinuteCalendarUnit;
#endif
            NSDateComponents *cmp1 = [calendar components:unitFlags fromDate:self.lastUpdateDate];
            NSDateComponents *cmp2 = [calendar components:unitFlags fromDate:[NSDate date]];
            
            // 2.格式化日期
            NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
            if ([cmp1 day] == [cmp2 day]) { // 今天
                formatter.dateFormat = @"今天 HH:mm";
            } else if ([cmp1 year] == [cmp2 year]) { // 今年
                formatter.dateFormat = @"MM-dd HH:mm";
            } else {
                formatter.dateFormat = @"yyyy-MM-dd HH:mm";
            }
            
            NSString *time = [formatter stringFromDate:self.lastUpdateDate];
            
            self.updateTimeLabel.text = time;
            break;
        }
            
        case MJRefreshStatePulling:
        {
            [UIView animateWithDuration:0.35 animations:^{
                self.directionArrowImageView.transform = CGAffineTransformRotate(self.directionArrowImageView.transform, M_PI);
            }];
            self.tipsLabel.text = @"松开立即刷新";
            break;
        }
            
        case MJRefreshStateRefreshing:
        {
            self.tipsLabel.text = @"正在刷新...";
            break;
        }
        default:
            break;
    }
}

@end
