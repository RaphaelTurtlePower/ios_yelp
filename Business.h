//
//  Business.h
//  Yelp
//
//  Created by Chris Mamuad on 2/12/15.
//  Copyright (c) 2015 codepath. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Business : NSObject
@property (nonatomic, strong) NSString *imageUrl;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *ratingImageUrl;
@property (nonatomic, strong) NSString *categories;
@property (nonatomic, strong) NSString *address;
@property (nonatomic, assign) NSInteger numReviews;
@property (nonatomic, assign) CGFloat distance;

+ (NSArray*) businessesWithDictionaries: (NSArray *) dictionaries;
@end
