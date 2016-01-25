//
//  GMMenuItem.m
//  LifeAssistant
//
//  Created by GuoYongming on 1/22/16.
//  Copyright © 2016 GuoYongming. All rights reserved.
//

#import "GMMenuItem.h"

@implementation GMMenuItem
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.menuId = @"";
        self.title = @"";
        self.uiView = @"";
        self.defaultImage = @"";
        self.selectedImage = @"";
        self.params = [[NSArray alloc] init];
        self.isFistPage = NO;
        self.type = @"";
    }
    return self;
}
@end
