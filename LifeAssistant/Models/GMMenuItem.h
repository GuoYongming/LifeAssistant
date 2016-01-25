//
//  GMMenuItem.h
//  LifeAssistant
//
//  Created by GuoYongming on 1/22/16.
//  Copyright © 2016 GuoYongming. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GMMenuItem : NSObject

@property (nonatomic, copy) NSString *menuId;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *uiView;
@property (nonatomic, copy) NSString *defaultImage;
@property (nonatomic, copy) NSString *selectedImage;
@property (nonatomic, copy) NSString *type;
@property (nonatomic, assign) BOOL isFistPage;
@property (nonatomic, strong) NSArray *params;

@end
