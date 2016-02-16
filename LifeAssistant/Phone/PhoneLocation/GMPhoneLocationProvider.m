//
//  GMPhoneLocationProvider.m
//  LifeAssistant
//
//  Created by GuoYongming on 1/28/16.
//  Copyright © 2016 GuoYongming. All rights reserved.
//

#import "GMPhoneLocationProvider.h"

@implementation GMPhoneLocationProvider
- (instancetype)initWithDelegate:(id<GMDataProviderDelegate>)delegate
{
    self = [super initWithDelegate:delegate];
    if (self) {
        
    }
    return self;
}

- (void)fetchPhoneLocationDataWithPhoneNumber:(NSString *)phoneNumber
{
    NSString *number = [phoneNumber stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    if (![[GMAccessManager sharedManager] isValidateMobile:number]) {
        [[[UIAlertView alloc] initWithTitle:@"提示" message:@"请输入正确的手机号码" delegate:nil cancelButtonTitle:@"好的" otherButtonTitles:nil, nil] show];
        return;
    }
    
    NSDictionary *paramas = @{@"phone":number, @"key":[GMAccessManager sharedManager].appKey_PhoneLocation};
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    
    __weak GMPhoneLocationProvider *weakSelf = self;
    [manager GET:kPhoneLocationRequestUrl parameters:paramas progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *resultDictionary = (NSDictionary *)responseObject;
        weakSelf.phoneInfo = [weakSelf convertResponseDataToModel:resultDictionary];
        if ([self.delegate respondsToSelector:@selector(requestSuccess:)]) {
            [self.delegate requestSuccess:weakSelf];
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        weakSelf.phoneInfo = nil;
        if ([self.delegate respondsToSelector:@selector(requestFailed:)]) {
            [self.delegate requestFailed:weakSelf];
        }
    }];
}

- (GMPhoneInfo *)convertResponseDataToModel:(NSDictionary *)dictionary
{
    GMPhoneInfo *phoneInfo = [[GMPhoneInfo alloc] init];
    NSDictionary *infoDictionary = [dictionary objectForKey:@"result"];
    if (infoDictionary) {
        phoneInfo.province = [infoDictionary objectForKey:@"province"];
        phoneInfo.city = [infoDictionary objectForKey:@"city"];
        phoneInfo.company = [infoDictionary objectForKey:@"company"];
        phoneInfo.areaCode = [infoDictionary objectForKey:@"areacode"];
        phoneInfo.cardType = [infoDictionary objectForKey:@"card"];
        phoneInfo.zipCode = [infoDictionary objectForKey:@"zip"];
    }
    return phoneInfo;
}
@end
