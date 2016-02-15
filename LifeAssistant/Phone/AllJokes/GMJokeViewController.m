//
//  GMJokeViewController.m
//  LifeAssistant
//
//  Created by GuoYongming on 2/14/16.
//  Copyright © 2016 GuoYongming. All rights reserved.
//

#import "GMJokeViewController.h"
#import "GMLatestJokeCell.h"
#import "GMJokeImageCell.h"
#import "GMJokeProvider.h"
#import "GMJokeImageProvider.h"
#import "GMJoke.h"
#import "MJRefresh.h"

@interface GMJokeViewController () <UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) UISegmentedControl *segment;
@property (weak, nonatomic) IBOutlet UITableView *latestJokeTableView;
@property (weak, nonatomic) IBOutlet UITableView *latestImageTableView;
@property (strong, nonatomic) GMJokeProvider *jokeProvider;
@property (strong, nonatomic) GMJokeImageProvider *jokeImageProvider;
@property (assign, nonatomic) int currentJokePage;
@property (assign, nonatomic) int currentJokeImagePage;
@property (assign, nonatomic) BOOL isFistLoadJokeImage;
@end

@implementation GMJokeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.jokeProvider = [[GMJokeProvider alloc] initWithDelegate:self];
    self.jokeImageProvider = [[GMJokeImageProvider alloc] initWithDelegate:self];
    self.currentJokePage = 1;
    self.currentJokeImagePage = 1;
    self.isFistLoadJokeImage = YES;
    self.segment = [[UISegmentedControl alloc] initWithItems:@[@"最新笑话",@"最新趣图"]];
    self.segment.frame = CGRectMake(0, 0, 200, 30);
    self.segment.selectedSegmentIndex = 0;
    self.segment.tintColor = [UIColor blackColor];
    [self.segment addTarget:self action:@selector(didChangedSegmentItem:) forControlEvents:UIControlEventValueChanged];
    self.navigationItem.titleView = self.segment;
}

- (void)initUI
{
    [self.latestJokeTableView registerNib:[UINib nibWithNibName:@"GMLatestJokeCell" bundle:nil] forCellReuseIdentifier:@"JokeCell"];
    self.latestJokeTableView.estimatedRowHeight = 44.0f;
    self.latestJokeTableView.rowHeight = UITableViewAutomaticDimension;
    MJRefreshAutoNormalFooter *footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreJokeData)];
    self.latestJokeTableView.mj_footer = footer;
    [self setExtraCellLineHidden:self.latestJokeTableView];
    [self setExtendedCellLineToLeft:self.latestJokeTableView];
    
    [self.latestImageTableView registerNib:[UINib nibWithNibName:@"GMJokeImageCell" bundle:nil] forCellReuseIdentifier:@"JokeImageCell"];
    self.latestImageTableView.estimatedRowHeight = 44.0f;
    self.latestImageTableView.rowHeight = UITableViewAutomaticDimension;
    MJRefreshAutoNormalFooter *footer1 = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreJokeImageData)];
    self.latestImageTableView.mj_footer = footer1;
    [self setExtraCellLineHidden:self.latestImageTableView];
    [self setExtendedCellLineToLeft:self.latestImageTableView];
    
    if (self.segment.selectedSegmentIndex == 0) {
        self.latestJokeTableView.hidden = NO;
        self.latestImageTableView.hidden = YES;
    }else{
        self.latestJokeTableView.hidden = YES;
        self.latestImageTableView.hidden = NO;
    }
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self initUI];
    [self.jokeProvider fetchJokesDataWithPageNumber:self.currentJokePage];
    [self showFullIndicator];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - private methods

- (void)loadMoreJokeData
{
    self.currentJokePage++;
    [self.jokeProvider fetchJokesDataWithPageNumber:self.currentJokePage];
}
- (void)loadMoreJokeImageData
{
    self.currentJokeImagePage++;
    [self.jokeImageProvider fetchJokeImagesDataWithPageNumber:self.currentJokeImagePage];
}

- (void)didChangedSegmentItem:(UISegmentedControl *)seg
{
    if (seg.selectedSegmentIndex == 0) {
        self.latestJokeTableView.hidden = NO;
        self.latestImageTableView.hidden = YES;
    }else{
        if (self.isFistLoadJokeImage) {
            self.isFistLoadJokeImage = NO;
            [self.jokeImageProvider fetchJokeImagesDataWithPageNumber:self.currentJokeImagePage];
            [self showFullIndicator];
        }
        self.latestJokeTableView.hidden = YES;
        self.latestImageTableView.hidden = NO;
    }
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView == self.latestJokeTableView) {
        return self.jokeProvider.jokes.count;
    }else{
        return self.jokeImageProvider.jokeImages.count;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == self.latestJokeTableView) {
        GMLatestJokeCell *cell = [tableView dequeueReusableCellWithIdentifier:@"JokeCell"];
        GMJoke *joke = self.jokeProvider.jokes[indexPath.row];
        cell.contentLabel.text = joke.jokeContent;
        cell.dateLabel.text = joke.jokeUpdateTime;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.backgroundColor = [UIColor groupTableViewBackgroundColor];
        return cell;
    }else{
        GMJokeImageCell *cell = [tableView dequeueReusableCellWithIdentifier:@"JokeImageCell"];
        cell.backgroundColor = [UIColor groupTableViewBackgroundColor];
        GMJoke *joke = self.jokeImageProvider.jokeImages[indexPath.row];
        cell.titleLabel.text = joke.jokeContent;
        cell.updateLabel.text = joke.jokeUpdateTime;
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            NSData *imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:joke.jokeImageUrl]];
            dispatch_async(dispatch_get_main_queue(), ^{
                [cell.contentWebView loadData:imageData MIMEType:@"image/gif" textEncodingName:@"UTF-8" baseURL:nil];
            });
        });
        return cell;
    }
    return nil;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
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

- (void)requestSuccess:(GMDataProvider *)provider
{
    [self hideFullIndicator];
    if (provider == self.jokeProvider) {
        if ([self.latestJokeTableView.mj_footer isRefreshing]) {
            [self.latestJokeTableView.mj_footer endRefreshing];
        }
        [self.latestJokeTableView reloadData];
    }else{
        if ([self.latestImageTableView.mj_footer isRefreshing]) {
            [self.latestImageTableView.mj_footer endRefreshing];
        }
        [self.latestImageTableView reloadData];
    }
}

- (void)requestFailed:(GMDataProvider *)provider
{
    [self hideFullIndicator];
}

@end
