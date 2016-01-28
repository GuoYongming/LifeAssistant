//
//  GMDataProvider.h
//  LifeAssistant
//
//  Created by GuoYongming on 1/28/16.
//  Copyright © 2016 GuoYongming. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"
#import "LifeAssistan-Definition.h"
#import "GMAccessManager.h"

@class GMDataProvider;

@protocol GMDataProviderDelegate <NSObject>

- (void)requestSuccess:(GMDataProvider *)provider;
- (void)requestFailed:(GMDataProvider *)provider;

@end

@interface GMDataProvider : NSObject
@property (nonatomic,weak) id<GMDataProviderDelegate>delegate;

- (instancetype)initWithDelegate:(id<GMDataProviderDelegate>)delegate;
@end
