//
//  GMHistoryEvent.m
//  LifeAssistant
//
//  Created by GuoYongming on 2/14/16.
//  Copyright © 2016 GuoYongming. All rights reserved.
//

#import "GMHistoryEvent.h"

@implementation GMHistoryEvent
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.eventId = @"";
        self.eventDate = @"";
        self.eventDay = @"";
        self.eventTitle = @"";
        
    }
    return self;
}
@end
