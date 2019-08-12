//
//  JMTQRCodeCollectionViewCell.m
//  JMORCode
//
//  Created by JM Zhao on 2017/11/24.
//  Copyright © 2017年 JunMing. All rights reserved.
//

#import "JMTQRCodeCollectionViewCell.h"
#import "JMTQRCodeCollModel.h"

@interface JMTQRCodeCollectionViewCell()
@property (nonatomic, strong) UIButton *albumType;
@property (nonatomic, strong) UILabel *AlbumSize;
@end

@implementation JMTQRCodeCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    if ([super initWithFrame:frame]) {
        
        self.backgroundColor = [UIColor whiteColor];
        
        _albumType = [UIButton buttonWithType:(UIButtonTypeSystem)];
        _albumType.userInteractionEnabled = NO;
//        _albumType.tintColor = JMColor(250, 108, 135);
        [self.contentView addSubview:_albumType];
        
        _AlbumSize = [[UILabel alloc] initWithFrame:CGRectZero];
        _AlbumSize.numberOfLines = 0;
        _AlbumSize.textAlignment = NSTextAlignmentCenter;
        _AlbumSize.textColor = [UIColor blackColor];
        _AlbumSize.font = [UIFont boldSystemFontOfSize:11];
        [self.contentView addSubview:_AlbumSize];
    }
    
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    _albumType.frame = self.bounds;
    _AlbumSize.frame = CGRectMake(0, self.height-30, self.width, 30);
}

- (void)setModel:(JMTQRCodeCollModel *)model
{
    _model = model;
    [_albumType setImage:[UIImage imageNamed:model.image] forState:(UIControlStateNormal)];
    _AlbumSize.text = model.title;
}

@end
