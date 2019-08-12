//
//  JMTBaseCreatCodeController.m
//  JMORCode
//
//  Created by JM Zhao on 2017/11/24.
//  Copyright © 2017年 JunMing. All rights reserved.
//

#import "JMTBaseCreatCodeController.h"

@interface JMTBaseCreatCodeController ()

@end

@implementation JMTBaseCreatCodeController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIBarButtonItem *right = [[UIBarButtonItem alloc] initWithTitle:NSLocalizedString(@"orscan.items.scanCreatCodeCreat", "") style:(UIBarButtonItemStyleDone) target:self action:@selector(creatExe:)];
    self.navigationItem.rightBarButtonItem = right;
    self.view.backgroundColor = JMColor(240, 240, 240);
}

- (void)creatExe:(UIBarButtonItem *)item
{
    
}
- (UIImage *)creatQRCodeImage:(NSString *)text
{
    return [MMScanViewController createQRImageWithString:text QRSize:CGSizeMake(kW, kW)];
}

- (UIImage *)creatBRCodeImage:(NSString *)text
{
    return [MMScanViewController createBarCodeImageWithString:text barSize:CGSizeMake(kW, kW-100)];
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
