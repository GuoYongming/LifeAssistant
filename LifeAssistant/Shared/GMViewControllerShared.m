//
//  GMViewControllerShared.m
//  LifeAssistant
//
//  Created by GuoYongming on 1/22/16.
//  Copyright © 2016 GuoYongming. All rights reserved.
//

#import "GMViewControllerShared.h"

@interface GMViewControllerShared ()
@property (nonatomic, strong) GMIndicatorView *indicator;
@end

@implementation GMViewControllerShared

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.edgesForExtendedLayout = UIRectEdgeNone;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)showFullIndicator
{
    if (!self.indicator) {
        self.indicator = [[GMIndicatorView alloc] initWithFrame:self.view.bounds];
        [self.view addSubview:self.indicator];
    }
}

- (void)hideFullIndicator
{
    if (self.indicator) {
        [self.indicator removeFromSuperview];
    }
}

- (void)setExtraCellLineHidden:(UITableView *)tableView
{
    UIView *view = [[UIView alloc] init];
    view.backgroundColor = [UIColor whiteColor];
    tableView.tableFooterView = view;
}

- (void)setExtendedCellLineToLeft:(UITableView *)tableView
{
    if ([tableView respondsToSelector:@selector(setSeparatorInset:)]) {
        [tableView setSeparatorInset:UIEdgeInsetsZero];
    }
    if ([tableView respondsToSelector:@selector(setLayoutMargins:)]) {
        [tableView setLayoutMargins:UIEdgeInsetsZero];
    }
}

-(void)requestSuccess:(GMDataProvider *)provider
{
    
}

-(void)requestFailed:(GMDataProvider *)provider
{
    
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
