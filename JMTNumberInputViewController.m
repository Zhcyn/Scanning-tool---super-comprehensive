#import "JMTNumberInputViewController.h"

@interface JMTNumberInputViewController ()<UITextFieldDelegate>
@property (nonatomic, weak) UITextField *editerView;
@end

@implementation JMTNumberInputViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UITextField *editerView = [[UITextField alloc] initWithFrame:CGRectMake(10, 84, kW-20, 44)];
    editerView.delegate = self;
    editerView.layer.cornerRadius = 5;
    editerView.layer.masksToBounds = YES;
    editerView.clearButtonMode = UITextFieldViewModeWhileEditing;
    editerView.keyboardType = UIKeyboardTypeNumberPad;
    editerView.backgroundColor = [UIColor whiteColor];
    editerView.placeholder = self.playholder;
    [self.view addSubview:editerView];
    [editerView becomeFirstResponder];
    self.editerView = editerView;
}

- (void)creatExe:(UIBarButtonItem *)item
{
    self.endString = _editerView.text.length>120?[_editerView.text substringWithRange:NSMakeRange(0, 120)]:_editerView.text;
    if (_editerView.text.length>0) {
        
        UIImage *image = [self creatQRCodeImage:self.endString];
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
