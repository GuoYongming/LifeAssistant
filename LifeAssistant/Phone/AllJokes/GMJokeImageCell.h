//
//  GMJokeImageCell.h
//  LifeAssistant
//
//  Created by GuoYongming on 2/15/16.
//  Copyright © 2016 GuoYongming. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GMJokeImageCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIWebView *contentWebView;
@property (weak, nonatomic) IBOutlet UILabel *updateLabel;

@end
