//
//  GMJokeViewController.m
//  LifeAssistant
//
//  Created by GuoYongming on 2/14/16.
//  Copyright © 2016 GuoYongming. All rights reserved.
//

#import "GMJokeViewController.h"
#import "GMLatestJokeCell.h"
#import "GMJokeProvider.h"
#import "GMJoke.h"

@interface GMJokeViewController () <UITableViewDelegate, UITableViewDataSource>
@property (strong, nonatomic) UIScrollView *mainScrollView;
@property (strong, nonatomic) UITableView *latestJokeTableView;
@property (strong, nonatomic) UITableView *latestImageTableView;
@property (strong, nonatomic) GMJokeProvider *jokeProvider;
@end

@implementation GMJokeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.jokeProvider = [[GMJokeProvider alloc] initWithDelegate:self];
    
    UISegmentedControl *segment = [[UISegmentedControl alloc] initWithItems:@[@"最新笑话",@"最新趣图"]];
    segment.frame = CGRectMake(0, 0, 200, 30);
    segment.selectedSegmentIndex = 0;
    segment.tintColor = [UIColor blackColor];
    [segment addTarget:self action:@selector(didChangedSegmentItem:) forControlEvents:UIControlEventValueChanged];
    self.navigationItem.titleView = segment;
}

- (void)initUI
{
    self.mainScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height - self.navigationController.navigationBar.bounds.size.height - 20 - self.tabBarController.tabBar.bounds.size.height)];
    self.mainScrollView.scrollEnabled = NO;
    self.mainScrollView.contentSize = CGSizeMake(self.view.bounds.size.width * 2, 0);
    self.mainScrollView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:self.mainScrollView];
    self.latestJokeTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.mainScrollView.bounds.size.width, self.mainScrollView.bounds.size.height) style:UITableViewStylePlain];
    self.latestJokeTableView.backgroundColor = [UIColor clearColor];
    [self.latestJokeTableView registerNib:[UINib nibWithNibName:@"GMLatestJokeCell" bundle:nil] forCellReuseIdentifier:@"JokeCell"];
    self.latestJokeTableView.delegate = self;
    self.latestJokeTableView.dataSource = self;
    self.latestJokeTableView.estimatedRowHeight = 44.0f;
    self.latestJokeTableView.rowHeight = UITableViewAutomaticDimension;
    [self.mainScrollView addSubview:self.latestJokeTableView];
    
    self.latestImageTableView = [[UITableView alloc] initWithFrame:CGRectMake(self.latestJokeTableView.bounds.size.width, 0, self.mainScrollView.bounds.size.width, self.mainScrollView.bounds.size.height) style:UITableViewStylePlain];
    self.latestImageTableView.backgroundColor = [UIColor clearColor];
    self.latestImageTableView.delegate = self;
    self.latestImageTableView.dataSource = self;
    self.latestImageTableView.estimatedRowHeight = 44.0f;
    self.latestImageTableView.rowHeight = UITableViewAutomaticDimension;
    [self.mainScrollView addSubview:self.latestImageTableView];
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self initUI];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self.jokeProvider fetchHistoryEventDataWithPageNumber:1];
    [self showFullIndicator];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - private methods

- (void)didChangedSegmentItem:(UISegmentedControl *)seg
{
    NSInteger index = seg.selectedSegmentIndex;
    if (index == 0) {
        self.mainScrollView.contentOffset = CGPointMake(0, 0);
    }else{
        self.mainScrollView.contentOffset = CGPointMake(self.latestJokeTableView.bounds.size.width, 0);
    }
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView == self.latestJokeTableView) {
        return self.jokeProvider.jokes.count;
    }else{
        return 0;
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
        return cell;
    }else{
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"JokeImageCell"];
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"JokeImageCell"];
        }
        cell.textLabel.text = @"numberOfRowsInSectionnumberOfRowsInSectionnumberOfRowsInSectionnumberOfRowsInSectionnumberOfRowsInSectionnumberOfRowsInSectionnumberOfRowsInSectionnumberOfRowsInSectionnumberOfRowsInSectionnumberOfRowsInSectionnumberOfRowsInSectionnumberOfRowsInSectionnumberOfRowsInSectionnumberOfRowsInSectionnumberOfRowsInSectionnumberOfRowsInSectionnumberOfRowsInSectionnumberOfRowsInSectionnumberOfRowsInSection";
        return cell;
    }
    return nil;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

- (void)requestSuccess:(GMDataProvider *)provider
{
    [self hideFullIndicator];
    if (provider == self.jokeProvider) {
        [self.latestJokeTableView reloadData];
    }
}

- (void)requestFailed:(GMDataProvider *)provider
{
    [self hideFullIndicator];
}

@end
