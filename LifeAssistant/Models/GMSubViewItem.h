//
//  GMSubViewItem.h
//  LifeAssistant
//
//  Created by GuoYongming on 1/28/16.
//  Copyright © 2016 GuoYongming. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GMSubViewItem : NSObject
@property (nonatomic, copy) NSString *subviewId;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *uiView;
@property (nonatomic, copy) NSString *displayImage;
@property (nonatomic, copy) NSString *type;
@property (nonatomic, strong) NSArray *params;
@end
