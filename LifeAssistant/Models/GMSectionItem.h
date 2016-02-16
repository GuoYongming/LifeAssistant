//
//  GMSectionItem.h
//  LifeAssistant
//
//  Created by GuoYongming on 2/16/16.
//  Copyright © 2016 GuoYongming. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GMSectionItem : NSObject
@property (nonatomic, copy) NSString *sectionId;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *displayImage;
@property (nonatomic, copy) NSString *type;
@property (nonatomic, strong) NSMutableArray *subviews;
@end
