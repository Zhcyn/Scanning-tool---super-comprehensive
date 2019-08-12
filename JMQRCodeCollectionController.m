//
//  JMQRCodeCollectionController.m
//  JMORCode
//
//  Created by JM Zhao on 2017/11/24.
//  Copyright © 2017年 JunMing. All rights reserved.
//

#import "JMQRCodeCollectionController.h"
#import "JMTQRCodeCollModel.h"
#import "JMTQRCodeCollectionViewCell.h"
#import "JMTNumberInputViewController.h"
#import "UINavigationBar+Awesome.h"
#import "JMtEmailInputViewController.h"
#import "JMTTextInputViewController.h"


@interface JMQRCodeCollectionController ()<UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout>

@property (nonatomic, weak) UICollectionView *collection;
@property (nonatomic, strong) NSMutableArray *dataSource;
@end

@implementation JMQRCodeCollectionController

static NSString *const oneRowID = @"threeRow";

- (NSMutableArray *)dataSource
{
    if (!_dataSource) { self.dataSource = [NSMutableArray array];}
    return _dataSource;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    self.title = NSLocalizedString(@"orscan.items.ORCode", "");
    NSArray *aray = @[@{@"title":NSLocalizedString(@"orscan.items.scanCreatCodeText", ""), @"image":@"text"}, @{@"title":NSLocalizedString(@"orscan.items.scanCreatCodeEmail", ""),@"image":@"email"}, @{@"title":NSLocalizedString(@"orscan.items.scanCreatCodeWebSite", ""), @"image":@"website"}, @{@"title":NSLocalizedString(@"orscan.items.scanCreatCodePhoneNumber", ""), @"image":@"phone"}, @{@"title":NSLocalizedString(@"orscan.items.scanCreatCodeNameDis", ""), @"image":@"namei"}, @{@"title":NSLocalizedString(@"orscan.items.scanCreatCodeWIFI", ""), @"image":@"WiFi"}, @{@"title":NSLocalizedString(@"orscan.items.scanCreatCodeLocalN", ""), @"image":@"local"}, @{@"title":NSLocalizedString(@"orscan.items.scanCreatCodePwd", ""), @"image":@"mima"}];
    
    for (NSDictionary *dic in aray) {
        JMTQRCodeCollModel *model = [[JMTQRCodeCollModel alloc] init];
        model.title = dic[@"title"];
        model.image = dic[@"image"];
        [self.dataSource addObject:model];
    }
    UICollectionViewFlowLayout *collectionLayout = [[UICollectionViewFlowLayout alloc] init];
    UICollectionView *collection = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:collectionLayout];
    collection.backgroundColor = JMTabViewBaseColor;
    collection.dataSource = self;
    collection.delegate = self;
    collection.showsVerticalScrollIndicator = NO;
    [collection registerClass:[JMTQRCodeCollectionViewCell class] forCellWithReuseIdentifier:oneRowID];
    [self.view addSubview:collection];
    self.collection = collection;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    JMTQRCodeCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:oneRowID forIndexPath:indexPath];
    cell.model = self.dataSource[indexPath.row];
    return cell;
}

- (int)getRandomNumber:(int)from to:(int)to
{
    return (int)(from + (arc4random() % (to-from+1)));
}

#pragma mark UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    int nu = [self getRandomNumber:0 to:4];
    NSString *str = [NSString stringWithFormat:@"scanCodeCreat_%ld", indexPath.row+1];
    if (indexPath.row == 0) {
     
        JMTTextInputViewController *textinput = [JMTTextInputViewController new];
        textinput.title = NSLocalizedString(@"orscan.items.scanCreatCodeText", "");
        textinput.playholder = NSLocalizedString(@"orscan.items.scanCreatCodeInputText", "");
        [self.navigationController pushViewController:textinput animated:YES];
    
    }else if (indexPath.row == 1){
        
        JMtEmailInputViewController *textinput = [JMtEmailInputViewController new];
        textinput.title = NSLocalizedString(@"orscan.items.scanCreatCodeEmail", "");
        textinput.playholder = NSLocalizedString(@"orscan.items.scanCreatCodeInputEmail", "");
        [self.navigationController pushViewController:textinput animated:YES];
        
    }else if (indexPath.row == 2){
     
        JMTTextInputViewController *textinput = [JMTTextInputViewController new];
        textinput.title = NSLocalizedString(@"orscan.items.scanCreatCodeWebSite", "");
        textinput.playholder = NSLocalizedString(@"orscan.items.scanCreatCodeInputWebSite", "");
        [self.navigationController pushViewController:textinput animated:YES];
        
    }else if (indexPath.row == 3){
        
        JMTNumberInputViewController *textinput = [JMTNumberInputViewController new];
        textinput.title = NSLocalizedString(@"orscan.items.scanCreatCodePhoneNumber", "");
        textinput.playholder = NSLocalizedString(@"orscan.items.scanCreatCodeInputPhoneNumber", "");
        [self.navigationController pushViewController:textinput animated:YES];
        
    }else if (indexPath.row == 4){
        
        JMTNumberInputViewController *textinput = [JMTNumberInputViewController new];
        textinput.title = NSLocalizedString(@"orscan.items.scanCreatCodeNameDis", "");
        textinput.playholder = NSLocalizedString(@"orscan.items.scanCreatCodeInputNameDis", "");
        [self.navigationController pushViewController:textinput animated:YES];
        
    }else if (indexPath.row == 5){
        
        JMTNumberInputViewController *textinput = [JMTNumberInputViewController new];
        textinput.title = NSLocalizedString(@"orscan.items.scanCreatCodeWIFI", "");
        textinput.playholder = NSLocalizedString(@"orscan.items.scanCreatCodeInputWifiPwd", "");
        [self.navigationController pushViewController:textinput animated:YES];
        
    }else if (indexPath.row == 6){
        
        JMTNumberInputViewController *textinput = [JMTNumberInputViewController new];
        textinput.title = NSLocalizedString(@"orscan.items.scanCreatCodeLocalN", "");
        textinput.playholder = NSLocalizedString(@"orscan.items.scanCreatCodeInputLocalN", "");
        [self.navigationController pushViewController:textinput animated:YES];
        
    }else if (indexPath.row == 7){
        
        JMTNumberInputViewController *textinput = [JMTNumberInputViewController new];
        textinput.title = NSLocalizedString(@"orscan.items.scanCreatCodePwd", "");
        textinput.playholder = NSLocalizedString(@"orscan.items.scanCreatCodeInputPwd", "");
        [self.navigationController pushViewController:textinput animated:YES];
        
    }else if (indexPath.row == 8){
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
        dispatch_async(dispatch_get_global_queue(QOS_CLASS_USER_INITIATED, 0), ^{
            
            sleep(1);
            dispatch_async(dispatch_get_main_queue(), ^{
                
                [hud hideAnimated:YES];
            });
        });
    }
}

#pragma mark UICollectionViewDataSource,
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.dataSource.count;
}

#pragma mark UICollectionViewDelegateFlowLayout
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake((kW-8)/3, (kH-8-64)/3);
}

// 动态设置每个分区的EdgeInsets
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(0, 2, 2, 2);
}

// 动态设置每行的间距大小
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 2;
}

// 动态设置每列的间距大小
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 2;
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
