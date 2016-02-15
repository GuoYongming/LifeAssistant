//
//  GMViewControllerManager.m
//  LifeAssistant
//
//  Created by GuoYongming on 1/22/16.
//  Copyright © 2016 GuoYongming. All rights reserved.
//

#import "GMViewControllerManager.h"

@implementation GMViewControllerManager


+ (GMViewControllerManager *)sharedManager
{
    static GMViewControllerManager *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[GMViewControllerManager alloc] init];
    });
    return sharedInstance;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}
// create tabbar item method
- (GMViewControllerShared *)createMenuViewControllersWithMenuItem:(GMMenuItem *)menuItem
{
    @try {
        NSString * classString = nil;
        if ([menuItem.uiView isEqualToString:@"HomePage"]) {
            classString = @"GMHomeViewController";
        }else if ([menuItem.uiView isEqualToString:@"LivePage"]) {
            classString = @"GMLiveViewController";
        }else if ([menuItem.uiView isEqualToString:@"MallPage"]) {
            classString = @"GMMallViewController";
        }else if ([menuItem.uiView isEqualToString:@"MePage"]) {
            classString = @"GMMeViewController";
        }
        
        Class class = NSClassFromString(classString);
        
        NSString * nibPath = [[NSBundle mainBundle] pathForResource:classString ofType:@"nib"];
        NSString * nibName = nibPath?classString:nil;
        
        GMViewControllerShared * childVC = [[class alloc] initWithNibName:nibName bundle:nil];
        childVC.menuItem = menuItem;
        return childVC;
        
    }
    @catch (NSException *exception) {
        
    }
    @finally {
        
    }
}

// create common view method
- (GMViewControllerShared *)createSubViewControllersWithMenuItem:(GMSubViewItem *)subviewItem
{
    @try {
        NSString * classString = nil;
        if ([subviewItem.uiView isEqualToString:@"PhoneLocation"]) {
            classString = @"GMPhoneLocationViewController";
        }
        else if ([subviewItem.uiView isEqualToString:@"HistoryToday"]){
            classString = @"GMHistoryEventController";
        }
        else if ([subviewItem.uiView isEqualToString:@"AllJokes"]){
            classString = @"GMJokeViewController";
        }
        
        Class class = NSClassFromString(classString);
        
        NSString * nibPath = [[NSBundle mainBundle] pathForResource:classString ofType:@"nib"];
        NSString * nibName = nibPath?classString:nil;
        
        GMViewControllerShared * childVC = [[class alloc] initWithNibName:nibName bundle:nil];
        childVC.subviewItem = subviewItem;
        return childVC;
        
    }
    @catch (NSException *exception) {
        
    }
    @finally {
        
    }
}

@end
