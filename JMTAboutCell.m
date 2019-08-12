//
//  JMTAboutCell.m
//  ToolsBox
//
//  Created by JM Zhao on 2017/9/13.
//  Copyright © 2017年 JunMing. All rights reserved.
//

#import "JMTAboutCell.h"
#import "JMTAboutModel.h"
#import "UIView+Extension.h"

@interface JMTAboutCell()
@property (nonatomic, weak) UIImageView *leftImage;
@property (nonatomic, weak) UILabel *textTitle;
@end

@implementation JMTAboutCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        UIImageView *leftImage = [[UIImageView alloc] init];
        leftImage.contentMode = UIViewContentModeScaleAspectFill;
        [self.contentView addSubview:leftImage];
        leftImage.tintColor = [UIColor grayColor];
        self.leftImage = leftImage;
        
        UILabel *textTitle = [[UILabel alloc] init];
        textTitle.textAlignment = NSTextAlignmentLeft;
        textTitle.font = [UIFont systemFontOfSize:14.0];
        [self.contentView addSubview:textTitle];
        self.textTitle = textTitle;
        
        self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    return self;
}

- (void)setModel:(JMTAboutModel *)model
{
    _model = model;
    _textTitle.text = model.title;
    if (model.isShowImage) {_leftImage.image = [UIImage imageNamed:model.icon];}
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    CGFloat w = _model.isShowImage?self.height-20:0;
    _leftImage.frame = CGRectMake(10, 12, w, self.height-20);
    
    CGFloat m = _model.isShowImage?10:0;
    _textTitle.frame = CGRectMake(CGRectGetMaxX(_leftImage.frame)+m, 8, self.width*0.6, self.height-10);
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
