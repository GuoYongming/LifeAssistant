//
//  GMHistoryEventProvider.m
//  LifeAssistant
//
//  Created by GuoYongming on 2/14/16.
//  Copyright © 2016 GuoYongming. All rights reserved.
//

#import "GMHistoryEventProvider.h"
#import "GMHistoryEvent.h"
#import "NSDate+Helper.h"

@implementation GMHistoryEventProvider
- (instancetype)initWithDelegate:(id<GMDataProviderDelegate>)delegate
{
    self = [super initWithDelegate:delegate];
    if (self) {
        self.historyEvents = [NSMutableArray array];
    }
    return self;
}

- (void)fetchHistoryEventData
{
    NSDictionary *paramas = @{@"key":[GMAccessManager sharedManager].appKey_HistoryToday, @"date":[NSString stringWithFormat:@"%ld/%ld",[NSDate getCurrentMonth],[NSDate getCurrentDay]]};
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    
    __weak GMHistoryEventProvider *weakSelf = self;
    [manager GET:kHistoryEventRequestUrl parameters:paramas progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *resultDictionary = (NSDictionary *)responseObject;
        [weakSelf convertResponseDataToModel:resultDictionary];
        if ([self.delegate respondsToSelector:@selector(requestSuccess:)]) {
            [self.delegate requestSuccess:weakSelf];
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if ([self.delegate respondsToSelector:@selector(requestFailed:)]) {
            [self.delegate requestFailed:weakSelf];
        }
    }];
}

- (void)fetchHistoryEventDetailDataWithEventId:(NSString *)eventId
{
    NSDictionary *paramas = @{@"key":[GMAccessManager sharedManager].appKey_HistoryToday, @"e_id":eventId};
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    
    __weak GMHistoryEventProvider *weakSelf = self;
    [manager GET:kHistoryEventDetalRequestUrl parameters:paramas progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *resultDictionary = (NSDictionary *)responseObject;
        [weakSelf convertEventDetailResponseDataToModel:resultDictionary];
        if ([self.delegate respondsToSelector:@selector(requestSuccess:)]) {
            [self.delegate requestSuccess:weakSelf];
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if ([self.delegate respondsToSelector:@selector(requestFailed:)]) {
            [self.delegate requestFailed:weakSelf];
        }
    }];
}

- (void)convertResponseDataToModel:(NSDictionary *)dictionary
{
    [self.historyEvents removeAllObjects];
    NSArray *eventArray = [dictionary objectForKey:@"result"];
    if (eventArray) {
        for (NSDictionary *eventDic in eventArray) {
            GMHistoryEvent *historyEvent = [[GMHistoryEvent alloc] init];
            historyEvent.eventDay = [eventDic objectForKey:@"day"];
            historyEvent.eventDate = [eventDic objectForKey:@"date"];
            historyEvent.eventId = [eventDic objectForKey:@"e_id"];
            historyEvent.eventTitle = [eventDic objectForKey:@"title"];
            
            [self.historyEvents addObject:historyEvent];
        }
    }
}

- (void)convertEventDetailResponseDataToModel:(NSDictionary *)dictionary
{
    if ([[dictionary objectForKey:@"error_code"] intValue] != 0) {
        [[[UIAlertView alloc] initWithTitle:@"提示" message:@"暂无详细数据" delegate:nil cancelButtonTitle:@"好的" otherButtonTitles:nil, nil] show];
        return;
    }
    NSArray *eventArray = [dictionary objectForKey:@"result"];
    if (eventArray) {
        NSDictionary *eventDic = [eventArray firstObject];
        if (eventDic) {
            GMHistoryEventDetail *eventDetail = [[GMHistoryEventDetail alloc] init];
            eventDetail.eventId = [eventDic objectForKey:@"e_id"];
            eventDetail.eventTitle = [eventDic objectForKey:@"title"];
            eventDetail.eventContent = [eventDic objectForKey:@"content"];
            NSArray *eventPicUrls = [eventDic objectForKey:@"picUrl"];
            if (eventPicUrls) {
                for (NSDictionary *picDic in eventPicUrls) {
                    GMHistoryPicture *pic = [[GMHistoryPicture alloc] init];
                    pic.picId = [picDic objectForKey:@"id"];
                    pic.picTitle = [picDic objectForKey:@"pic_title"];
                    pic.picUrl = [picDic objectForKey:@"url"];
                    [eventDetail.eventPicUrls addObject:pic];
                }
            }
            self.eventDetail = eventDetail;
        }
    }
}
@end
