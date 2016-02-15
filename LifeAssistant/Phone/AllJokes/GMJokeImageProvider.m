//
//  GMJokeImageProvider.m
//  LifeAssistant
//
//  Created by GuoYongming on 2/15/16.
//  Copyright © 2016 GuoYongming. All rights reserved.
//

#import "GMJokeImageProvider.h"
#import "GMJoke.h"

@implementation GMJokeImageProvider
- (instancetype)initWithDelegate:(id<GMDataProviderDelegate>)delegate
{
    self = [super initWithDelegate:delegate];
    if (self) {
        self.jokeImages = [NSMutableArray array];
    }
    return self;
}

- (void)fetchJokeImagesDataWithPageNumber:(int)pageNumber
{
    NSDictionary *paramas = @{@"key":[GMAccessManager sharedManager].appKey_AllJokes, @"page":[NSNumber numberWithInt:pageNumber], @"pagesize":[NSNumber numberWithInt:5]};
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html", nil];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    
    __weak GMJokeImageProvider *weakSelf = self;
    [manager GET:kAllJokeImageDataRequestUrl parameters:paramas progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
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

- (void)convertResponseDataToModel:(NSDictionary *)dictionary
{
    NSDictionary *resultDic = [dictionary objectForKey:@"result"];
    NSArray *jokeArray = [resultDic objectForKey:@"data"];
    if (jokeArray) {
        for (NSDictionary *jokeDic in jokeArray) {
            GMJoke *joke = [[GMJoke alloc] init];
            joke.jokeContent = [jokeDic objectForKey:@"content"];
            joke.jokeUpdateTime = [jokeDic objectForKey:@"updatetime"];
            joke.jokeImageUrl = [jokeDic objectForKey:@"url"];
            [self.jokeImages addObject:joke];
        }
    }
}
@end
