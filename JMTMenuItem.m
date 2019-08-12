//
//  JMTMenuItem.m
//  JMORCode
//
//  Created by JM Zhao on 2017/11/22.
//  Copyright © 2017年 JunMing. All rights reserved.
//

#import "JMTMenuItem.h"
#import "JMTMenuItemModel.h"

@interface JMTMenuItem()
@property (nonatomic, weak) UIButton *button;
@property (nonatomic, weak) UILabel *btnTitle;
@end

@implementation JMTMenuItem

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
       
        UIButton *button = [UIButton buttonWithType:(UIButtonTypeSystem)];
        button.layer.borderWidth = 2;
        button.layer.borderColor = [UIColor whiteColor].CGColor;
        button.backgroundColor = [UIColor clearColor];
        button.tintColor = [UIColor whiteColor];
        [self addSubview:button];
        self.button = button;
        
        UILabel *btnTitle = [[UILabel alloc] initWithFrame:CGRectZero];
        btnTitle.textAlignment = NSTextAlignmentCenter;
        btnTitle.font = [UIFont systemFontOfSize:11.0];
        btnTitle.textColor = [UIColor whiteColor];
        [self addSubview:btnTitle];
        self.btnTitle = btnTitle;
        
    }
    return self;
}

- (void)setModel:(JMTMenuItemModel *)model
{
    _model = model;
    [_button setImage:[UIImage imageNamed:model.image] forState:(UIControlStateNormal)];
    _btnTitle.text = model.title;
}

- (void)addTarget:(id)target action:(SEL)action forControlEvents:(UIControlEvents)controlEvents
{
    self.button.tag = self.tag;
    [self.button addTarget:target action:action forControlEvents:controlEvents];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    _button.frame = CGRectMake(10, 0, self.width-20, self.height-20);
    _button.layer.cornerRadius = (self.width-20)/2;
    _btnTitle.frame = CGRectMake(0, CGRectGetMaxY(_button.frame)+5, self.width, 15);
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
