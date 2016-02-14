//
//  GMHistoryEventDetail.h
//  LifeAssistant
//
//  Created by GuoYongming on 2/14/16.
//  Copyright © 2016 GuoYongming. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GMHistoryEventDetail : NSObject
@property (nonatomic, strong) NSMutableArray *eventPicUrls;
@property (nonatomic, copy) NSString *eventContent;
@property (nonatomic, copy) NSString *eventId;
@property (nonatomic, copy) NSString *eventTitle;
@end


@interface GMHistoryPicture : NSObject
@property (nonatomic, copy) NSString *picUrl;
@property (nonatomic, copy) NSString *picId;
@property (nonatomic, copy) NSString *picTitle;
@end