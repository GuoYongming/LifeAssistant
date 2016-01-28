//
//  GMPhoneInfo.m
//  LifeAssistant
//
//  Created by GuoYongming on 1/28/16.
//  Copyright © 2016 GuoYongming. All rights reserved.
//

#import "GMPhoneInfo.h"

@implementation GMPhoneInfo
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.province = @"";
        self.company = @"";
        self.city = @"";
        self.areaCode = @"";
        self.cardType = @"";
        self.zipCode = @"";
    }
    return self;
}
@end
