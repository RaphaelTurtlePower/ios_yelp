//
//  SegmentedControlTableViewCell.m
//  Yelp
//
//  Created by Chris Mamuad on 2/13/15.
//  Copyright (c) 2015 codepath. All rights reserved.
//

#import "SegmentedControlTableViewCell.h"


@interface SegmentedControlTableViewCell ()
@property (weak, nonatomic) IBOutlet UISegmentedControl *segmentedControlInCell;

- (IBAction)segmentControlChanged:(id)sender;
@end

@implementation SegmentedControlTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void) segmentedControlTableViewCell: (SegmentedControlTableViewCell *) cell didUpdateValue: (NSString*) value{
    
}
- (IBAction)segmentControlChanged:(id)sender {
    [self.delegate segmentedControlTableViewCell:self didUpdateValue:[self.segmentedControlInCell titleForSegmentAtIndex:self.segmentedControlInCell.selectedSegmentIndex]];
}

- (void) setSelectionArray: (NSArray*) arr{
    int i=0;
    [self.segmentedControlInCell removeSegmentAtIndex:1 animated:NO];
    [self.segmentedControlInCell removeSegmentAtIndex:0 animated:NO];
    for (NSString* title in arr) {
        [self.segmentedControlInCell insertSegmentWithTitle:title atIndex:i animated:YES];
           i++;
    }
}
@end
