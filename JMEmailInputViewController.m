//
//  JMtEmailInputViewController.m
//  JMORCode
//
//  Created by 赵俊明 on 2017/11/25.
//  Copyright © 2017年 JunMing. All rights reserved.
//

#import "JMtEmailInputViewController.h"
#import "JMTextView.h"

@interface JMtEmailInputViewController ()<UITextFieldDelegate, UITextViewDelegate>
@property (nonatomic, weak) JMTextView *editerView;
@property (nonatomic, weak) UITextField *content;
@end

@implementation JMtEmailInputViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UITextField *content = [[UITextField alloc] initWithFrame:CGRectMake(10, 74, kW-20, 40)];
    content.delegate = self;
    content.layer.cornerRadius = 5;
    content.layer.masksToBounds = YES;
    content.clearButtonMode = UITextFieldViewModeWhileEditing;
    content.keyboardType = UIKeyboardTypeNumberPad;
    content.backgroundColor = [UIColor whiteColor];
    content.placeholder = self.playholder;
    [self.view addSubview:content];
    self.content = content;
    
    JMTextView *textView = [[JMTextView alloc] initWithFrame:CGRectMake(10, CGRectGetMaxY(content.frame)+10, kW-20, kH-124-280)];
    textView.playholed.text = self.playholder;
    textView.delegate = (id)self;
    textView.font = [UIFont fontWithName:@"Arial" size:16.5f];
    textView.textColor = JMBaseColor;
    textView.backgroundColor = [UIColor whiteColor];
    textView.textAlignment = NSTextAlignmentLeft;
    textView.autocorrectionType = UITextAutocorrectionTypeNo;
    [self.view addSubview:textView];
    self.editerView = textView;
    
    [content becomeFirstResponder];
}

- (void)creatExe:(UIBarButtonItem *)item
{
    NSString *string = _editerView.text.length>120?[_content.text substringWithRange:NSMakeRange(0, 120)]:_editerView.text;
    self.endString = [NSString stringWithFormat:@"%@&&%@", _content.text, string];
    if (self.endString>0) {
        
        UIStoryboard *store = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        JMSaveCodeViewController *save = [store instantiateViewControllerWithIdentifier:@"codeView"];
        save.image = [self creatQRCodeImage:self.endString];
        [self.navigationController pushViewController:save animated:YES];
    }
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    NSString *string = _editerView.text.length>120?[textField.text substringWithRange:NSMakeRange(0, 120)]:_editerView.text;
    self.endString = [NSString stringWithFormat:@"%@&&%@", _content.text, string];
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    _editerView.content = [NSString stringWithFormat:@"%ld", 119-textView.text.length];
    NSLog(@"should-%@", _editerView.content);
    return YES;
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
