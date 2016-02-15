//
//  GMHistoryEventController.m
//  LifeAssistant
//
//  Created by GuoYongming on 2/14/16.
//  Copyright © 2016 GuoYongming. All rights reserved.
//

#import "GMHistoryEventController.h"
#import "GMHistoryEventProvider.h"
#import "GMHistoryEvent.h"
#import "GMHistoryEventDetailController.h"

@interface GMHistoryEventController () <UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) GMHistoryEventProvider *eventProvider;
@property (weak, nonatomic) IBOutlet UITableView *mainTableView;

@end

@implementation GMHistoryEventController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"历史上的今天";
    [self setExtraCellLineHidden:self.mainTableView];
    [self setExtendedCellLineToLeft:self.mainTableView];
    
    self.eventProvider = [[GMHistoryEventProvider alloc] initWithDelegate:self];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self.eventProvider fetchHistoryEventData];
    [self showFullIndicator];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.eventProvider.historyEvents.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"historyCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier];
    }
    GMHistoryEvent *event = [self.eventProvider.historyEvents objectAtIndex:indexPath.row];
    cell.textLabel.text = event.eventTitle;
    cell.detailTextLabel.text = event.eventDate;
    cell.detailTextLabel.textColor = [UIColor grayColor];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    return 54;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    GMHistoryEvent *event = [self.eventProvider.historyEvents objectAtIndex:indexPath.row];
    GMHistoryEventDetailController *detailController = [[GMHistoryEventDetailController alloc] init];
    detailController.eventId = event.eventId;
    detailController.eventTitle = event.eventTitle;
    [self.navigationController pushViewController:detailController animated:YES];
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        cell.separatorInset = UIEdgeInsetsZero;
    }
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        cell.layoutMargins = UIEdgeInsetsZero;
    }
}
#pragma mark - GMDataProviderDelegate

- (void)requestSuccess:(GMDataProvider *)provider
{
    [self hideFullIndicator];
    if (provider == self.eventProvider) {
        [self.mainTableView reloadData];
    }
}

- (void)requestFailed:(GMDataProvider *)provider
{
    [self hideFullIndicator];
}

@end
