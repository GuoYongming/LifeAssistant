//
//  GMPerson.m
//  LifeAssistant
//
//  Created by GuoYongming on 2/16/16.
//  Copyright © 2016 GuoYongming. All rights reserved.
//

#import "GMPerson.h"

@implementation GMPerson
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.personArea = @"";
        self.personSex = @"";
        self.personBirthday = @"";
        self.personIDLeak = @"";
        self.personIDLoss = @"";
    }
    return self;
}
@end
