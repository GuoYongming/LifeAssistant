//
//  GMJokeImageProvider.h
//  LifeAssistant
//
//  Created by GuoYongming on 2/15/16.
//  Copyright © 2016 GuoYongming. All rights reserved.
//

#import "GMDataProvider.h"

@interface GMJokeImageProvider : GMDataProvider
@property (nonatomic,strong) NSMutableArray *jokeImages;

- (void)fetchJokeImagesDataWithPageNumber:(int)pageNumber;
@end
