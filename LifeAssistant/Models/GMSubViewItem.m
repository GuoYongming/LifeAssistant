//
//  GMSubViewItem.m
//  LifeAssistant
//
//  Created by GuoYongming on 1/28/16.
//  Copyright © 2016 GuoYongming. All rights reserved.
//

#import "GMSubViewItem.h"

@implementation GMSubViewItem
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.subviewId = @"";
        self.title = @"";
        self.uiView = @"";
        self.displayImage = @"";
        self.params = [[NSArray alloc] init];
        self.type = @"";
    }
    return self;
}
@end
