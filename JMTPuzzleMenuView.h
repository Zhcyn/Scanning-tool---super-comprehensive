//
//  JMTPuzzleMenuView.h
//  Puzzle
//
//  Created by JM Zhao on 2017/9/22.
//  Copyright © 2017年 JunMing. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JMTPuzzleMenuView : UIView
@property (nonatomic, copy) void(^didSelectBlock)(NSInteger type);
@end
