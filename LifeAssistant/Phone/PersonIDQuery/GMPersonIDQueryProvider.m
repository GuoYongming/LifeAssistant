//
//  GMPersonIDQueryProvider.m
//  LifeAssistant
//
//  Created by GuoYongming on 2/16/16.
//  Copyright © 2016 GuoYongming. All rights reserved.
//

#import "GMPersonIDQueryProvider.h"

@implementation GMPersonIDQueryProvider
- (instancetype)initWithDelegate:(id<GMDataProviderDelegate>)delegate
{
    self = [super initWithDelegate:delegate];
    if (self) {
        
    }
    return self;
}

- (void)fetchPersonIDDetailInfoDataWithPersonId:(NSString *)personID
{
    NSDictionary *paramas = @{@"cardno":personID, @"key":[GMAccessManager sharedManager].appKey_PersonID, @"dtype":@"json"};
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    
    __weak GMPersonIDQueryProvider *weakSelf = self;
    [manager GET:kPersonIdDetailInfoRequestUrl parameters:paramas progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *resultDictionary = (NSDictionary *)responseObject;
        weakSelf.personID = [weakSelf convertPersonIDDetailInfoDataToModel:resultDictionary];
        if ([self.delegate respondsToSelector:@selector(requestSuccess:)]) {
            [self.delegate requestSuccess:weakSelf];
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        weakSelf.personID = nil;
        if ([self.delegate respondsToSelector:@selector(requestFailed:)]) {
            [self.delegate requestFailed:weakSelf];
        }
    }];
}

- (GMPerson *)convertPersonIDDetailInfoDataToModel:(NSDictionary *)dictionary
{
    NSString *error_code = [dictionary objectForKey:@"error_code"];
    if ([error_code intValue] != 0) {
        [[[UIAlertView alloc] initWithTitle:@"提示" message:@"暂无您要查询的信息" delegate:nil cancelButtonTitle:@"好的" otherButtonTitles:nil, nil] show];
        return nil;
    }
    
    GMPerson *persionID = [[GMPerson alloc] init];
    NSDictionary *infoDictionary = [dictionary objectForKey:@"result"];
    if (infoDictionary) {
        persionID.personArea = [infoDictionary objectForKey:@"area"];
        persionID.personSex = [infoDictionary objectForKey:@"sex"];
        persionID.personBirthday = [infoDictionary objectForKey:@"birthday"];
    }
    return persionID;
}


- (void)fetchPersonIDLeakInfoDataWithPersonId:(NSString *)personID
{
    NSDictionary *paramas = @{@"cardno":personID, @"key":[GMAccessManager sharedManager].appKey_PersonID, @"dtype":@"json"};
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    
    __weak GMPersonIDQueryProvider *weakSelf = self;
    [manager GET:kPersonIdLeakInfoRequestUrl parameters:paramas progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *resultDictionary = (NSDictionary *)responseObject;
        weakSelf.personID = [weakSelf convertPersonIDLeakInfoDataToModel:resultDictionary];
        if ([self.delegate respondsToSelector:@selector(requestSuccess:)]) {
            [self.delegate requestSuccess:weakSelf];
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        weakSelf.personID = nil;
        if ([self.delegate respondsToSelector:@selector(requestFailed:)]) {
            [self.delegate requestFailed:weakSelf];
        }
    }];
}

- (GMPerson *)convertPersonIDLeakInfoDataToModel:(NSDictionary *)dictionary
{
    NSString *error_code = [dictionary objectForKey:@"error_code"];
    if ([error_code intValue] != 0) {
        [[[UIAlertView alloc] initWithTitle:@"提示" message:@"暂无您要查询的信息" delegate:nil cancelButtonTitle:@"好的" otherButtonTitles:nil, nil] show];
        return nil;
    }
    
    GMPerson *persionID = [[GMPerson alloc] init];
    NSDictionary *infoDictionary = [dictionary objectForKey:@"result"];
    if (infoDictionary) {
        persionID.personIDLeak = [infoDictionary objectForKey:@"tips"];
    }
    return persionID;
}

- (void)fetchPersonIDLossInfoDataWithPersonId:(NSString *)personID
{
    NSDictionary *paramas = @{@"cardno":personID, @"key":[GMAccessManager sharedManager].appKey_PersonID, @"dtype":@"json"};
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    
    __weak GMPersonIDQueryProvider *weakSelf = self;
    [manager GET:kPersonIdLossInfoRequestUrl parameters:paramas progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *resultDictionary = (NSDictionary *)responseObject;
        weakSelf.personID = [weakSelf convertPersonIDLossInfoDataToModel:resultDictionary];
        if ([self.delegate respondsToSelector:@selector(requestSuccess:)]) {
            [self.delegate requestSuccess:weakSelf];
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        weakSelf.personID = nil;
        if ([self.delegate respondsToSelector:@selector(requestFailed:)]) {
            [self.delegate requestFailed:weakSelf];
        }
    }];
}

- (GMPerson *)convertPersonIDLossInfoDataToModel:(NSDictionary *)dictionary
{
    NSString *error_code = [dictionary objectForKey:@"error_code"];
    if ([error_code intValue] != 0) {
        [[[UIAlertView alloc] initWithTitle:@"提示" message:@"暂无您要查询的信息" delegate:nil cancelButtonTitle:@"好的" otherButtonTitles:nil, nil] show];
        return nil;
    }
    
    GMPerson *persionID = [[GMPerson alloc] init];
    NSDictionary *infoDictionary = [dictionary objectForKey:@"result"];
    if (infoDictionary) {
        persionID.personIDLoss = [infoDictionary objectForKey:@"tips"];
    }
    return persionID;
}

@end
