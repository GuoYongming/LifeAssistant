//
//  GMHistoryEventDetailController.m
//  LifeAssistant
//
//  Created by GuoYongming on 2/14/16.
//  Copyright © 2016 GuoYongming. All rights reserved.
//

#import "GMHistoryEventDetailController.h"
#import "GMHistoryEventProvider.h"
#import "GMHistoryViewCell.h"
#import "UIImageView+AFNetworking.h"

@interface GMHistoryEventDetailController () <UICollectionViewDataSource, UICollectionViewDelegate>
@property (nonatomic, strong) GMHistoryEventProvider *eventDetailProvider;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;
@property (weak, nonatomic) IBOutlet UICollectionView *imageCollectionView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *imageCollectionViewHeight;

@end

@implementation GMHistoryEventDetailController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = self.eventTitle;
    self.eventDetailProvider = [[GMHistoryEventProvider alloc] initWithDelegate:self];
    [self.imageCollectionView registerNib:[UINib nibWithNibName:@"GMHistoryViewCell" bundle:nil] forCellWithReuseIdentifier:@"HistoryCell"];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
}
- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    if (self.eventId) {
        [self.eventDetailProvider fetchHistoryEventDetailDataWithEventId:self.eventId];
        [self showFullIndicator];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)refreshUI
{
    self.contentLabel.text = self.eventDetailProvider.eventDetail.eventContent;
    if (self.eventDetailProvider.eventDetail.eventPicUrls.count > 0) {
        self.imageCollectionViewHeight.constant = 100;
    }
    [self.imageCollectionView reloadData];
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.eventDetailProvider.eventDetail.eventPicUrls.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    GMHistoryViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"HistoryCell" forIndexPath:indexPath];
    GMHistoryPicture *pic = self.eventDetailProvider.eventDetail.eventPicUrls[indexPath.row];
    [cell.displayImageView setImageWithURL:[NSURL URLWithString:pic.picUrl] placeholderImage:nil];
//    __weak GMHistoryEventDetailController *weakSelf = self;
//    [cell.displayImageView setImageWithURLRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:pic.picUrl]] placeholderImage:nil success:nil failure:^(NSURLRequest * _Nonnull request, NSHTTPURLResponse * _Nullable response, NSError * _Nonnull error) {
//        weakSelf.imageCollectionViewHeight.constant = 0;
//    }];
    return cell;
}

#pragma mark - GMDataProviderDelegate

- (void)requestSuccess:(GMDataProvider *)provider
{
    [self hideFullIndicator];
    if (provider == self.eventDetailProvider) {
        [self refreshUI];
    }
}

- (void)requestFailed:(GMDataProvider *)provider
{
    [self hideFullIndicator];
}

@end
