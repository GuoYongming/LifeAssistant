//
//  GMSectionItem.m
//  LifeAssistant
//
//  Created by GuoYongming on 2/16/16.
//  Copyright © 2016 GuoYongming. All rights reserved.
//

#import "GMSectionItem.h"

@implementation GMSectionItem
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.sectionId = @"";
        self.title = @"";
        self.displayImage = @"";
        self.subviews = [[NSMutableArray alloc] init];
        self.type = @"";
    }
    return self;
}
@end
