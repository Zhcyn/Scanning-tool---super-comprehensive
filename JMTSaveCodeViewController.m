#import "JMTSaveCodeViewController.h"


@interface JMTSaveCodeViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *shareImage;
@end

@implementation JMTSaveCodeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = JMColor(240, 240, 240);
    _shareImage.image = _image;
    _shareImage.contentMode = UIViewContentModeScaleAspectFit;
    
    UIBarButtonItem *right = [[UIBarButtonItem alloc] initWithTitle:NSLocalizedString(@"gif.base.alert.done", "") style:(UIBarButtonItemStyleDone) target:self action:@selector(doneExe:)];
    self.navigationItem.rightBarButtonItem = right;
}

- (void)doneExe:(UIBarButtonItem *)item
{
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (IBAction)share:(id)sender {
    [self shareToFriends];
}

- (IBAction)save:(id)sender {
    UIImageWriteToSavedPhotosAlbum(_image, self, @selector(image:didFinishSavingWithError:contextInfo:), (__bridge void *)self);
}

- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo
{
    NSLog(@"image = %@, error = %@, contextInfo = %@", image, error, contextInfo);
    if(error) {
        [self showInfo:[NSString stringWithFormat:@"error: %@",error]];
    } else {
        [self showInfo:NSLocalizedString(@"gif.base.alert.success", "")];
    }
}

#pragma mark - Error handle
- (void)showInfo:(NSString*)str {
    [self showInfo:str andTitle:NSLocalizedString(@"gif.base.alert.alert", "")];
}

- (void)showInfo:(NSString*)str andTitle:(NSString *)title
{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:title message:str preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction* actionCancel = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
    }];
    
    [alert addAction:actionCancel];
    
    [self presentViewController:alert animated:YES completion:NULL];
}

- (void)shareToFriends {
    NSMutableArray *items = [NSMutableArray array];
    if (_image) {
        
        NSString *appName = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleName"];
        [items addObject:[NSString stringWithFormat:@"#%@#", appName]];
        [items addObject:_image];
    }
    UIActivityViewController *activityViewController = [[UIActivityViewController alloc] initWithActivityItems:items applicationActivities:nil];
    NSMutableArray *excludedActivityTypes =  [NSMutableArray arrayWithArray:@[ UIActivityTypeCopyToPasteboard]];
    activityViewController.excludedActivityTypes = excludedActivityTypes;
    [self presentViewController:activityViewController animated:YES completion:nil];
    
    if (IS_IPAD) {
        
        UIPopoverPresentationController *popover = activityViewController.popoverPresentationController;
        
        if (popover){
            popover.sourceView = self.navigationController.navigationBar;
            popover.sourceRect = self.navigationController.navigationBar.bounds;
            popover.permittedArrowDirections = UIPopoverArrowDirectionUp;
        }
    }
    
    activityViewController.completionWithItemsHandler = ^(UIActivityType  _Nullable activityType, BOOL completed, NSArray * _Nullable returnedItems, NSError * _Nullable activityError) {
        
        NSString *title = completed?NSLocalizedString(@"gif.base.alert.success", ""):NSLocalizedString(@"gif.base.alert.Failed", "");
        UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:title message:@"" preferredStyle:UIAlertControllerStyleAlert];
        [self presentViewController:alertVC animated:YES completion:nil];
    };
}

@end
