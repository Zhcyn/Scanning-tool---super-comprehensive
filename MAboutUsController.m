//
//  MAboutUsController.m
//  YaoYao
//
//  Created by JM Zhao on 2016/11/30.
//  Copyright © 2016年 JunMingZhaoPra. All rights reserved.
//

#import "MAboutUsController.h"
#import "JMTUserDefault.h"
#import "UIView+Extension.h"
#import "UINavigationBar+Awesome.h"
#import "JMTAboutCell.h"
#import "JMTAboutModel.h"
#import "JMTAccountHeaderFooter.h"
#import "JMTAboutHeaderView.h"


@interface MAboutUsController ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, weak) UIView *titleView;
@property (nonatomic, weak) UITableView *tabView;
@property (nonatomic, strong) NSArray *dataSource;
@end

@implementation MAboutUsController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
//    self.navigationController.navigationBar.tintColor = JMColor(41, 41, 41);
//    self.navigationController.navigationBar.barStyle = UIBarStyleDefault;
//    NSDictionary *attr = @{
//                           NSForegroundColorAttributeName : JMColor(41, 41, 41),
//                           NSFontAttributeName : [UIFont boldSystemFontOfSize:18.0]
//                           };
//    self.navigationController.navigationBar.titleTextAttributes = attr;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = NSLocalizedString(@"gif.set.navigation.title", "");
    self.view.backgroundColor = JMColor(240, 240, 240);
    [self loadDataSource];
    [self setUI];
}

- (void)setUI
{
    JMTAboutHeaderView *header = [[JMTAboutHeaderView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, self.view.width*0.45)];
    UITableView *tabView = [[UITableView alloc] initWithFrame:self.view.bounds style:(UITableViewStyleGrouped)];
    [tabView registerClass:[JMTAboutCell class] forCellReuseIdentifier:@"aboutCell"];
    tabView.delegate = self;
    tabView.dataSource = self;
    tabView.sectionHeaderHeight = 0;
    tabView.sectionFooterHeight = 0;
    tabView.separatorColor = tabView.backgroundColor;
    tabView.tableHeaderView = header;
    [self.view addSubview:tabView];
    if ([[UIDevice currentDevice].systemVersion doubleValue] >= 9.0){tabView.cellLayoutMarginsFollowReadableWidth = NO;}
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return section == 0?0:35;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    JMTAccountHeaderFooter *headView = [JMTAccountHeaderFooter headViewWithTableView:tableView];
    if (section == 1) {headView.name.text = NSLocalizedString(@"gif.set.header.SectionThree", "");}
    return headView;
}

#pragma mark -- UITableViewDelegate, UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.dataSource[section] count];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *ID = @"aboutCell";

    JMTAboutCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {cell = [[JMTAboutCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:ID];}
    cell.model = self.dataSource[indexPath.section][indexPath.row];

    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        [self customerFeedback];
        
    }else if ( indexPath.row == 1){
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:AppiTunesID_ScanCode]];
        
    }else if ( indexPath.row == 2){
        NSMutableArray *items = [[NSMutableArray alloc] init];
        [items addObject:@"ScanCode"];
        [items addObject:[NSURL URLWithString:AppiTunesID_ScanCode]];
        
        UIActivityViewController *activityViewController = [[UIActivityViewController alloc] initWithActivityItems:items applicationActivities:nil];
        NSMutableArray *excludedActivityTypes =  [NSMutableArray arrayWithArray:@[UIActivityTypeAirDrop, UIActivityTypeCopyToPasteboard, UIActivityTypeAssignToContact, UIActivityTypePrint, UIActivityTypeMail, UIActivityTypePostToTencentWeibo, UIActivityTypeSaveToCameraRoll, UIActivityTypeMessage, UIActivityTypePostToTwitter]];
        activityViewController.excludedActivityTypes = excludedActivityTypes;
        [self presentViewController:activityViewController animated:YES completion:nil];
        activityViewController.completionWithItemsHandler = ^(UIActivityType __nullable activityType, BOOL completed, NSArray * __nullable returnedItems, NSError * __nullable activityError){
            
            NSLog(@"%@  ----   %@", activityType, returnedItems);
        };

    }
}

// 用户反馈
- (void)customerFeedback
{
    NSMutableString *mailUrl = [[NSMutableString alloc] init];
    
    //添加收件人
    NSArray *toRecipients = [NSArray arrayWithObject: @"jsonkeny@gmail.com "];
    [mailUrl appendFormat:@"mailto:%@", [toRecipients componentsJoinedByString:@","]];
    
    //添加抄送
    NSArray *ccRecipients = [NSArray arrayWithObjects:@"jsonkeny@gmail.com ", nil];
    [mailUrl appendFormat:@"?cc=%@", [ccRecipients componentsJoinedByString:@","]];

    //添加密送
    NSArray *bccRecipients = [NSArray arrayWithObjects:@"jsonkeny@gmail.com ", nil];
    [mailUrl appendFormat:@"&bcc=%@", [bccRecipients componentsJoinedByString:@","]];
    
    // 添加主题
    [mailUrl appendString:@"&subject=Feedback"];
    
    NSString *appName = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleName"];
    NSString *sysVersion= [[UIDevice currentDevice] systemVersion];
    NSString *device = [[UIDevice currentDevice] model];
    NSString *buildID = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleVersion"];
    NSString *appVersionID = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"];
    
    NSString *emailString = [NSString stringWithFormat:@"&body=<b>Name: %@, Type: %@, version: %@, build version: %@, appVersion: %@</b>", appName, device, sysVersion, buildID, appVersionID];
    [mailUrl appendString:emailString];
    
    
    NSCharacterSet *set = [NSCharacterSet characterSetWithCharactersInString:@"`#%^{}\"[]|\\<> "].invertedSet;
    NSString *email = [mailUrl stringByAddingPercentEncodingWithAllowedCharacters:set];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:email]];
}

- (void)back
{
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}

- (void)loadDataSource
{
    NSArray *secOne = @[NSLocalizedString(@"gif.set.aboutUs.rowZero", ""), NSLocalizedString(@"gif.set.aboutUs.rowOne", ""), NSLocalizedString(@"gif.set.aboutUs.rowTwo", "")];
    
    
    NSMutableArray *secOneArr = [NSMutableArray array];
    for (NSString *titles in secOne) {
        
        JMTAboutModel *model = [[JMTAboutModel alloc] init];
        model.title = titles;
        model.isShowImage = NO;
        [secOneArr addObject:model];
    }
    
    self.dataSource = @[secOneArr];
}
@end
