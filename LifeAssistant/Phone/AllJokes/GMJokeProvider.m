//
//  GMJokeProvider.m
//  LifeAssistant
//
//  Created by GuoYongming on 2/15/16.
//  Copyright © 2016 GuoYongming. All rights reserved.
//

#import "GMJokeProvider.h"
#import "GMJoke.h"

@implementation GMJokeProvider
- (instancetype)initWithDelegate:(id<GMDataProviderDelegate>)delegate
{
    self = [super initWithDelegate:delegate];
    if (self) {
        self.jokes = [NSMutableArray array];
    }
    return self;
}

- (void)fetchHistoryEventDataWithPageNumber:(int)pageNumber
{
    NSDictionary *paramas = @{@"key":[GMAccessManager sharedManager].appKey_AllJokes, @"page":[NSNumber numberWithInt:pageNumber], @"pagesize":[NSNumber numberWithInt:20]};
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html", nil];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    
    __weak GMJokeProvider *weakSelf = self;
    [manager GET:kAllJokesDataRequestUrl parameters:paramas progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *resultDictionary = (NSDictionary *)responseObject;
        [weakSelf convertResponseDataToModel:resultDictionary];
        if ([self.delegate respondsToSelector:@selector(requestSuccess:)]) {
            [self.delegate requestSuccess:weakSelf];
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"jokeerror = %@",error.localizedDescription);
        if ([self.delegate respondsToSelector:@selector(requestFailed:)]) {
            [self.delegate requestFailed:weakSelf];
        }
    }];
}

- (void)convertResponseDataToModel:(NSDictionary *)dictionary
{
    NSDictionary *resultDic = [dictionary objectForKey:@"result"];
    NSArray *jokeArray = [resultDic objectForKey:@"data"];
    if (jokeArray) {
        for (NSDictionary *jokeDic in jokeArray) {
            GMJoke *joke = [[GMJoke alloc] init];
            joke.jokeContent = [jokeDic objectForKey:@"content"];
            joke.jokeUpdateTime = [jokeDic objectForKey:@"updatetime"];
            
            [self.jokes addObject:joke];
        }
    }
}
@end
