//
//  JMTAboutHeaderView.m
//  ToolsBox
//
//  Created by JM Zhao on 2017/9/13.
//  Copyright © 2017年 JunMing. All rights reserved.
//

#import "JMTAboutHeaderView.h"
#import "UIView+Extension.h"

@implementation JMTAboutHeaderView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        UIImageView *logo = [[UIImageView alloc] initWithFrame:CGRectMake(self.width/2-35, self.height*0.17, 70, 70)];
        logo.layer.cornerRadius = 16;
        logo.layer.masksToBounds = YES;
        logo.image = [UIImage imageNamed:@"orcodeIcon"];
        [self addSubview:logo];
        
        CGFloat h = (self.height-70-self.height*0.17)/2;
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(logo.frame), self.width, h)];
        label.text = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleName"];
        label.textAlignment = 1;
        label.font = [UIFont systemFontOfSize:14.0];
        CAGradientLayer *layer = [CAGradientLayer layer];
        layer.frame = label.frame;
        [self addSubview:label];
        
        UILabel *version = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(label.frame)-10, self.width, h)];
        version.text = [NSString stringWithFormat:@"Version : %@", [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"]];
        version.textAlignment = 1;
        version.textColor = JMColor(170, 170, 170);
        version.font = [UIFont fontWithName:@"GujaratiSangamMN-Bold" size:16];
        [self addSubview:version];
        
        UIColor *color1 = [self randColor];
        UIColor *color2 = [self randColor];
        UIColor *color3 = [self randColor];
        UIColor *color4 = [self randColor];
        UIColor *color5 = [self randColor];
        layer.colors = @[(id)color1.CGColor, (id)color2.CGColor, (id)color3.CGColor, (id)color4.CGColor, (id)color5.CGColor];
        
        [self.layer addSublayer:layer];
        layer.mask = label.layer;
        label.frame = layer.bounds;
        
    }
    return self;
}

- (UIColor *)randColor
{
    CGFloat r = arc4random_uniform(256) / 255.0;
    CGFloat g = arc4random_uniform(256) / 255.0;
    CGFloat b = arc4random_uniform(256) / 255.0;
    return [UIColor colorWithRed:r green:g blue:b alpha:1];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
