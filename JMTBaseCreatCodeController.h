//
//  JMTBaseCreatCodeController.h
//  JMORCode
//
//  Created by JM Zhao on 2017/11/24.
//  Copyright © 2017年 JunMing. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MMScanViewController.h"
#import "JMTSaveCodeViewController.h"

@interface JMTBaseCreatCodeController : UIViewController
@property (nonatomic, strong) UIImage *codeImage;
@property (nonatomic, copy) NSString *playholder;
@property (nonatomic, copy) NSString *endString;
- (UIImage *)creatQRCodeImage:(NSString *)text;
- (UIImage *)creatBRCodeImage:(NSString *)text;
@end
