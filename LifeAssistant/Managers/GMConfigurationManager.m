//
//  GMConfigurationManager.m
//  LifeAssistant
//
//  Created by GuoYongming on 1/22/16.
//  Copyright © 2016 GuoYongming. All rights reserved.
//

#import "GMConfigurationManager.h"
#import "GMMenuItem.h"
#import "GMSubViewItem.h"

@implementation GMConfigurationManager

+ (GMConfigurationManager *)sharedManager
{
    static GMConfigurationManager *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[GMConfigurationManager alloc] init];
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

- (NSArray *)configMenuItems
{
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"menu" ofType:@"json"];
    NSData *jsonData = [[NSData alloc]initWithContentsOfFile:filePath];
    
    NSError *error = nil;
    NSDictionary *menuDictionary = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers | NSJSONReadingMutableLeaves error:&error];
    NSMutableArray *menuItems = [NSMutableArray array];
    if (menuDictionary) {
        NSArray *menuInfoArray = [menuDictionary objectForKey:@"item"];
        for (NSDictionary *menuItem in menuInfoArray) {
            GMMenuItem *item = [[GMMenuItem alloc] init];
            item.menuId = [menuItem objectForKey:@"id"];
            item.title = [menuItem objectForKey:@"title"];
            item.uiView = [menuItem objectForKey:@"uiView"];
            item.defaultImage = [menuItem objectForKey:@"defaultImage"];
            item.selectedImage = [menuItem objectForKey:@"selectedImage"];
            item.params = [menuItem objectForKey:@"params"];
            item.isFistPage = [menuItem objectForKey:@"default"];
            item.type = [menuItem objectForKey:@"type"];
            [menuItems addObject:item];
        }
    }else{
        
    }
    return menuItems;
}

- (NSArray *)configSubViewItems
{
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"LifePageList" ofType:@"json"];
    NSData *jsonData = [[NSData alloc]initWithContentsOfFile:filePath];
    
    NSError *error = nil;
    NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers | NSJSONReadingMutableLeaves error:&error];
    NSMutableArray *items = [NSMutableArray array];
    if (dictionary) {
        NSArray *infoArray = [dictionary objectForKey:@"item"];
        for (NSDictionary *itemDictionaty in infoArray) {
            GMSubViewItem *item = [[GMSubViewItem alloc] init];
            item.subviewId = [itemDictionaty objectForKey:@"id"];
            item.title = [itemDictionaty objectForKey:@"title"];
            item.uiView = [itemDictionaty objectForKey:@"uiView"];
            item.displayImage = [itemDictionaty objectForKey:@"displayImage"];
            item.params = [itemDictionaty objectForKey:@"params"];
            item.type = [itemDictionaty objectForKey:@"type"];
            [items addObject:item];
        }
    }else{
        
    }
    return items;
}

@end
