//
//  GMViewControllerManager.h
//  LifeAssistant
//
//  Created by GuoYongming on 1/22/16.
//  Copyright © 2016 GuoYongming. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GMViewControllerShared.h"
#import "GMNavigationController.h"
#import "GMSubViewItem.h"

@interface GMViewControllerManager : NSObject
+ (GMViewControllerManager *)sharedManager;
- (GMViewControllerShared *)createMenuViewControllersWithMenuItem:(GMMenuItem *)menuItem;
- (GMViewControllerShared *)createSubViewControllersWithMenuItem:(GMSubViewItem *)subviewItem;
@end
