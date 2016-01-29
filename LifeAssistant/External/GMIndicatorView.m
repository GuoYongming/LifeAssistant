//
//  GMIndicatorView.m
//  LifeAssistant
//
//  Created by GuoYongming on 1/29/16.
//  Copyright © 2016 GuoYongming. All rights reserved.
//

#import "GMIndicatorView.h"

@implementation GMIndicatorView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        UIView *blackView = [[UIView alloc] initWithFrame:CGRectMake(frame.size.width/2-40, frame.size.height/2-40, 80, 80)];
        blackView.backgroundColor = [UIColor blackColor];
        blackView.alpha = 0.5;
        blackView.layer.cornerRadius = 10;
        blackView.layer.masksToBounds = YES;
        [self addSubview:blackView];
        
        UIActivityIndicatorView *indicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
        indicator.frame = CGRectMake((frame.size.width-37)/2, (frame.size.height-37)/2, 37, 37);
        [indicator startAnimating];
        [self addSubview:indicator];
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
