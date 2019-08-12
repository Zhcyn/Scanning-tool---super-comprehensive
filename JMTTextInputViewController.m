#import "JMTTextInputViewController.h"
#import "JMTTextView.h"

@interface JMTTextInputViewController ()<UITextViewDelegate>
@property (nonatomic, weak) JMTTextView *editerView;
@end

@implementation JMTTextInputViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    JMTTextView *textView = [[JMTTextView alloc] initWithFrame:CGRectMake(10, 84, kW-20, kH/2-80)];
    textView.playholed.text = self.playholder;
    textView.delegate = (id)self;
    textView.font = [UIFont fontWithName:@"Arial" size:16.5f];
    textView.textColor = JMBaseColor;
    textView.backgroundColor = [UIColor whiteColor];
    textView.textAlignment = NSTextAlignmentLeft;
    textView.autocorrectionType = UITextAutocorrectionTypeNo;
    [self.view addSubview:textView];
    self.editerView = textView;
    
    [textView becomeFirstResponder];
}

- (void)creatExe:(UIBarButtonItem *)item
{
    self.endString = _editerView.text.length>120?[_editerView.text substringWithRange:NSMakeRange(0, 120)]:_editerView.text;
    if (self.endString>0) {
        
        UIImage *image = [self creatQRCodeImage:self.endString];
        UIStoryboard *store = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        JMTSaveCodeViewController *save = [store instantiateViewControllerWithIdentifier:@"codeView"];
        save.image = image;
        [self.navigationController pushViewController:save animated:YES];
    }
}

// UITextFieldDelegate
- (void)textViewDidEndEditing:(UITextView *)textView
{
    self.endString = _editerView.text.length>120?[textView.text substringWithRange:NSMakeRange(0, 120)]:_editerView.text;
    NSLog(@"end-%@", self.endString);
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
