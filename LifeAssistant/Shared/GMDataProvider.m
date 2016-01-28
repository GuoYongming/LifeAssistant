//
//  GMDataProvider.m
//  LifeAssistant
//
//  Created by GuoYongming on 1/28/16.
//  Copyright © 2016 GuoYongming. All rights reserved.
//

#import "GMDataProvider.h"

@implementation GMDataProvider
- (instancetype)initWithDelegate:(id<GMDataProviderDelegate>)delegate
{
    self = [super init];
    if (self) {
        self.delegate = delegate;
    }
    return self;
}
@end
