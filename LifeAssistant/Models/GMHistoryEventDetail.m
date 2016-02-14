//
//  GMHistoryEventDetail.m
//  LifeAssistant
//
//  Created by GuoYongming on 2/14/16.
//  Copyright © 2016 GuoYongming. All rights reserved.
//

#import "GMHistoryEventDetail.h"

@implementation GMHistoryEventDetail
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.eventContent = @"";
        self.eventId = @"";
        self.eventTitle = @"";
        self.eventPicUrls = [NSMutableArray array];
    }
    return self;
}
@end


@implementation GMHistoryPicture

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.picId = @"";
        self.picTitle = @"";
        self.picUrl = @"";
    }
    return self;
}

@end