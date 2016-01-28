//
//  GMConfigurationManager.h
//  LifeAssistant
//
//  Created by GuoYongming on 1/22/16.
//  Copyright © 2016 GuoYongming. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GMConfigurationManager : NSObject

+ (GMConfigurationManager *)sharedManager;

- (NSArray *)configMenuItems;

- (NSArray *)configSubViewItems;

@end
