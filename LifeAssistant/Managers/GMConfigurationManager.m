//
//  GMConfigurationManager.m
//  LifeAssistant
//
//  Created by GuoYongming on 1/22/16.
//  Copyright © 2016 GuoYongming. All rights reserved.
//

#import "GMConfigurationManager.h"
#import "GMMenuItem.h"

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
//    
//    NSString * path = [[NSBundle mainBundle] pathForResource:@"menu" ofType:@"json"];
//    NSData * responseData = [NSData dataWithContentsOfFile:path];
//    NSString *jsonStr = [[NSString alloc] initWithData:responseData encoding:NSUTF8StringEncoding];
//    
//    NSError *err = nil;
//    NSData *data = [jsonStr dataUsingEncoding:NSUTF8StringEncoding];
//    id jsonValue = [NSJSONSerialization JSONObjectWithData:data
//                                                   options:NSJSONReadingMutableContainers|NSJSONReadingMutableLeaves
//                                                     error:&err];
//    
//    if(err){
//        NSLog(@"%@", [err localizedDescription]);
//        return nil;
//    }

    
    
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

@end
