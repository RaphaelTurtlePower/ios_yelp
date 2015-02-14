//
//  SegmentedControlTableViewCell.h
//  Yelp
//
//  Created by Chris Mamuad on 2/13/15.
//  Copyright (c) 2015 codepath. All rights reserved.
//

#import <UIKit/UIKit.h>
@class SegmentedControlTableViewCell;

@protocol SegmentedControlCellDelegate <NSObject>
- (void) segmentedControlTableViewCell: (SegmentedControlTableViewCell *) cell didUpdateValue: (NSString*) segmentValue ;
@end


@interface SegmentedControlTableViewCell : UITableViewCell

@property (nonatomic, weak) id<SegmentedControlCellDelegate> delegate;
- (void) setSelectionArray: (NSArray*) arr;

@end
