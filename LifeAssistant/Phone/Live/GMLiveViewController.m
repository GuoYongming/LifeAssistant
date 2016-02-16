//
//  GMLiveViewController.m
//  LifeAssistant
//
//  Created by GuoYongming on 1/25/16.
//  Copyright © 2016 GuoYongming. All rights reserved.
//

#import "GMLiveViewController.h"
#import "GMConfigurationManager.h"
#import "GMViewControllerManager.h"
#import "GMSectionItem.h"
#import "GMLiveViewCell.h"

@interface GMLiveViewController () <UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *mainTableView;
@property (nonatomic, strong) NSArray *dataArray;
@end

@implementation GMLiveViewController

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.dataArray = [[GMConfigurationManager sharedManager] configSubViewItems];
        
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setExtraCellLineHidden:self.mainTableView];
    [self setExtendedCellLineToLeft:self.mainTableView];
    
    [self.mainTableView registerNib:[UINib nibWithNibName:@"GMLiveViewCell" bundle:nil] forCellReuseIdentifier:@"LiveViewCell"];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.dataArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    GMSectionItem *sectionItem = self.dataArray[section];
    return sectionItem.subviews.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    GMLiveViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LiveViewCell"];

    GMSectionItem *sectionItem = self.dataArray[indexPath.section];
    GMSubViewItem *item = sectionItem.subviews[indexPath.row];
    
    cell.displayTitleLabel.text = item.title;
    cell.displayImageView.image = [UIImage imageNamed:item.displayImage];
    
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *customView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.width, 35)];
    customView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    UILabel * headerLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 0, 200, 35)];
    headerLabel.backgroundColor = [UIColor clearColor];
    headerLabel.opaque = NO;
    headerLabel.textColor = [UIColor darkGrayColor];
    headerLabel.font = [UIFont boldSystemFontOfSize:14];
    GMSectionItem *sectionItem = self.dataArray[section];
    headerLabel.text = sectionItem.title;
    [customView addSubview:headerLabel];
    return customView;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    GMSectionItem *sectionItem = self.dataArray[indexPath.section];
    GMSubViewItem *item = sectionItem.subviews[indexPath.row];
    GMViewControllerShared *vc = [[GMViewControllerManager sharedManager] createSubViewControllersWithMenuItem:item];
    [self.navigationController pushViewController:vc animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 35;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        [cell setSeparatorInset:UIEdgeInsetsZero];
    }
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
}
@end
