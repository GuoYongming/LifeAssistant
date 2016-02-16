//
//  GMPersonIDQueryProvider.h
//  LifeAssistant
//
//  Created by GuoYongming on 2/16/16.
//  Copyright © 2016 GuoYongming. All rights reserved.
//

#import "GMDataProvider.h"
#import "GMPerson.h"
@interface GMPersonIDQueryProvider : GMDataProvider
@property (nonatomic, strong) GMPerson *personID;
- (instancetype)initWithDelegate:(id<GMDataProviderDelegate>)delegate;
- (void)fetchPersonIDDetailInfoDataWithPersonId:(NSString *)personID;
- (void)fetchPersonIDLeakInfoDataWithPersonId:(NSString *)personID;
- (void)fetchPersonIDLossInfoDataWithPersonId:(NSString *)personID;
@end
