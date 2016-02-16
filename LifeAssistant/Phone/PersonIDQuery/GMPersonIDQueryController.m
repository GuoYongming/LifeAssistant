//
//  GMPersonIDQueryController.m
//  LifeAssistant
//
//  Created by GuoYongming on 2/16/16.
//  Copyright © 2016 GuoYongming. All rights reserved.
//

#import "GMPersonIDQueryController.h"
#import "GMPersonIDQueryProvider.h"

@interface GMPersonIDQueryController ()
@property (weak, nonatomic) IBOutlet UITextField *inputTF;
@property (weak, nonatomic) IBOutlet UIButton *queryBtn;
@property (weak, nonatomic) IBOutlet UITextView *resultTV;
@property (weak, nonatomic) IBOutlet UISegmentedControl *segmentControl;
@property (nonatomic, strong) GMPersonIDQueryProvider *personIDInfoProvider;
@property (nonatomic, strong) GMPersonIDQueryProvider *personIDLeakProvider;
@property (nonatomic, strong) GMPersonIDQueryProvider *personIDLossProvider;
@end

@implementation GMPersonIDQueryController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"身份证查询";
    self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    self.queryBtn.layer.cornerRadius = 6;
    self.queryBtn.layer.masksToBounds = YES;
    
    self.inputTF.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 8, 0)];
    self.inputTF.leftViewMode = UITextFieldViewModeAlways;
    
    self.personIDInfoProvider = [[GMPersonIDQueryProvider alloc] initWithDelegate:self];
    self.personIDLeakProvider = [[GMPersonIDQueryProvider alloc] initWithDelegate:self];
    self.personIDLossProvider = [[GMPersonIDQueryProvider alloc] initWithDelegate:self];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)didChangedSegmentItem:(UISegmentedControl *)sender {
    self.resultTV.text = @"";
}
- (IBAction)queryAction:(UIButton *)sender {
    if ([self.inputTF isFirstResponder]) {
        [self.inputTF resignFirstResponder];
    }
    
    NSString *newPersonID = [self.inputTF.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    if (![[GMAccessManager sharedManager] validateIdentityCard:newPersonID]) {
        [[[UIAlertView alloc] initWithTitle:@"提示" message:@"请输入正确的身份证号码" delegate:nil cancelButtonTitle:@"好的" otherButtonTitles:nil, nil] show];
        return;
    }
    
    if (self.segmentControl.selectedSegmentIndex == 0) {
        [self.personIDInfoProvider fetchPersonIDDetailInfoDataWithPersonId:newPersonID];
        [self showFullIndicator];
    }else if (self.segmentControl.selectedSegmentIndex == 1){
        [self.personIDLeakProvider fetchPersonIDLeakInfoDataWithPersonId:newPersonID];
        [self showFullIndicator];
    }else{
        [self.personIDLossProvider fetchPersonIDLossInfoDataWithPersonId:newPersonID];
        [self showFullIndicator];
    }
}

- (void)outPutPersonDetailResultWithPersonID:(GMPerson *)personID
{
    if (personID) {
        NSString *result = [NSString stringWithFormat:@"地区：%@\n\n性别：%@\n\n生日：%@",personID.personArea,personID.personSex,personID.personBirthday];
        self.resultTV.text = result;
    }
}

- (void)outPutPersonLeakResultWithPersonID:(GMPerson *)personID
{
    if (personID) {
        NSString *result = [NSString stringWithFormat:@"是否安全：%@\n\n",personID.personIDLeak];
        self.resultTV.text = result;
    }
}

- (void)outPutPersonLossResultWithPersonID:(GMPerson *)personID
{
    if (personID) {
        NSString *result = [NSString stringWithFormat:@"是否挂失：%@\n\n",personID.personIDLoss];
        self.resultTV.text = result;
    }
}

#pragma mark - GMDataProviderDelegate

- (void)requestSuccess:(GMDataProvider *)provider
{
    [self hideFullIndicator];
    if (provider == self.personIDInfoProvider) {
        [self outPutPersonDetailResultWithPersonID:self.personIDInfoProvider.personID];
    }else if (provider == self.personIDLeakProvider){
        [self outPutPersonLeakResultWithPersonID:self.personIDLeakProvider.personID];
    }else if (provider == self.personIDLossProvider){
        [self outPutPersonLossResultWithPersonID:self.personIDLossProvider.personID];
    }
}

- (void)requestFailed:(GMDataProvider *)provider
{
    [self hideFullIndicator];
}

@end
