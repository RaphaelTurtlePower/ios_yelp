//
//  Business.m
//  Yelp
//
//  Created by Chris Mamuad on 2/12/15.
//  Copyright (c) 2015 codepath. All rights reserved.
//

#import "Business.h"

@implementation Business

- (id) initWithDictionary:(NSDictionary* ) dictionary {
    self = [super init];
    if (self){
        
        NSMutableArray *categoryNames = [NSMutableArray array];
        self.categories = [categoryNames componentsJoinedByString:@", "];
        self.name = dictionary[@"name"];
        self.imageUrl = dictionary[@"image_url"];
        NSArray *streetAddress =[dictionary valueForKeyPath:@"location.address"];
         NSString *street = @"";
        if([streetAddress count] > 0){
            street = streetAddress[0];
        }
       
        NSString *neighborhood = @"";
        NSArray *nb = [dictionary valueForKeyPath:@"location.neighborhoods"];
        if([nb count] > 0){
            neighborhood = nb[0];
        }
        self.address = [NSString stringWithFormat:@"%@, %@", street, neighborhood];
        self.numReviews = [dictionary[@"review_count"] integerValue];
        self.ratingImageUrl = dictionary[@"rating_img_url"];
        float milesPerMeter = 0.000621371;
        self.distance = [dictionary[@"distance"] integerValue] * milesPerMeter;
        
    }
    return self;
}


+ (NSArray*) businessesWithDictionaries: (NSArray *) dictionaries{
    NSMutableArray* businesses = [NSMutableArray array];
    for(NSDictionary *dictionary in dictionaries){
        Business *business = [[Business alloc] initWithDictionary:dictionary];
        [businesses addObject:business];
    }
    return businesses;

}

@end
