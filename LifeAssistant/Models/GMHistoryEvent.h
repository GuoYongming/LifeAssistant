//
//  GMHistoryEvent.h
//  LifeAssistant
//
//  Created by GuoYongming on 2/14/16.
//  Copyright © 2016 GuoYongming. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GMHistoryEvent : NSObject
@property (nonatomic, copy) NSString *eventDay;
@property (nonatomic, copy) NSString *eventDate;
@property (nonatomic, copy) NSString *eventId;
@property (nonatomic, copy) NSString *eventTitle;
@end
