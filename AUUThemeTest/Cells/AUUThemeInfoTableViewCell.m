//
//  AUUThemeInfoTableViewCell.m
//  ThemeTest
//
//  Created by JyHu on 2017/2/24.
//  Copyright © 2017年 JyHu. All rights reserved.
//

#import "AUUThemeInfoTableViewCell.h"
#import <Masonry/Masonry.h>
#import "AUUThemeModel.h"
#import "UIColor+Helper.h"


@interface AUUThemeInfoTableViewCell()

@property (retain, nonatomic) UILabel *nameLabel;

@property (retain, nonatomic) UILabel *identifierLabel;

@property (retain, nonatomic) UILabel *pathLabel;

@property (retain, nonatomic) UIButton *tbutton;

@end

@implementation AUUThemeInfoTableViewCell

+ (CGFloat)heightForObject:(id)object atIndexPath:(NSIndexPath *)indexPath tableView:(UITableView *)tableView
{
    return 72;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if ((self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])) {
        [self initlization];
    }
    return self;
}

- (void)initlization
{
    self.contentView.app_backgroundColor = [[UIColor whiteColor] appearanceIdentifier:AUUColorBackground];
    
    self.nameLabel = [[UILabel alloc] init];
    self.nameLabel.app_textColor = [UIColor textTitleColor];
    self.nameLabel.font = [UIFont systemFontOfSize:18];
    [self addSubview:self.nameLabel];
    
    self.identifierLabel = [[UILabel alloc] init];
    self.identifierLabel.app_textColor = [[UIColor blackColor] appearanceIdentifier:AUUColorTextSubtitle];
    self.identifierLabel.font = [UIFont systemFontOfSize:15];
    [self addSubview:self.identifierLabel];
    
    self.pathLabel = [[UILabel alloc] init];
    self.pathLabel.app_textColor = [UIColor subtitleColor];
    self.pathLabel.layer.app_borderColor = [UIColor textTitleColor];
    self.pathLabel.font = [UIFont systemFontOfSize:12];
    self.pathLabel.lineBreakMode = NSLineBreakByCharWrapping;
    self.pathLabel.numberOfLines = 0;
    [self addSubview:self.pathLabel];
    
    self.tbutton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.tbutton setTitle:@"test button" forState:UIControlStateNormal];
    [self.tbutton setApp_TitleColor:[UIColor backgroundColor] forState:UIControlStateNormal];
    [self.tbutton setApp_backgroundColor:[UIColor textTitleColor]];
    [self addSubview:self.tbutton];
    
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(10);
        make.top.equalTo(self.mas_top).offset(5);
        make.bottom.equalTo(self.pathLabel.mas_top);
    }];
    
    [self.identifierLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.nameLabel.mas_right).offset(10);
        make.bottom.equalTo(self.nameLabel.mas_bottom);
    }];
    
    [self.pathLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.nameLabel.mas_left);
        make.right.equalTo(self.mas_right).offset(-10);
        make.bottom.equalTo(self.mas_bottom).offset(-5);
    }];
    
    [self.tbutton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.right.equalTo(self);
    }];
}

- (void)prepareForReuse
{
    [super prepareForReuse];
    self.nameLabel.text = @"";
    self.identifierLabel.text = @"";
    self.pathLabel.text = @"";
}

- (BOOL)shouldUpdateCellWithObject:(id)object
{
    [super shouldUpdateCellWithObject:object];
    if ([object isKindOfClass:[NICellObject class]]) {
        NICellObject *cellObject = (NICellObject *)object;
        AUUThemeModel *themeModel = cellObject.userInfo;
        self.nameLabel.text = themeModel.themeName;
        self.identifierLabel.text = themeModel.themeIdentifier;
        self.pathLabel.text = themeModel.themePath;
    }
    return YES;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
