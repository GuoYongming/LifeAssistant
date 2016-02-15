//
//  GMJoke.m
//  LifeAssistant
//
//  Created by GuoYongming on 2/15/16.
//  Copyright © 2016 GuoYongming. All rights reserved.
//

#import "GMJoke.h"

@implementation GMJoke
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.jokeContent = @"";
        self.jokeImageUrl = @"";
        self.jokeUpdateTime = @"";
    }
    return self;
}
@end
