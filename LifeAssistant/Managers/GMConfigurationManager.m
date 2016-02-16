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
#import "GMSectionItem.h"

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
        for (NSDictionary *sectionDictionaty in infoArray) {
            GMSectionItem *sectionItem = [[GMSectionItem alloc] init];
            sectionItem.sectionId = [sectionDictionaty objectForKey:@"id"];
            sectionItem.title = [sectionDictionaty objectForKey:@"title"];
            sectionItem.displayImage = [sectionDictionaty objectForKey:@"displayImage"];
            sectionItem.type = [sectionDictionaty objectForKey:@"type"];
            NSArray *subviews = [sectionDictionaty objectForKey:@"items"];
            if (subviews && subviews.count > 0) {
                for (NSDictionary *itemDictionary in subviews) {
                    GMSubViewItem *item = [[GMSubViewItem alloc] init];
                    item.subviewId = [itemDictionary objectForKey:@"id"];
                    item.title = [itemDictionary objectForKey:@"title"];
                    item.uiView = [itemDictionary objectForKey:@"uiView"];
                    item.displayImage = [itemDictionary objectForKey:@"displayImage"];
                    item.params = [itemDictionary objectForKey:@"params"];
                    item.type = [itemDictionary objectForKey:@"type"];
                    [sectionItem.subviews addObject:item];
                }
            }
            [items addObject:sectionItem];
        }
    }else{
        
    }
    return items;
}

@end
