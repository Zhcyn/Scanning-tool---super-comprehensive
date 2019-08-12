//
//  JMTBarCodeViewController.m
//  JMORCode
//
//  Created by 赵俊明 on 2017/11/25.
//  Copyright © 2017年 JunMing. All rights reserved.
//

#import "JMTBarCodeViewController.h"

@interface JMTBarCodeViewController ()<UITextFieldDelegate>
@property (nonatomic, weak) UITextField *editerView;
@end

@implementation JMTBarCodeViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
//    self.navigationController.navigationBar.barStyle = UIBarStyleDefault;
//    self.navigationController.navigationBar.tintColor = JMColor(41, 41, 41);
//    NSDictionary *attr = @{
//                           NSForegroundColorAttributeName : JMColor(41, 41, 41),
//                           NSFontAttributeName : [UIFont boldSystemFontOfSize:18.0]
//                           };
//    self.navigationController.navigationBar.titleTextAttributes = attr;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = NSLocalizedString(@"orscan.items.BarCode", "");
    UITextField *editerView = [[UITextField alloc] initWithFrame:CGRectMake(0, 84, kW, 44)];
    editerView.delegate = self;
    editerView.layer.cornerRadius = 5;
    editerView.layer.masksToBounds = YES;
    editerView.clearButtonMode = UITextFieldViewModeWhileEditing;
    editerView.keyboardType = UIKeyboardTypeNumberPad;
    editerView.backgroundColor = [UIColor whiteColor];
    editerView.placeholder = NSLocalizedString(@"orscan.items.scanInputNumber", "");
    [self.view addSubview:editerView];
    self.editerView = editerView;
    
    [editerView becomeFirstResponder];
}

- (void)creatExe:(UIBarButtonItem *)item
{
    self.endString = _editerView.text.length>120?[_editerView.text substringWithRange:NSMakeRange(0, 120)]:_editerView.text;
    if (self.endString>0) {
        
        UIImage *image = [self creatBRCodeImage:self.endString];
        UIStoryboard *store = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        JMTSaveCodeViewController *save = [store instantiateViewControllerWithIdentifier:@"codeView"];
        save.image = image;
        [self.navigationController pushViewController:save animated:YES];
    }
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    self.endString = _editerView.text.length>120?[textField.text substringWithRange:NSMakeRange(0, 120)]:_editerView.text;
    NSLog(@"end-%@", self.endString);
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
