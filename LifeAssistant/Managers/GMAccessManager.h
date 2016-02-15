//
//  GMAccessManager.h
//  LifeAssistant
//
//  Created by GuoYongming on 1/28/16.
//  Copyright © 2016 GuoYongming. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GMAccessManager : NSObject
@property (nonatomic, copy) NSString *appKey_PhoneLocation;
@property (nonatomic, copy) NSString *appKey_HistoryToday;
@property (nonatomic, copy) NSString *appKey_AllJokes;

+ (GMAccessManager *)sharedManager;

-(BOOL)isValidateEmail:(NSString *)email;
-(BOOL)isValidateMobile:(NSString *)mobile;
-(BOOL)validateCarNo:(NSString *)carNo;

@end
