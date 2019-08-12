//
//  JMTMenuItem.h
//  JMORCode
//
//  Created by JM Zhao on 2017/11/22.
//  Copyright © 2017年 JunMing. All rights reserved.
//

#import <UIKit/UIKit.h>
@class JMTMenuItemModel;
@interface JMTMenuItem : UIView
@property (nonatomic, strong) JMTMenuItemModel *model;
- (void)addTarget:(id)target action:(SEL)action forControlEvents:(UIControlEvents)controlEvents;
@end
