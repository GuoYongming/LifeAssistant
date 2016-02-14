//
//  GMHistoryEventProvider.h
//  LifeAssistant
//
//  Created by GuoYongming on 2/14/16.
//  Copyright © 2016 GuoYongming. All rights reserved.
//

#import "GMDataProvider.h"
#import "GMHistoryEventDetail.h"

@interface GMHistoryEventProvider : GMDataProvider
@property (nonatomic, strong) NSMutableArray *historyEvents;
@property (nonatomic, strong) GMHistoryEventDetail *eventDetail;
- (instancetype)initWithDelegate:(id<GMDataProviderDelegate>)delegate;
- (void)fetchHistoryEventData;
- (void)fetchHistoryEventDetailDataWithEventId:(NSString *)eventId;
@end
