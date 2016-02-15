//
//  GMJokeProvider.h
//  LifeAssistant
//
//  Created by GuoYongming on 2/15/16.
//  Copyright © 2016 GuoYongming. All rights reserved.
//

#import "GMDataProvider.h"

@interface GMJokeProvider : GMDataProvider
@property (nonatomic,strong) NSMutableArray *jokes;

- (void)fetchJokesDataWithPageNumber:(int)pageNumber;
@end
