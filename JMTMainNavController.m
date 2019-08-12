//
//  JMTMainNavController.m
//  YaoYao
//
//  Created by JM Zhao on 16/9/18.
//  Copyright © 2016年 Mac. All rights reserved.
//

#import "JMTMainNavController.h"
#import "UINavigationBar+Awesome.h"

@interface JMTMainNavController ()

@end

@implementation JMTMainNavController

- (void)viewDidLoad {
    [super viewDidLoad];
    // [self setupNavTheme];
    // [self.navigationBar lt_setBackgroundColor:[UIColor clearColor]];
    // [self.navigationBar It_setNavigationBarBackIndicatorView:0.0];
}

- (void)setupNavTheme
{
    UINavigationBar *navBar = [[UINavigationBar alloc] init];
    navBar.tintColor = JMColor(41, 41, 41);
    NSDictionary *attr = @{
                           NSForegroundColorAttributeName : JMColor(41, 41, 41),
                           NSFontAttributeName : [UIFont boldSystemFontOfSize:18.0]
                           };
    navBar.titleTextAttributes = attr;
    navBar.translucent = YES;
    [self setValue:navBar forKey:@"navigationBar"];
}

- (BOOL)prefersStatusBarHidden
{
    return UIInterfaceOrientationIsLandscape([UIApplication sharedApplication].statusBarOrientation);
}

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleDefault;
}

- (BOOL)shouldAutorotate
{
    // 是否支持自动旋转
    return NO;
}

//设备支持的方向
- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    
    return UIInterfaceOrientationMaskPortrait;
}

//方向标识
- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation {
    
    return UIInterfaceOrientationPortrait;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
