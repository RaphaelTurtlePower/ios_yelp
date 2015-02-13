//
//  FiltersViewController.h
//  Yelp
//
//  Created by Chris Mamuad on 2/13/15.
//  Copyright (c) 2015 codepath. All rights reserved.
//

#import <UIKit/UIKit.h>

@class FiltersViewController;

@protocol FiltersViewControllerDelegate <NSObject>
- (void) filtersViewController: (FiltersViewController *) filtersViewController didChangeFilters: (NSDictionary *) filters;
@end

@interface FiltersViewController : UITableViewController

@property (nonatomic, weak) id<FiltersViewControllerDelegate> delegate;

@end
