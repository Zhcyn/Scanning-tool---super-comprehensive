//
//  JMTTextView.m
//  JMORCode
//
//  Created by 赵俊明 on 2017/11/25.
//  Copyright © 2017年 JunMing. All rights reserved.
//

#import "JMTTextView.h"

@interface JMTTextView()
@property (nonatomic, weak) UIButton *btn;
@property (nonatomic, weak) UILabel *number;
@end

@implementation JMTTextView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        UILabel *playholed = [[UILabel alloc] initWithFrame:CGRectZero];
        playholed.textColor = [UIColor grayColor];
        [self addSubview:playholed];
        self.playholed = playholed;
        
        UILabel *number = [[UILabel alloc] initWithFrame:CGRectZero];
        number.text = @"120";
        number.textColor = [UIColor grayColor];
        [self addSubview:number];
        self.number = number;
        
        UIButton *btn = [UIButton buttonWithType:(UIButtonTypeSystem)];
        [btn addTarget:self action:@selector(clearAll:) forControlEvents:(UIControlEventTouchUpInside)];
        [btn setTintColor:[UIColor grayColor]];
        [btn setImage:[UIImage imageNamed:@"round_clouse_fill"] forState:(UIControlStateNormal)];
        [self addSubview:btn];
        self.btn = btn;
    }
    return self;
}

- (void)setContent:(NSString *)content
{
    _content = content;
    _number.text = content;
    _playholed.hidden = YES;
}

- (void)clearAll:(UIButton *)sender
{
    self.text = nil;
    _playholed.hidden = NO;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    _playholed.frame = CGRectMake(10, 10, 200, 20);
    _number.frame = CGRectMake(self.width-70, self.height-30, 50, 20);
    _btn.frame = CGRectMake(self.width-40, self.height-40, 40, 40);
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
