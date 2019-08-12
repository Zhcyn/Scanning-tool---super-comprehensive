//
//  MORCodeController.m
//  JMORCode
//
//  Created by JM Zhao on 2017/11/21.
//  Copyright © 2017年 JunMing. All rights reserved.
//

#import "MORCodeController.h"
#import "MMScanViewController.h"
#import "JMDrawQrCoderController.h"
#import "JMDrawBarCoderController.h"
#import "JMTPuzzleMenuView.h"
#import "MAboutUsController.h"
#import "MBaseWebViewController.h"
#import "JMQRCodeCollectionController.h"
#import "JMTBarCodeViewController.h"
#import "JMTQRCodeCollectionViewCell.h"
#import "JMTQRCodeCollModel.h"


@interface MORCodeController ()<UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout>
@property (nonatomic, weak) UICollectionView *collection;
@property (nonatomic, strong) NSMutableArray *dataSource;

@end

@implementation MORCodeController
static NSString *const oneRowID = @"threeRow";

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

- (int)getRandom:(int)from to:(int)to
{
    return (int)(from + (arc4random() % (to-from + 1)));
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.dataSource = [self creatModels];
    self.title = NSLocalizedString(@"orscan.items.scan", "");
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

#pragma mark - Error handle
- (void)showInfo:(NSString*)str isQ:(BOOL)isQ {
    
    [self showInfo:str andTitle:NSLocalizedString(@"gif.base.alert.alert", "") isQ:isQ];
}

- (void)showInfo:(NSString*)str andTitle:(NSString *)title isQ:(BOOL)isQ
{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:title message:str preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *action1 = [UIAlertAction actionWithTitle:NSLocalizedString(@"orscan.items.copy", "") style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
        pasteboard.string = str;
        UIAlertController *al = [UIAlertController alertControllerWithTitle:NSLocalizedString(@"orscan.items.copySuccess", "") message:@"" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *ac = [UIAlertAction actionWithTitle:NSLocalizedString(@"gif.base.alert.sure", "") style:UIAlertActionStyleDefault handler:nil];
        [al addAction:ac];
        [self presentViewController:al animated:YES completion:NULL];
    }];
    
    UIAlertAction *action2 = [UIAlertAction actionWithTitle:isQ?NSLocalizedString(@"orscan.items.open", ""):NSLocalizedString(@"gif.base.alert.sure", "") style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        if (isQ) {
            MBaseWebViewController *drawVC = [[MBaseWebViewController alloc] init];
            drawVC.title = NSLocalizedString(@"gif.set.sectionOne.rowZero", "");
            drawVC.urlString = str;
            [self.navigationController pushViewController:drawVC animated:YES];
        }
    }];

    [alert addAction:action2];
    [alert addAction:action1];
    [self presentViewController:alert animated:YES completion:NULL];
}

/////////////////////////
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    JMTQRCodeCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:oneRowID forIndexPath:indexPath];
    cell.model = _dataSource[indexPath.row];
    return cell;
}

#pragma mark UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        MMScanViewController *scanVc = [[MMScanViewController alloc] initWithQrType:MMScanTypeAll onFinish:^(NSString *result, NSError *error) {
            if (error) {
                NSLog(@"error: %@",error);
            } else {
                //                NSLog(@"扫描结果：%@",result);
                NSArray *codes = [result componentsSeparatedByString:@">"];
                BOOL isQ = [codes.firstObject isEqualToString:@"Q"];
                [self showInfo:codes.lastObject isQ:isQ];
            }
        }];
        [self.navigationController pushViewController:scanVc animated:YES];
    } else if (indexPath.row == 1) {

        MMScanViewController *scanVc = [[MMScanViewController alloc] initWithQrType:MMScanTypeQrCode onFinish:^(NSString *result, NSError *error) {
            if (error) {
                NSLog(@"error: %@",error);
            } else {
                //                NSLog(@"扫描结果：%@",result);
                [self showInfo:result isQ:YES];
            }
        }];
        [self.navigationController pushViewController:scanVc animated:YES];
    } else if (indexPath.row == 2) {
        MMScanViewController *scanVc = [[MMScanViewController alloc] initWithQrType:MMScanTypeBarCode onFinish:^(NSString *result, NSError *error) {
            if (error) {
                NSLog(@"error: %@",error);
            } else {
                //                NSLog(@"扫描结果：%@",result);
                [self showInfo:result isQ:NO];
            }
        }];
        [self.navigationController pushViewController:scanVc animated:YES];
    } else if (indexPath.row == 3) {
        JMQRCodeCollectionController *qrCode = [[JMQRCodeCollectionController alloc] init];
        [self.navigationController pushViewController:qrCode animated:YES];
        
    } else if (indexPath.row == 4) {

        JMTBarCodeViewController *drawBarVC = [[JMTBarCodeViewController alloc] init];
        [self.navigationController pushViewController:drawBarVC animated:YES];
    }else{
        MAboutUsController *about = [[MAboutUsController alloc] init];
        [self.navigationController pushViewController:about animated:YES];
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
    return CGSizeMake((kW-30)/2, (kH-40-64)/3);
}

// 动态设置每个分区的EdgeInsets
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(10, 10, 10, 10);
}

// 动态设置每行的间距大小
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 10;
}

// 动态设置每列的间距大小
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 10;
}

- (NSMutableArray *)creatModels
{
    NSMutableArray *models = [NSMutableArray array];
    NSArray *dics = @[@{@"title":NSLocalizedString(@"orscan.items.scan", ""), @"image":@"ScanCode"}, @{@"title":NSLocalizedString(@"orscan.items.scanQRCode", ""), @"image":@"scanqrCode"}, @{@"title":NSLocalizedString(@"orscan.items.scanBarCode", ""), @"image":@"scanbarCode"}, @{@"title":NSLocalizedString(@"orscan.items.creatQRCode", ""), @"image":@"QRCode"}, @{@"title":NSLocalizedString(@"orscan.items.creatBarCode", ""), @"image":@"BarCoder"},@{@"title":NSLocalizedString(@"orscan.items.AboutUS", ""), @"image":@"AboutUS"}];
    
    for (NSDictionary *dic in dics) {
        JMTQRCodeCollModel *model = [JMTQRCodeCollModel new];
        model.title = dic[@"title"];
        model.image = dic[@"image"];
        [models addObject:model];
    }
    return models;
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
