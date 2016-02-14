//
//  GMPhoneLocationViewController.m
//  LifeAssistant
//
//  Created by GuoYongming on 1/28/16.
//  Copyright © 2016 GuoYongming. All rights reserved.
//

#import "GMPhoneLocationViewController.h"
#import "GMPhoneLocationProvider.h"
#include "AppDelegate.h"

@interface GMPhoneLocationViewController ()
@property (weak, nonatomic) IBOutlet UITextField *phoneNumberTF;
@property (weak, nonatomic) IBOutlet UIButton *searchBtn;
@property (weak, nonatomic) IBOutlet UITextView *resultTextView;

@property (nonatomic, strong) GMPhoneLocationProvider *phoneLocationProvider;

@end

@implementation GMPhoneLocationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"手机归属地查询";
    self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    self.searchBtn.layer.cornerRadius = 6;
    self.searchBtn.layer.masksToBounds = YES;
    
    self.phoneNumberTF.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 8, 0)];
    self.phoneNumberTF.leftViewMode = UITextFieldViewModeAlways;
    
    self.phoneLocationProvider = [[GMPhoneLocationProvider alloc] initWithDelegate:self];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - private method
- (IBAction)searchPhoneNumberLocationInfo:(UIButton *)sender {
    if ([self.phoneNumberTF isFirstResponder]) {
        [self.phoneNumberTF resignFirstResponder];
    }
    [self showFullIndicator];
    
    [self.phoneLocationProvider fetchPhoneLocationDataWithPhoneNumber:self.phoneNumberTF.text];
}

- (void)outPutResult
{
    GMPhoneInfo *phoneInfo = self.phoneLocationProvider.phoneInfo;
    NSString *result = [NSString stringWithFormat:@"归属地：%@%@\n\n区号：%@\n\n邮编：%@\n\n运营商：%@\n\n卡类型：%@",phoneInfo.province, phoneInfo.city, phoneInfo.areaCode, phoneInfo.zipCode, phoneInfo.company, phoneInfo.cardType];
    self.resultTextView.text = result;
}

#pragma mark - GMDataProviderDelegate

- (void)requestSuccess:(GMDataProvider *)provider
{
    [self hideFullIndicator];
    if (provider == self.phoneLocationProvider) {
        [self outPutResult];
    }
}

- (void)requestFailed:(GMDataProvider *)provider
{
    [self hideFullIndicator];
}

@end
