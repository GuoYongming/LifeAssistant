//
//  GMViewControllerShared.h
//  LifeAssistant
//
//  Created by GuoYongming on 1/22/16.
//  Copyright © 2016 GuoYongming. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GMMenuItem.h"
#import "GMSubViewItem.h"
#import "GMDataProvider.h"
#import "GMIndicatorView.h"
#import "UIView+Frame.h"

@interface GMViewControllerShared : UIViewController <GMDataProviderDelegate>
@property (nonatomic, strong) GMMenuItem *menuItem;
@property (nonatomic, strong) GMSubViewItem *subviewItem;

- (void)showFullIndicator;
- (void)hideFullIndicator;
- (void)setExtraCellLineHidden:(UITableView *)tableView;
- (void)setExtendedCellLineToLeft:(UITableView *)tableView;
@end
