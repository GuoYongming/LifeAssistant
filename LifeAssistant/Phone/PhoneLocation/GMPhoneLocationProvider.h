//
//  GMPhoneLocationProvider.h
//  LifeAssistant
//
//  Created by GuoYongming on 1/28/16.
//  Copyright © 2016 GuoYongming. All rights reserved.
//

#import "GMDataProvider.h"
#import "GMPhoneInfo.h"

@interface GMPhoneLocationProvider : GMDataProvider
@property(nonatomic, strong) GMPhoneInfo *phoneInfo;

- (instancetype)initWithDelegate:(id<GMDataProviderDelegate>)delegate;
- (void)fetchPhoneLocationDataWithPhoneNumber:(NSString *)phoneNumber;

@end
