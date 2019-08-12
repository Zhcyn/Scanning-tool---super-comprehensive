//
//  UINavigationController+StatusbarStyle.m
//  JMORCode
//
//  Created by 赵俊明 on 2017/11/25.
//  Copyright © 2017年 JunMing. All rights reserved.
//

#import "UINavigationController+StatusbarStyle.h"

@implementation UINavigationController (StatusbarStyle)
- (UIViewController *)childViewControllerForStatusBarStyle
{
    return self.topViewController;
}

- (UIViewController *)childViewControllerForStatusBarHidden
{
    return self.topViewController;
}
@end
